# Copyright 2024 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

# There is a few assumptions that might requiring checking when using this on new designs:
# - All resets are active low

# Non-labeled single-bit data memories are not yet supported

from itertools import permutations, product, combinations
import re
import os
import subprocess
from enum import Enum, auto
import multiprocessing as mp
import sys

# Tolerate using the native reset instead of a taint meta-reset. This might allow boosting the performance even beyond the results that we reported in the paper.
TOLERATE_NATIVE_RST = True
NATIVE_RST_SIGNAL_SUBSTR = "rst" # We identify the reset signal by name.

# This global var might be modified by the arguments provided to the script.
is_manual_annotation = False

tmp_dir_path = "tmp"
os.makedirs(tmp_dir_path, exist_ok=True)

def __mystrhash(s: str):
    return hex(hash(s))[2:10]

#######################
# Instrument individual memory modules
#######################

# Assume that a memory has at least 8 entries. Extremely small memories are less interesting for HybriDIFT.
MIN_ADDR_WIDTH = 3
LATENCY_OFFSET = 9 # Must be changed if the input sequence is different.

DO_TRACE = True
NUM_PROCESSES_FOR_BUILD = 32
TAINT_META_RESET_PORT_NAME_PREFIX = "taint_meta_reset"
CELLIFT_NOINSTRUMENT_ATTR = "cellift_noinstrument"

def __signal_to_taint_signal_name(signal_name: str):
    return f"{signal_name}_t0"

class PortRole(Enum):
    INPUT_DATA = auto()
    READ_ADDRESS_SIGNAL = auto()
    WRITE_ADDRESS_SIGNAL = auto()
    COMBINED_ADDRESS_SIGNAL = auto()
    BYTE_ENABLE_SIGNAL = auto()
    WRITE_ENABLE = auto()
    READ_ENABLE = auto()
    ENABLE = auto()
    WRITE_MASK = auto()
    WRITE_MODE = auto()
ALL_PORT_ROLES = list(PortRole)

def __run_input_sequence(module_name, input_seq_id, input_seq):
    os.makedirs(f"{tmp_dir_path}/dv_{__mystrhash(module_name)}", exist_ok=True)
    input_file_path = f"{tmp_dir_path}/dv_{__mystrhash(module_name)}/input_sequence_{input_seq_id}.txt"
    with open(input_file_path, "w") as f:
        # # Start by writing the number of steps
        # f.write(f"{len(input_seq)}\n")

        for input_vector in input_seq:
            f.write(" ".join([str(input_bit) for input_bit in input_vector]) + "\n")

    # Set the environment
    new_env = os.environ.copy()
    new_env["PATH_TO_SRAM_PROTO_INPUT_FILE"] = input_file_path

    if DO_TRACE:
        new_env["TRACEFILE"] = f"./{tmp_dir_path}/dv_{__mystrhash(module_name)}/trace_{input_seq_id}.fst"

    # Execute the Verilator model
    outputs = subprocess.run([f"./{tmp_dir_path}/obj_dir_{__mystrhash(module_name)}/Vmemory", "--trace" if DO_TRACE else "", "--trace-fst" if DO_TRACE else ""], env=new_env, capture_output=True, text=True)
    return outputs.stdout

# Returns True iff the assignment is correct as a first return value, and the latency as a second return value.
def __analyze_output_validity_and_latency(output) -> bool:
    output_lines = list(filter(lambda s: s.startswith("Output at cycle"), output.split("\n")))

    seq_of_distinct_outputs = []
    seq_of_all_outputs = []
    for line in output_lines:
        candidate_next_output = [int(s) for s in line.split(": ")[1].split()]
        assert len(candidate_next_output) == 1, f"The length of the output should be 1 but it is {len(candidate_next_output)}"
        candidate_next_output = candidate_next_output[0]

        # Validity
        seq_of_all_outputs.append(candidate_next_output)
        if not seq_of_distinct_outputs or candidate_next_output != seq_of_distinct_outputs[-1]:
            seq_of_distinct_outputs.append(candidate_next_output)

    is_valid_memory = seq_of_distinct_outputs == [0b10, 0b11, 0b10, 0b11]
    # Useful if the output during a write is the written value
    is_valid_memory_secondary = seq_of_distinct_outputs == [0b10, 0b11, 0b10, 0b11, 0b10, 0b11]

    # Latency
    if not is_valid_memory and not is_valid_memory_secondary:
        return False, False, None

    # Get the occurrence of 170 once 238 already happened
    if is_valid_memory:
        is_0b11_met = False
        for cycle_id, output in enumerate(seq_of_all_outputs):
            if output == 0b11:
                is_0b11_met = True
            if is_0b11_met and output == 0b10:
                return True, False, cycle_id-LATENCY_OFFSET
    else:
        is_0b11_met = False
        for cycle_id, output in enumerate(seq_of_all_outputs):
            if output == 0b11:
                is_0b11_met = True
            if is_0b11_met and output == 0b10:
                return False, True, cycle_id-LATENCY_OFFSET

    raise ValueError("The output is valid but the latency is not found. This should not happen.")

# Success primary: The memory is correct and a write action does not change the output value
# Success secondary: The memory is correct but a write action changes the output value
def __analysis_exec_worker(module_name, input_seq_id, input_seq):
    output_stdout = __run_input_sequence(module_name, input_seq_id, input_seq)
    is_success, is_success_secondary, latency = __analyze_output_validity_and_latency(output_stdout)
    return is_success, is_success_secondary, latency

# @param module_content_post_yosys_lines includes the functions
# @param module_annotations a list of tuples (port_name, role_str, signal_width)
def __analyze_sram_roles_and_latency(module_name: str, module_content_post_yosys_lines: str, module_annotations: list):

    def gen_bitmask(width):
        assert width <= 64, f"The width should be at most 64 but it is {width}"
        return (1 << width) - 1

    def remove_functions(module_content_post_sv2v_lines):
        # Remove functions from the module content. A function starts with a line starting with the word "function" and ends with a line "endfunction".
        # We remove the function lines and the lines in between.
        function_start_line_ids = [line_id for line_id in range(len(module_content_post_sv2v_lines)) if module_content_post_sv2v_lines[line_id].lstrip().startswith("function")]
        function_end_line_ids = [line_id for line_id in range(len(module_content_post_sv2v_lines)) if module_content_post_sv2v_lines[line_id].lstrip().startswith("endfunction")]

        assert len(function_start_line_ids) == len(function_end_line_ids), "The number of function starts and ends should be the same"
        # Ensure that they are staggered
        assert all(function_start_line_id < function_end_line_id for function_start_line_id, function_end_line_id in zip(function_start_line_ids, function_end_line_ids)), "The function starts and ends should be staggered"

        # We remove the function lines and the lines in between.
        for function_start_line_id, function_end_line_id in zip(function_start_line_ids, function_end_line_ids):
            module_content_post_sv2v_lines = module_content_post_sv2v_lines[:function_start_line_id] + module_content_post_sv2v_lines[function_end_line_id+1:]
        return module_content_post_sv2v_lines

    # We form a dict of clock signal, input signals and output signals. The reset signal is identified separately.
    def identify_signal_syncs_and_directions(module_content_post_yosys_lines):
        # Identify the clock signals as occurrences of "posedge signame", and the reset signals as occurrences of "negedge signame"
        clock_signals = set()
        for line in module_content_post_yosys_lines:
            if "posedge" in line:
                clock_signals.add(re.search(r"posedge (\w+)", line).group(1))
        assert len(clock_signals) >= 1, f"There is expected to be at least one clock signal. Got {len(clock_signals)}: {clock_signals}"

        if len(clock_signals) > 1:
            print(f"WARNING: ensure that all clocks are connected. Otherwise, multiple independent clocks are not supported at the moment.")

        # Is this comment outdated?
        # CellIFT makes all resets synchronous due to legacy tool limitations.
        # We identify the reset signal as a signal that looks like:
        # always_ff @(posedge Clk_CI)
        # if (_083_)
        #   if (!Rst_RBI)

        reset_signals = set()
        for curr_clock_signal in clock_signals:
            for line_id in range(len(module_content_post_yosys_lines)):
                if "always_ff" in module_content_post_yosys_lines[line_id] and f"posedge {curr_clock_signal}" in module_content_post_yosys_lines[line_id]:
                    # There may be some if's in the middle
                    line_id += 1
                    while line_id < len(module_content_post_yosys_lines) and module_content_post_yosys_lines[line_id].lstrip().startswith("if (_"):
                        line_id += 1

                    if line_id < len(module_content_post_yosys_lines) and module_content_post_yosys_lines[line_id].lstrip().startswith("if (!") and "rst" in module_content_post_yosys_lines[line_id].lower():
                        reset_signals.add(re.search(r"if \(!(\w+)\)", module_content_post_yosys_lines[line_id]).group(1))

        assert len(reset_signals) <= 1, "There is expected to be at most one reset signal"
        reset_signal = reset_signals.pop() if reset_signals else None

        # Synchronous signals are represented as tuples (signal_name, width)
        input_signals = []
        output_signals = []

        # Identify the input and output signals as "input" and "output" declarations
        for line in module_content_post_yosys_lines:

            if "input" in line:
                # Ignore the taint meta reset signal
                if TAINT_META_RESET_PORT_NAME_PREFIX in line:
                    continue

                signal = re.search(r"input\s*(?:wire|reg|logic)?\s*(\[.*\])?\s*(\w+)", line)
                # Exclude clock and reset signals
                if signal.group(2) in clock_signals or signal.group(2) == reset_signal:
                    continue
                if signal.group(1) is None:
                    width = 1
                else:
                    # signal.group(1) is like "[7:0]"
                    width = int(signal.group(1).split(":")[0][1:]) - int(signal.group(1).split(":")[1][:-1]) + 1
                input_signals.append((signal.group(2), width))

            if "output" in line:
                signal = re.search(r"^\s*output\s*(?:wire|reg|logic)?\s*(\[.*\])?\s*(\w+)", line)
                if signal:
                    if signal.group(1) is None:
                        # Print all groups
                        width = 1
                    else:
                        # signal.group(1) is like "[7:0]"
                        width = int(signal.group(1).split(":")[0][1:]) - int(signal.group(1).split(":")[1][:-1]) + 1
                    output_signals.append((signal.group(2), width))

        assert len(output_signals) == 1, "There is expected to be exactly one output signal"
        output_signal = output_signals.pop()
        del output_signals

        return {
            "clock_signals": clock_signals,
            "reset_signal": reset_signal,
            "input_signals_and_widths": input_signals,
            "output_signal_and_width": output_signal
        }

    module_content_post_yosys_lines_incl_functions = module_content_post_yosys_lines
    module_content_post_yosys_lines = remove_functions(module_content_post_yosys_lines)
    signal_dict = identify_signal_syncs_and_directions(module_content_post_yosys_lines)

    output_data_signal_and_width = signal_dict["output_signal_and_width"]
    data_width = output_data_signal_and_width[1]

    if not is_manual_annotation:
        assert not module_annotations, "The module annotations should be empty if we are not in manual annotation mode"

        # # assert data_width % 8 == 0, f"The data width is expected to be a multiple of 8, but it is {data_width}"
        # assert data_width >= 8, f"The data width is expected to be larger than 8, but it is {data_width} for module {module_name}"

        # In case there are multiple input signals with the same width as the output signal, we can use a heuristic that seems to work very often.
        # Find a single line like `] <= something`
        def __heuristic_find_input_signal_if_not_obvious_by_width(module_content_post_yosys_lines_incl_functions, input_signals):
            found_bracket_line_id = None
            for line_id in range(len(module_content_post_yosys_lines_incl_functions)):
                line = module_content_post_yosys_lines_incl_functions[line_id]
                if re.search(r"\]\s*<=\s*[a-zA-Z]", line):
                    print(f"Found bracket line: {line}")
                    found_bracket_line_id = line_id
                    break
            if found_bracket_line_id is None:
                return None

            print(f"module_content_post_yosys_lines_incl_functions[found_bracket_line_id]: {module_content_post_yosys_lines_incl_functions[found_bracket_line_id]}")

            # Example: ] <= _01_;
            interm_signal_name = re.search(r"\] <= (\w+);", module_content_post_yosys_lines_incl_functions[found_bracket_line_id]).group(1)
            assert interm_signal_name.startswith("_"), f"The intermediate signal name should start with an underscore, but it is {interm_signal_name}"

            # Now look for `assign _01_ = something ? W0_data : 1'hx;`
            assign_line = None
            for line in module_content_post_yosys_lines_incl_functions:
                if f"assign {interm_signal_name} = " in line:
                    assign_line = line
                    break
            if assign_line is None:
                return None

            # Example: assign _01_ = _02_ ? W0_data : 1'hx;
            other_name = re.search(r"assign " + interm_signal_name + r" = (?:\w+) \? (\w+) : \d+'hx;", assign_line)
            if other_name is None:
                return None

            candidate_name = other_name.group(1)
            if candidate_name in input_signals:
                return candidate_name
            return None

        # Identify and exclude the input data signal
        input_signals_and_widths_except_clocks = signal_dict["input_signals_and_widths"]

        # Find the input data signal
        if len([signal for signal in input_signals_and_widths_except_clocks if signal[1] == data_width]) == 1:
            input_data_signal = [signal for signal in input_signals_and_widths_except_clocks if signal[1] == data_width][0][0]
        else:
            print("TODO Warning: The input data signal is not obvious by width. Using a heuristic.")
            input_data_signal = __heuristic_find_input_signal_if_not_obvious_by_width(module_content_post_yosys_lines_incl_functions, [signal[0] for signal in input_signals_and_widths_except_clocks])
            if input_data_signal is None:
                print(f"Heuristic input data detection failed for module. Assuming that this is not a memory module")
                return None
            assert input_data_signal is not None, f"There should be exactly one input signal with the same width as the output signal in module {module_name}"

        input_signals_and_widths = list(filter(lambda signal: signal[0] != input_data_signal, input_signals_and_widths_except_clocks))

        # Useful later for the ordering
        input_data_signal_idx = [idx for idx, signal in enumerate(input_signals_and_widths_except_clocks) if signal[0] == input_data_signal][0]

        # We still have to distinguish between the following signals:
        # Write Enable (1 bit)
        # Enable (1 bit)
        # Byte enable (datawidth/8, potentially single-bit if datawidth==8)
        # Address (Assume at least 2 bits)

        # Generate a sequence of all possible input signal assignments
        # Find the set of single-bit signal names
        single_bit_signal_names = set([signal[0] for signal in input_signals_and_widths if signal[1] == 1])
        single_bit_signal_names_idxs = [idx for idx, signal in enumerate(input_signals_and_widths_except_clocks) if signal[1] == 1 and signal[0] != input_data_signal]

        # Find the set of signals of width data_width/8
        # If the byte enable signal is of width 1, then it is a single-bit signal
        byte_enable_candidate_signal_names = set()
        byte_enable_candidate_signal_names_idxs = []
        if data_width > 8 and data_width % 8 == 0:
            byte_enable_candidate_signal_names = set([signal[0] for signal in input_signals_and_widths if signal[1] == data_width//8])
            byte_enable_candidate_signal_names_idxs = [idx for idx, signal in enumerate(input_signals_and_widths_except_clocks) if signal[1] == data_width//8]
        # assert not byte_enable_candidate_signal_names or data_width % 8 == 0, "The data width should be a multiple of 8 if there are byte enable signals"

        # Make sure that the two sets are disjoint if the data width is not 8
        assert data_width == 8 or len(single_bit_signal_names.intersection(byte_enable_candidate_signal_names)) == 0, f"The set of single-bit signal names and the set of byte enable signal names should be disjoint. Issue found in module {module_name}"

        # Candidate address signal names
        address_candidate_signal_names  = [signal[0] for signal in input_signals_and_widths if signal[1] >= 2]
        # address_candidate_signal_widths = [signal[1] for signal in input_signals_and_widths if signal[1] >= 2]
        address_candidate_signal_names_idxs = [idx for idx, signal in enumerate(input_signals_and_widths_except_clocks) if signal[0] in address_candidate_signal_names]
        # There should be 2 signals inside. If they have distinct sizes, then the address signal is the one which is not the byte enable signal.
        assert len(address_candidate_signal_names) <= 2, f"There should be at most 2 candidate address signals, but got {len(address_candidate_signal_names)} entries: {address_candidate_signal_names}"
        # Assume that the two candidate address signals are of different widths (we may want to relax this assumption)
        # if len(address_candidate_signal_names) >= 2:
        #     assert address_candidate_signal_widths[0] != address_candidate_signal_widths[1], f"The two candidate address signals should have different widths, but got {address_candidate_signal_widths[0]} and {address_candidate_signal_widths[1]}. This may be constraint that we would like to relax. It looks like the address was coincidentially of the same width as the byte enable signal."

        # If the byte enable signal is clear, then we can MOST LIKELY distinguish the address signal from the byte enable signal.
        if len(byte_enable_candidate_signal_names) == 1:
            address_candidate_signal_names = [signal for signal in address_candidate_signal_names if signal not in byte_enable_candidate_signal_names]
            address_candidate_signal_names_idxs = [idx for idx, signal in enumerate(input_signals_and_widths_except_clocks) if signal[0] in address_candidate_signal_names]

        # Print a conclusion of this width analysis:
        print(f"Clock signals: {signal_dict['clock_signals']}")
        print(f"Reset signal: {signal_dict['reset_signal']}")
        print(f"Input data signal: {input_data_signal}")
        print(f"Byte enable signal: {byte_enable_candidate_signal_names}")
        print(f"Address signals: {address_candidate_signal_names}")
        print(f"Single bit signals: {single_bit_signal_names}")

        ############################
        # Instantiate the templates & build the Verilator model
        ############################

        # Generate the ordered signals
        ordered_signal_inputs_and_widths = [input_signals_and_widths_except_clocks[input_data_signal_idx]]
        ordered_signal_inputs_and_widths += [input_signals_and_widths_except_clocks[idx] for idx in byte_enable_candidate_signal_names_idxs]
        ordered_signal_inputs_and_widths += [input_signals_and_widths_except_clocks[idx] for idx in address_candidate_signal_names_idxs]
        ordered_signal_inputs_and_widths += [input_signals_and_widths_except_clocks[idx] for idx in single_bit_signal_names_idxs]

        # print('input_data_signal_idx', input_data_signal_idx, [input_signals_and_widths_except_clocks[input_data_signal_idx]])
        # print('byte_enable_candidate_signal_names_idxs', byte_enable_candidate_signal_names_idxs, [input_signals_and_widths_except_clocks[idx] for idx in byte_enable_candidate_signal_names_idxs])
        # print('address_signal_idxs', address_candidate_signal_names, [input_signals_and_widths_except_clocks[idx] for idx in address_candidate_signal_names_idxs])
        # print('single_bit_signal_names_idxs', single_bit_signal_names_idxs, [input_signals_and_widths_except_clocks[idx] for idx in single_bit_signal_names_idxs])

        # print(f"ordered_signal_inputs_and_widths: {ordered_signal_inputs_and_widths}")

        template_feed_inputs_lines = []
        for input_signal_name, input_signal_width in ordered_signal_inputs_and_widths:
            print(f"Input signal: {input_signal_name} with width {input_signal_width}")
            if input_signal_width > 64:
                template_feed_inputs_lines.append(f"    tb->module_->{input_signal_name}[0] = get_next_input();")
            else:
                template_feed_inputs_lines.append(f"    tb->module_->{input_signal_name} = get_next_input() & {gen_bitmask(input_signal_width)}ULL;")

        template_output_signal = ""
        if data_width > 64:
            template_output_signal = f"{output_data_signal_and_width[0]}[0]"
        else:
            template_output_signal = f"{output_data_signal_and_width[0]}"

        PATH_TO_HYBRIDIFT_DV = os.getenv("CELLIFT_PYTHON_COMMON")
        assert PATH_TO_HYBRIDIFT_DV is not None, "The environment variable CELLIFT_PYTHON_COMMON should be set to the path of the hybriDIFT-DV repository"

        # Header file
        with open(os.path.join(PATH_TO_HYBRIDIFT_DV, "..", "hybridift_dv", "testbench_template.h"), "r") as f:
            template_content = f.read()

        assert "TEMPLATE_TOP_MODULE_NAME" in template_content, "The template should contain the string TEMPLATE_TOP_MODULE_NAME"
        template_content = template_content.replace("TEMPLATE_TOP_MODULE_NAME", "memory")

        assert "TEMPLATE_CLOCK_DOWN" in template_content, "The template should contain the string TEMPLATE_CLOCK_DOWN"
        clock_down_template_block = ""
        for clock_signal in signal_dict["clock_signals"]:
            clock_down_template_block += f"      module_->{clock_signal} = 0;\n"
        template_content = template_content.replace("TEMPLATE_CLOCK_DOWN", clock_down_template_block)

        assert "TEMPLATE_CLOCK_UP" in template_content, "The template should contain the string TEMPLATE_CLOCK_UP"
        clock_up_template_block = ""
        for clock_signal in signal_dict["clock_signals"]:
            clock_up_template_block += f"      module_->{clock_signal} = 1;\n"
        template_content = template_content.replace("TEMPLATE_CLOCK_UP", clock_up_template_block)

        os.makedirs(f"{tmp_dir_path}/dv_{__mystrhash(module_name)}", exist_ok=True)
        with open(f"{tmp_dir_path}/dv_{__mystrhash(module_name)}/testbench.h", "w") as f:
            f.write(template_content)
        del template_content

        # C++ file

        with open(os.path.join(PATH_TO_HYBRIDIFT_DV, "..", "hybridift_dv", "toplevel_template.cc"), "r") as f:
            template_content = f.read()

        assert "TEMPLATE_FEED_INPUTS" in template_content, "The template should contain the string TEMPLATE_FEED_INPUTS"
        template_content = template_content.replace("TEMPLATE_FEED_INPUTS", '\n'.join(template_feed_inputs_lines))
        assert "TEMPLATE_OUTPUT_SIGNAL" in template_content, "The template should contain the string TEMPLATE_OUTPUT_SIGNAL"
        template_content = template_content.replace("TEMPLATE_OUTPUT_SIGNAL", f"tb->module_->{template_output_signal}")
        assert "TEMPLATE_RDATA" in template_content, "The template should contain the string TEMPLATE_RDATA"
        template_content = template_content.replace("TEMPLATE_RDATA", f"tb->module_->{template_output_signal}")

        # Reset signal
        assert "TEMPLATE_RESET_SIGNAL" in template_content, "The template should contain the string TEMPLATE_RESET_SIGNAL"
        if signal_dict["reset_signal"] is not None:
            template_content = template_content.replace("TEMPLATE_RESET_SIGNAL", f"tb->module_->{signal_dict['reset_signal']} = 1;")
        else:
            template_content = template_content.replace("TEMPLATE_RESET_SIGNAL", "")

        with open(f"{tmp_dir_path}/dv_{__mystrhash(module_name)}/toplevel_{__mystrhash(module_name)}.cc", "w") as f:
            f.write(template_content)

        # SV source file

        print(f"Path: {tmp_dir_path}/dv_{__mystrhash(module_name)}/memory.sv")
        sv_code_to_write = '\n'.join(module_content_post_yosys_lines_incl_functions)
        with open(f"{tmp_dir_path}/dv_{__mystrhash(module_name)}/memory.sv", "w") as f:
            f.write(sv_code_to_write)

        ############################
        # Produce the inputs for all the possible cases to discriminate
        ############################

        def get_expected_port_max_size(role: PortRole):
            if role == PortRole.INPUT_DATA:
                return data_width
            elif role == PortRole.READ_ADDRESS_SIGNAL:
                return float('inf') # Can be arbitrarily large
            elif role == PortRole.WRITE_ADDRESS_SIGNAL:
                return float('inf') # Can be arbitrarily large
            elif role == PortRole.COMBINED_ADDRESS_SIGNAL:
                return float('inf') # Can be arbitrarily large
            elif role == PortRole.BYTE_ENABLE_SIGNAL:
                return data_width // 8
            elif role == PortRole.WRITE_ENABLE:
                return 1
            elif role == PortRole.ENABLE:
                return 1
            elif role == PortRole.READ_ENABLE:
                return 1
            elif role == PortRole.WRITE_MASK:
                return 1
            elif role == PortRole.WRITE_MODE:
                return 1
            else:
                raise NotImplementedError(f"Role {role} not yet implemented")

        def get_expected_port_min_size(role: PortRole):
            if role == PortRole.INPUT_DATA:
                return data_width
            elif role == PortRole.READ_ADDRESS_SIGNAL:
                return MIN_ADDR_WIDTH
            elif role == PortRole.WRITE_ADDRESS_SIGNAL:
                return MIN_ADDR_WIDTH
            elif role == PortRole.COMBINED_ADDRESS_SIGNAL:
                return MIN_ADDR_WIDTH
            elif role == PortRole.BYTE_ENABLE_SIGNAL:
                return data_width // 8
            elif role == PortRole.WRITE_ENABLE:
                return 1
            elif role == PortRole.READ_ENABLE:
                return 1
            elif role == PortRole.ENABLE:
                return 1
            elif role == PortRole.WRITE_MASK:
                return 1
            elif role == PortRole.WRITE_MODE:
                return 1
            else:
                raise NotImplementedError(f"Role {role} not yet implemented")

        def is_port_size_suitable(role: PortRole, size):
            return get_expected_port_min_size(role) <= size and size <= get_expected_port_max_size(role)

        # Sequence of actions:
        # 1. Write data to addr 100
        # 2. Write data to addr 010
        # 3. Read data from addr 100
        # 4. Read data from addr 010
        role_sequences = {
            # Input data
            PortRole.INPUT_DATA: [0b10, 0b11, 0b00000000, 0b00000000, 0b00000000, 0b00000000],
            # Read  address
            PortRole.READ_ADDRESS_SIGNAL: [0b000, 0b000, 0b100, 0b010, 0b100, 0b010],
            # Write address TODO Distinguish later
            PortRole.WRITE_ADDRESS_SIGNAL: [0b100, 0b010, 0b000, 0b000, 0b000, 0b000],
            # Combined  address
            PortRole.COMBINED_ADDRESS_SIGNAL: [0b100, 0b010, 0b100, 0b010, 0b100, 0b010],
            # Byte enable
            PortRole.BYTE_ENABLE_SIGNAL: [0b1111, 0b1111, 0b1111, 0b1111, 0b1111, 0b0000],
            # Write enable
            PortRole.WRITE_ENABLE: [1, 1, 0, 0, 0, 0],
            # Enable
            PortRole.ENABLE: [1, 1, 1, 1, 1, 1],
            # Write mask
            PortRole.WRITE_MASK: [0b1, 0b1, 0b1, 0b1, 0b1, 0b0],
            # Read enable
            PortRole.READ_ENABLE: [0, 0, 1, 1, 1, 1],
            # TODO Future: Improve read enable and write mode. This will probably require adding some stimuli (this will cause much difference in performance)
            PortRole.WRITE_MODE: [1, 1, 0, 0, 0, 0],
        }
        # Ensure that all lengths match
        assert len(set([len(sequence) for sequence in role_sequences.values()])) == 1, "All sequences should have the same length"

        def gen_input_sequence_assuming_roles(roles, input_signals_and_widths_except_clocks):
            print(f"Roles: {roles}")
            print(f"Input signals and widths except clocks: {input_signals_and_widths_except_clocks}")

            # Check that the inputs are correct
            assert len(roles) == len(input_signals_and_widths_except_clocks), f"The number of roles {len(roles)} should be the same as the number of input signals {len(input_signals_and_widths_except_clocks)}"

            num_input_signals = len(input_signals_and_widths_except_clocks)

            sequence = []
            num_steps = len(role_sequences[roles[0]])

            for step_id in range(num_steps):
                for wait_cycle_id in range(4):
                    sequence.append([0 for _ in range(num_input_signals)])

                new_input_vector = []
                for input_signal_id in range(num_input_signals):
                    new_input_vector.append(role_sequences[roles[input_signal_id]][step_id])
                sequence.append(new_input_vector)

            for wait_cycle_id in range(4):
                sequence.append([0 for _ in range(num_input_signals)])

            return sequence

        # Generate the candidate mappings from the inputs to the roles.
        all_roles = ALL_PORT_ROLES
        if not byte_enable_candidate_signal_names:
            all_roles = [role for role in all_roles if role != PortRole.BYTE_ENABLE_SIGNAL]
        print(f"All roles: {all_roles}")
        all_candidate_roles_of_inputs_ordered = list(combinations(all_roles, len(ordered_signal_inputs_and_widths)))
        all_candidate_roles_of_inputs = []
        for candidate_roles in all_candidate_roles_of_inputs_ordered:
            all_candidate_roles_of_inputs.extend(permutations(candidate_roles))

        # Filter out all candidate roles
        def filter_candidate_roles(candidate_role_assignments):
            indices_to_remove = set()

            for candidate_role_assignment_id in range(len(candidate_role_assignments)):
                candidate_role_assignment = candidate_role_assignments[candidate_role_assignment_id]

                # Ensure there is the input data signal
                if PortRole.INPUT_DATA not in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because no input data signal is assigned")
                    continue

                # Ensure there is at least one address signal
                if PortRole.READ_ADDRESS_SIGNAL not in candidate_role_assignment and PortRole.WRITE_ADDRESS_SIGNAL not in candidate_role_assignment and PortRole.COMBINED_ADDRESS_SIGNAL not in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because no address signal is assigned")
                    continue

                # Remove incompatible roles in the assignments
                if PortRole.READ_ADDRESS_SIGNAL in candidate_role_assignment and PortRole.COMBINED_ADDRESS_SIGNAL in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because both read and write addresses are assigned")
                    continue
                if PortRole.WRITE_ADDRESS_SIGNAL in candidate_role_assignment and PortRole.COMBINED_ADDRESS_SIGNAL in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because both write and combined addresses are assigned")
                    continue

                if PortRole.READ_ADDRESS_SIGNAL in candidate_role_assignment and PortRole.WRITE_ADDRESS_SIGNAL not in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because read address is assigned but write address is not")
                    continue
                if PortRole.WRITE_ADDRESS_SIGNAL in candidate_role_assignment and PortRole.COMBINED_ADDRESS_SIGNAL in candidate_role_assignment:
                    indices_to_remove.add(candidate_role_assignment_id)
                    # print(f"Removing candidate role assignment {candidate_role_assignment_id} because both write address and combined address are assigned")
                    continue

                # Remove unsuitable sizes
                for input_signal_id in range(len(ordered_signal_inputs_and_widths)):
                    input_signal_name, input_signal_width = ordered_signal_inputs_and_widths[input_signal_id]
                    if not is_port_size_suitable(candidate_role_assignment[input_signal_id], input_signal_width):
                        indices_to_remove.add(candidate_role_assignment_id)
                        # print(f"Removing candidate role assignment {candidate_role_assignment_id} because input id {input_signal_id} with name {input_signal_name} and width {input_signal_width} is not suitable for role {candidate_role_assignment[input_signal_id]}")
                        break

            return [role_assignment for role_assignment_id, role_assignment in enumerate(candidate_role_assignments) if role_assignment_id not in indices_to_remove]

        print(f"len(all_candidate_roles_of_inputs): {len(all_candidate_roles_of_inputs)}")
        print(f"ordered_signal_inputs_and_widths: {ordered_signal_inputs_and_widths}")

        curr_candidate_roles = filter_candidate_roles(all_candidate_roles_of_inputs)
        del all_candidate_roles_of_inputs

        if not curr_candidate_roles:
            print(f"No candidate roles were found for module {module_name}. Skipping this module and assuming it is not a memory.")
            return

        curr_candidate_roles = list(curr_candidate_roles)

        all_input_seqs = []
        for curr_candidate_role_assignment in curr_candidate_roles:
            curr_seq = gen_input_sequence_assuming_roles(curr_candidate_role_assignment, ordered_signal_inputs_and_widths)
            all_input_seqs.append(curr_seq)
        assert all_input_seqs, f"No input sequences were generated for module {module_name}"

        # all_candidate_combinations = permutations(range(1, num_input_signals), num_input_signals)

        ############################
        # Execute the Verilator model
        ############################


        # First, build it
        command = f"verilator -Wall -Wno-DECLFILENAME -Wno-WIDTHTRUNC -Wno-CASEOVERLAP -Wno-UNUSEDSIGNAL -Wno-UNOPTFLAT -cc {tmp_dir_path}/dv_{__mystrhash(module_name)}/memory.sv -I.. -Idv{__mystrhash(module_name)} --exe ../{tmp_dir_path}/dv_{__mystrhash(module_name)}/toplevel_{__mystrhash(module_name)}.cc -Mdir {tmp_dir_path}/obj_dir_{__mystrhash(module_name)}" + (" --trace-fst --trace --trace-underscore" if DO_TRACE else "")
        print(f"Command 0: {command}")
        subprocess.run(command.split())
        command = f"make -j {NUM_PROCESSES_FOR_BUILD} -C {tmp_dir_path}/obj_dir_{__mystrhash(module_name)} -f Vmemory.mk Vmemory"
        print(f"Command 1: {command}")
        subprocess.run(command.split(), check=True)

        candidate_roles_found_prefilter = []
        candidate_latencies_found_prefilter = []
        with mp.Pool(mp.cpu_count()) as pool:
            candidate_roles_found_prefilter_selectors_and_latencies = pool.starmap(__analysis_exec_worker, [(module_name, input_seq_id, input_seq) for input_seq_id, input_seq in enumerate(all_input_seqs)])
        print("candidate_roles_found_prefilter_selectors_and_latencies", candidate_roles_found_prefilter_selectors_and_latencies)
        candidate_roles_found_prefilter_selectors, candidate_roles_found_prefilter_selectors_secondary, candidate_roles_found_prefilter_selectors_and_latencies = zip(*candidate_roles_found_prefilter_selectors_and_latencies)

        # If all primary selectors are None, then we can use the secondary selectors
        if all([not selector for selector in candidate_roles_found_prefilter_selectors]):
            candidate_roles_found_prefilter_selectors = candidate_roles_found_prefilter_selectors_secondary

        print(f"candidate_roles_found_prefilter_selectors: {candidate_roles_found_prefilter_selectors}")
        for input_seq_id in range(len(all_input_seqs)):
            if candidate_roles_found_prefilter_selectors[input_seq_id]:
                candidate_roles_found_prefilter.append(curr_candidate_roles[input_seq_id])
                candidate_latencies_found_prefilter.append(candidate_roles_found_prefilter_selectors_and_latencies[input_seq_id])

        # Check that all found latencies are the same
        assert len(set(candidate_latencies_found_prefilter)) == 1, f"All latencies should be the same but got {set(candidate_latencies_found_prefilter)} for module {module_name}"
        latency = candidate_latencies_found_prefilter[0]

        # In case the data width is 8 and there is a hesitation between byte enable and write mask (they are equivalent in this case), then we can arbitrate.
        # FUTURE: this is not the best if condition in the world.
        if data_width == 8 and len(candidate_roles_found_prefilter) == 2:
            # Check that there is exactly 1 index with different roles
            indices_with_different_roles = [idx for idx in range(len(candidate_roles_found_prefilter[0])) if candidate_roles_found_prefilter[0][idx] != candidate_roles_found_prefilter[1][idx]]
            if len(indices_with_different_roles) == 1:
                if (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.BYTE_ENABLE_SIGNAL and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.WRITE_MASK) or (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.WRITE_MASK and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.BYTE_ENABLE_SIGNAL):
                    print("Arbitration A")
                    # Arbitrate
                    candidate_roles_found_prefilter = [candidate_roles_found_prefilter[0]]

        # If the confusion is due to write enable and write mask (they are sometimes equivalent, see boom_split_array_0_0), then we can arbitrate.
        print(f"len(candidate_roles_found_prefilter): {len(candidate_roles_found_prefilter)}")
        if len(candidate_roles_found_prefilter) == 2:
            indices_with_different_roles = [idx for idx in range(len(candidate_roles_found_prefilter[0])) if candidate_roles_found_prefilter[0][idx] != candidate_roles_found_prefilter[1][idx]]
            print(f"indices_with_different_roles: {indices_with_different_roles}, candidate_roles_found_prefilter[0]: {candidate_roles_found_prefilter[0][indices_with_different_roles[0]]}, candidate_roles_found_prefilter[1]: {candidate_roles_found_prefilter[1][indices_with_different_roles[0]]}")

            if len(indices_with_different_roles) == 2:
                if (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.WRITE_ENABLE and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.WRITE_MASK) or (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.WRITE_MASK and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.WRITE_ENABLE):
                    print("Arbitration B")
                    # Arbitrate
                    candidate_roles_found_prefilter = [candidate_roles_found_prefilter[0]]
            if len(indices_with_different_roles) == 1:
                if (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.WRITE_ENABLE and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.WRITE_MASK) or (candidate_roles_found_prefilter[0][indices_with_different_roles[0]] == PortRole.WRITE_MASK and candidate_roles_found_prefilter[1][indices_with_different_roles[0]] == PortRole.WRITE_ENABLE):
                    print("Arbitration C")
                    # Arbitrate
                    candidate_roles_found_prefilter = [candidate_roles_found_prefilter[0]]
        print("Done with arbitration")
        roles = candidate_roles_found_prefilter
        del candidate_roles_found_prefilter
        print(f"input signal names: {ordered_signal_inputs_and_widths}")
        print("roles:", '\n'.join(list(map(str, roles))))

        # If the difference is exactly write enable vs. write mode, just say it is write enable as this should not matter.
        if len(roles) == 2:
            assert len(roles[0]) == len(roles[1]), "The two roles should have the same length"
            # roles[0], roles[1] = zip(*sorted(zip(roles[0], roles[1])))
            diff_positions = [idx for idx in range(len(roles[0])) if roles[0][idx] != roles[1][idx]]
            if len(diff_positions) == 1:
                if roles[0][diff_positions[0]] == PortRole.WRITE_ENABLE and roles[1][diff_positions[0]] == PortRole.WRITE_MODE or roles[0][diff_positions[0]] == PortRole.WRITE_MODE and roles[1][diff_positions[0]] == PortRole.WRITE_ENABLE:
                    roles = [roles[0]]

        assert len(roles) == 1, f"There should be exactly one set of roles found, but got {len(roles)}"
        roles = roles[0]

        clocks = signal_dict['clock_signals']
        output_signal_and_width = signal_dict['output_signal_and_width']

    else: # i.e., if is_manual_annotation
        assert module_annotations is not None, "The module annotations should be provided if there are manual annotations"

        roles = []
        ordered_signal_inputs_and_widths = []
        clocks = []
        output_signal_and_width = None
        latency = None

        for annotation in module_annotations:
            if annotation[1] == "INPUT_DATA":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.INPUT_DATA)
            elif annotation[1] == "READ_ADDRESS_SIGNAL":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.READ_ADDRESS_SIGNAL)
            elif annotation[1] == "WRITE_ADDRESS_SIGNAL":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.WRITE_ADDRESS_SIGNAL)
            elif annotation[1] == "COMBINED_ADDRESS_SIGNAL":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.COMBINED_ADDRESS_SIGNAL)
            elif annotation[1] == "BYTE_ENABLE_SIGNAL":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.BYTE_ENABLE_SIGNAL)
            elif annotation[1] == "READ_ENABLE":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.READ_ENABLE)
            elif annotation[1] == "WRITE_ENABLE":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.WRITE_ENABLE)
            elif annotation[1] == "ENABLE":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.ENABLE)
            elif annotation[1] == "WRITE_MASK":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.WRITE_MASK)
            elif annotation[1] == "WRITE_MODE":
                ordered_signal_inputs_and_widths.append((annotation[0], annotation[2]))
                roles.append(PortRole.WRITE_MODE)
            elif annotation[1] == "CLOCK":
                clocks.append(annotation[0])
            elif annotation[0] == "hybridift_latency":
                latency = int(annotation[1])
                assert latency == 1, "The latency should be 1 for now"
            elif annotation[1] == "READ_DATA":
                assert output_signal_and_width is None, f"There should be exactly one output signal. Found two candidates: {output_signal_and_width[0]} and {annotation[0]}"
                output_signal_and_width = (annotation[0], annotation[2])

        assert latency is not None, "The latency should be provided"
        assert len(clocks) == 1, "There should be exactly one clock signal. If there are two that are always equal, please just annotate one of the two."
        assert output_signal_and_width is not None, "There should be exactly one output signal"

        # ordered_signal_inputs_and_widths = [annotation[0], annotation[2] for annotation in module_annotations if annotation[1] == "input"]

    # Make a dict instead
    role_dict = {pair[1]: pair[0] for pair in zip(ordered_signal_inputs_and_widths, roles)}
    return role_dict, latency, clocks, output_signal_and_width

def __do_add_taint_ports(role_dict, clock_signal, output_signal_and_width):
    # Wo do not include the clock signal
    new_lines = []

    # The output signal is not part of the role_dict
    assert output_signal_and_width[0] not in role_dict, "The output signal should not be part of the role_dict"
    if output_signal_and_width[1] == 1:
        new_lines.append(f"  output {__signal_to_taint_signal_name(output_signal_and_width[0])};")
    else:
        new_lines.append(f"  output [{output_signal_and_width[1]-1}:0] {__signal_to_taint_signal_name(output_signal_and_width[0])};")

    for curr_role in role_dict:
        if role_dict[curr_role][1] == 1:
            new_lines.append(f"  input {__signal_to_taint_signal_name(role_dict[curr_role][0])};")
        else:
            new_lines.append(f"  input [{role_dict[curr_role][1]-1}:0] {__signal_to_taint_signal_name(role_dict[curr_role][0])};")
    return new_lines

def __do_instrument_memory_explicit(role_dict, clock_signal, metareset_name):
    data_width = role_dict[PortRole.INPUT_DATA][1]
    if PortRole.READ_ADDRESS_SIGNAL in role_dict:
        addr_width = role_dict[PortRole.READ_ADDRESS_SIGNAL][1]
    else:
        assert PortRole.COMBINED_ADDRESS_SIGNAL in role_dict, "There should be at least one address signal"
        addr_width = role_dict[PortRole.COMBINED_ADDRESS_SIGNAL][1]

    # Name of the address signals
    if PortRole.READ_ADDRESS_SIGNAL in role_dict:
        read_addr_signal_name = role_dict[PortRole.READ_ADDRESS_SIGNAL][0]
    else:
        assert PortRole.COMBINED_ADDRESS_SIGNAL in role_dict, "There should be at least one address signal for reads"
        read_addr_signal_name = role_dict[PortRole.COMBINED_ADDRESS_SIGNAL][0]

    if PortRole.WRITE_ADDRESS_SIGNAL in role_dict:
        write_addr_signal_name = role_dict[PortRole.WRITE_ADDRESS_SIGNAL][0]
    else:
        assert PortRole.COMBINED_ADDRESS_SIGNAL in role_dict, "There should be at least one address signal for writes"
        write_addr_signal_name = role_dict[PortRole.COMBINED_ADDRESS_SIGNAL][0]

    # First, add the taint memory
    new_lines = []

    # TODO For the moment, we assume that the enable and write enable signals are independent if they both exist

    # Add the taint memory

    new_lines.append(f"    logic [{data_width-1}:0] taint_mem_signal_out;")

    ######################
    # Shadow memory write
    ######################
    new_lines.append(f"    logic [{data_width-1}:0] taint_mem[{2**addr_width-1}];")
    new_lines.append(f"    always_ff @(posedge {clock_signal} or negedge {metareset_name}) begin")
    new_lines.append(f"      if (~{metareset_name}) begin")
    new_lines.append(f"         for (int i = 0; i < 2**{addr_width}; i++) begin")
    new_lines.append(f"           taint_mem[i] <= 0;")
    new_lines.append(f"         end")
    new_lines.append(f"      end else begin")
    if PortRole.WRITE_ENABLE in role_dict:
        new_lines.append(f"         if ({role_dict[PortRole.WRITE_ENABLE][0]}) begin")
    if PortRole.WRITE_ENABLE not in role_dict and PortRole.ENABLE in role_dict:
        new_lines.append(f"         if ({role_dict[PortRole.ENABLE][0]}) begin")
    # if PortRole.ENABLE in role_dict:
    #     new_lines.append(f"         if ({role_dict[PortRole.ENABLE][0]}) begin")
    if PortRole.WRITE_MASK in role_dict:
        new_lines.append(f"         if ({role_dict[PortRole.WRITE_MASK][0]}) begin")
    # TODO Double-check the effect of the wmode.
    if PortRole.WRITE_MODE in role_dict:
        new_lines.append(f"         if ({role_dict[PortRole.WRITE_MODE][0]}) begin")

    # Ignore the byte enable signal for now
    new_lines.append(f"         taint_mem[{write_addr_signal_name}] <= {__signal_to_taint_signal_name(role_dict[PortRole.INPUT_DATA][0])};")

    if PortRole.WRITE_ENABLE in role_dict:
        new_lines.append(f"    end // end of wen")
    if PortRole.WRITE_ENABLE not in role_dict and PortRole.ENABLE in role_dict:
        new_lines.append(f"    end // end of enable and not wen")
    # elif PortRole.ENABLE in role_dict:
    #     new_lines.append(f"    end")
    if PortRole.WRITE_MASK in role_dict:
        new_lines.append(f"    end // end of wmask")
    if PortRole.WRITE_MODE in role_dict:
        new_lines.append(f"    end // end of wmode")

    new_lines.append(f"    end // end of the non-reset block")
    new_lines.append(f"    end // end of the always_ff block")

    ######################
    # Shadow memory read
    ######################
    new_lines.append(f"    always_ff @(posedge {clock_signal} or negedge {metareset_name}) begin")
    new_lines.append(f"    if (~{metareset_name}) begin")
    new_lines.append(f"      taint_mem_signal_out <= '0;")
    new_lines.append(f"    end else begin")
    if PortRole.ENABLE in role_dict:
        new_lines.append(f"      if ({role_dict[PortRole.ENABLE][0]}) begin")
    new_lines.append(f"      taint_mem_signal_out <= taint_mem[{read_addr_signal_name}];")
    if PortRole.ENABLE in role_dict:
        new_lines.append(f"      end else begin")
        # FUTURE: Test the retention of the memory when not enabled
        # new_lines.append(f"      taint_mem_signal_out <= '0;")
        new_lines.append(f"      end")
    # if PortRole.ENABLE in role_dict:
    #     new_lines.append(f"    end")
    new_lines.append(f"    end // end of the non-reset block")
    new_lines.append(f"    end // end of the always_ff block")
    return new_lines

# The input signal names MUST be single-bit
def __gen_is_bit_tainted_expr(anded_signal_names: list):
    assert len(anded_signal_names) > 0, "The list of anded signal names should not be empty"


    if len(anded_signal_names) == 1:
        return f"{__signal_to_taint_signal_name(anded_signal_names[0])}"

    else:
        tainted_sub_expr = __gen_is_bit_tainted_expr(anded_signal_names[1:])
        anded_subexpr = '&'.join(map(lambda s: f"({s})", anded_signal_names[1:]))
        tainted_first_signal = __signal_to_taint_signal_name(anded_signal_names[0])

        return f"(({anded_signal_names[0]}) & ({tainted_sub_expr})) | (({tainted_first_signal}) & ({anded_subexpr})) | (({tainted_first_signal}) & ({tainted_sub_expr}))"

def __do_instrument_memory_implicit(role_dict, clock_signal, metareset_name):
    # First, add the taint memory
    new_lines = []

# INPUT_DATA
# READ_ADDRESS_SIGNAL
# WRITE_ADDRESS_SIGNAL
# COMBINED_ADDRESS_SIGNAL
# BYTE_ENABLE_SIGNAL
# WRITE_ENABLE
# READ_ENABLE
# ENABLE
# WRITE_MASK

    ######################
    # Write enable signal
    ######################

    new_lines.append(f"    logic my_is_write_enabled;")

    if PortRole.WRITE_ENABLE in role_dict:
        if PortRole.WRITE_MASK in role_dict:
            if PortRole.BYTE_ENABLE_SIGNAL in role_dict:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.WRITE_ENABLE][0]} & {role_dict[PortRole.WRITE_MASK][0]} & |{role_dict[PortRole.BYTE_ENABLE_SIGNAL][0]};")
            else:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.WRITE_ENABLE][0]} & {role_dict[PortRole.WRITE_MASK][0]};")
        else:
            if PortRole.BYTE_ENABLE_SIGNAL in role_dict:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.WRITE_ENABLE][0]} & |{role_dict[PortRole.BYTE_ENABLE_SIGNAL][0]};")
            else:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.WRITE_ENABLE][0]};")
    else:
        assert PortRole.ENABLE in role_dict, "There should be an enable signal if there is no write enable signal"
        if PortRole.WRITE_MASK in role_dict:
            if PortRole.BYTE_ENABLE_SIGNAL in role_dict:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.ENABLE][0]} & {role_dict[PortRole.WRITE_MASK][0]} & |{role_dict[PortRole.BYTE_ENABLE_SIGNAL][0]};")
            else:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.ENABLE][0]} & {role_dict[PortRole.WRITE_MASK][0]};")
        else:
            if PortRole.BYTE_ENABLE_SIGNAL in role_dict:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.ENABLE][0]} & |{role_dict[PortRole.BYTE_ENABLE_SIGNAL][0]};")
            else:
                new_lines.append(f"    assign my_is_write_enabled = {role_dict[PortRole.ENABLE][0]};")

    ######################
    # Write enable taint
    ######################

    REDUCED_BYTE_ENABLE_SIGNAL_NAME = "my_reduced_byte_enabled"
    REDUCED_BYTE_ENABLE_SIGNAL_NAME_TAINT = __signal_to_taint_signal_name(REDUCED_BYTE_ENABLE_SIGNAL_NAME)

    new_lines.append(f"    logic is_write_enable_tainted;")

    if PortRole.BYTE_ENABLE_SIGNAL in role_dict:
        new_lines.append(f"    logic {REDUCED_BYTE_ENABLE_SIGNAL_NAME};")
        new_lines.append(f"    logic {REDUCED_BYTE_ENABLE_SIGNAL_NAME_TAINT};")
        new_lines.append(f"    assign {REDUCED_BYTE_ENABLE_SIGNAL_NAME} = |{role_dict[PortRole.BYTE_ENABLE_SIGNAL][0]};")
        new_lines.append(f"    assign {REDUCED_BYTE_ENABLE_SIGNAL_NAME_TAINT} = |{__signal_to_taint_signal_name(role_dict[PortRole.BYTE_ENABLE_SIGNAL][0])};")

    if PortRole.WRITE_ENABLE not in role_dict:
        if PortRole.WRITE_MASK not in role_dict:
            if PortRole.BYTE_ENABLE_SIGNAL not in role_dict:
                if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = 0;")
                else:
                    new_lines.append(f"    assign is_write_enable_tainted = {__signal_to_taint_signal_name(role_dict[PortRole.ENABLE][0])};")
            else:
                if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {REDUCED_BYTE_ENABLE_SIGNAL_NAME_TAINT};")
                else:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([REDUCED_BYTE_ENABLE_SIGNAL_NAME, role_dict[PortRole.ENABLE][0]])};")

        else:
            if PortRole.BYTE_ENABLE_SIGNAL not in role_dict:
                if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__signal_to_taint_signal_name(role_dict[PortRole.WRITE_MASK][0])};")
                else:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_MASK][0], role_dict[PortRole.ENABLE][0]])};")
            else:
                if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_MASK][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME])};")
                else:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_MASK][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME, role_dict[PortRole.ENABLE][0]])};")

    else:
        if PortRole.WRITE_MASK not in role_dict:
            if PortRole.BYTE_ENABLE_SIGNAL not in role_dict:
                # ENABLE and write_mask are independent if both present
                # if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__signal_to_taint_signal_name(role_dict[PortRole.WRITE_ENABLE][0])};")
                # else:
                #     new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], role_dict[PortRole.ENABLE][0]])};")
            else:
                # ENABLE and write_mask are independent if both present
                # if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME])};")
                # else:
                #     new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME, role_dict[PortRole.ENABLE][0]])};")
        else:
            if PortRole.BYTE_ENABLE_SIGNAL not in role_dict:
                # ENABLE and write_mask are independent if both present
                # if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], role_dict[PortRole.WRITE_MASK][0]])};")
                # else:
                #     new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], role_dict[PortRole.WRITE_MASK][0], role_dict[PortRole.ENABLE][0]])};")
            else:
                # ENABLE and write_mask are independent if both present
                # if PortRole.ENABLE not in role_dict:
                    new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME, role_dict[PortRole.WRITE_MASK][0]])};")
                # else:
                #     new_lines.append(f"    assign is_write_enable_tainted = {__gen_is_bit_tainted_expr([role_dict[PortRole.WRITE_ENABLE][0], REDUCED_BYTE_ENABLE_SIGNAL_NAME, role_dict[PortRole.WRITE_MASK][0], role_dict[PortRole.ENABLE][0]])};")

    ######################
    # Read enable taint
    ######################

    new_lines.append(f"    logic is_read_enable_tainted;")
    if PortRole.ENABLE not in role_dict:
        new_lines.append(f"    assign is_read_enable_tainted = 0;")
    else:
        new_lines.append(f"    assign is_read_enable_tainted = {__signal_to_taint_signal_name(role_dict[PortRole.ENABLE][0])};")


    ######################
    # Write address taint
    ######################

    new_lines.append(f"    logic is_write_addr_tainted;")

    if PortRole.WRITE_ADDRESS_SIGNAL in role_dict:
        new_lines.append(f"    assign is_write_addr_tainted = |{__signal_to_taint_signal_name(role_dict[PortRole.WRITE_ADDRESS_SIGNAL][0])};")
    else:
        assert PortRole.COMBINED_ADDRESS_SIGNAL in role_dict, "There should be at least one address signal for writes"
        new_lines.append(f"    assign is_write_addr_tainted = |{__signal_to_taint_signal_name(role_dict[PortRole.COMBINED_ADDRESS_SIGNAL][0])};")

    ######################
    # Read address taint
    ######################

    new_lines.append(f"    logic is_read_addr_tainted;")

    if PortRole.READ_ADDRESS_SIGNAL in role_dict:
        new_lines.append(f"    assign is_read_addr_tainted = |{__signal_to_taint_signal_name(role_dict[PortRole.READ_ADDRESS_SIGNAL][0])};")
    else:
        assert PortRole.COMBINED_ADDRESS_SIGNAL in role_dict, "There should be at least one address signal for reads"
        new_lines.append(f"    assign is_read_addr_tainted = |{__signal_to_taint_signal_name(role_dict[PortRole.COMBINED_ADDRESS_SIGNAL][0])};")

    ######################
    # Summarizing taint state
    ######################

    # Permanent taint
    new_lines.append(f"    logic permanent_taint_d, permanent_taint_q;")
    new_lines.append(f"    always_ff @(posedge {clock_signal} or negedge {metareset_name}) begin")
    new_lines.append(f"      if (~{metareset_name}) begin")
    new_lines.append(f"        permanent_taint_q <= 0;")
    new_lines.append(f"      end else begin")
    new_lines.append(f"        permanent_taint_q <= permanent_taint_d;")
    new_lines.append(f"      end")
    new_lines.append(f"    end")
    new_lines.append(f"    always_comb begin")
    new_lines.append(f"      permanent_taint_d = permanent_taint_q | is_write_enable_tainted | (my_is_write_enabled & is_write_addr_tainted);")
    new_lines.append(f"    end")

    # The read temporary taint happens if the read enable is tainted, or if the read enable is set and the read address is tainted
    # FUTURE in case of latency > 1, increase the chain length here
    new_lines.append(f"    logic is_read_temporary_taint_d, is_read_temporary_taint_q;")
    new_lines.append(f"    always_ff @(posedge {clock_signal} or negedge {metareset_name}) begin")
    new_lines.append(f"      if (~{metareset_name}) begin")
    new_lines.append(f"        is_read_temporary_taint_q <= 0;")
    new_lines.append(f"      end else begin")
    new_lines.append(f"        is_read_temporary_taint_q <= is_read_temporary_taint_d;")
    new_lines.append(f"      end")
    new_lines.append(f"    end")
    if PortRole.ENABLE not in role_dict:
        new_lines.append(f"    assign is_read_temporary_taint_d = is_read_enable_tainted;")
    else:
        new_lines.append(f"    assign is_read_temporary_taint_d = is_read_enable_tainted | ({role_dict[PortRole.ENABLE][0]} & is_read_addr_tainted);")

    # Summarize the implicit taints
    new_lines.append(f"    logic implicit_taint;")
    new_lines.append(f"    assign implicit_taint = permanent_taint_q | is_read_temporary_taint_q;")

    return new_lines

def __do_summarize_taints(role_dict, clock_signal, output_signal_and_width):
    new_lines = []
    new_lines.append(f"    assign {__signal_to_taint_signal_name(output_signal_and_width[0])} = taint_mem_signal_out | implicit_taint;")
    return new_lines

def __do_add_taint_ports_to_parentheses(module_content_post_yosys_lines, roles, clock_signal, output_signal_and_width):
    # Find the module declaration line
    module_declaration_line_id = None
    for line_id, line in enumerate(module_content_post_yosys_lines):
        if line.lstrip().startswith("module "):
            assert module_declaration_line_id is None, "There should be only one line starting with `module `"
            module_declaration_line_id = line_id

    line = module_content_post_yosys_lines[module_declaration_line_id].strip()
    assert module_declaration_line_id is not None, "Could not find the module declaration line"
    assert line[-2:] == ");", f"The module declaration line should end with `);`"

    # Prepare the new line
    additional_content_items = []
    for role, input_name_and_width in roles.items():
        additional_content_items.append(f"{__signal_to_taint_signal_name(input_name_and_width[0])}")
    additional_content_items.append(f"{__signal_to_taint_signal_name(output_signal_and_width[0])}")
    module_content_post_yosys_lines[module_declaration_line_id] = line[:-2] + ", " + ", ".join(additional_content_items) + ");\n"
    return module_content_post_yosys_lines

# In some metareset implementation, metareset name postfixes may vary per module
def __find_metareset_name(module_content_lines):
    ret = None
    for line in module_content_lines:
        if f"input {TAINT_META_RESET_PORT_NAME_PREFIX}" in line:
            ret = ''.join(line.split()[1:]).replace(';', '')
            break
        elif TOLERATE_NATIVE_RST and f"input" in line and NATIVE_RST_SIGNAL_SUBSTR in line.lower():
            ret = ''.join(line.split()[1:]).replace(';', '')
            break

    assert ret is not None, f"Could not find the metareset signal. Make sure that the metareset has been included, and that the prefix `{TAINT_META_RESET_PORT_NAME_PREFIX}` is correct."
    return ret

# @param module_annotations a list of tuples (port_name, role_str, signal_width)
def instrument_sram(module_name: str, module_lines: list, module_annotations: list):
    metareset_name = __find_metareset_name(module_lines)

    analysis_ret = __analyze_sram_roles_and_latency(module_name, module_lines, module_annotations)
    # In case we do not hybriDIFT-instrument it, for example for now, if this is a single-bit-data memory
    if analysis_ret is None:
        return module_lines

    roles, latency, clock_signals, output_signal_and_width = analysis_ret

    # Latency might be a bit skewed due to secondary selectors. We assume latency is 1, as seen in all reasonable memories so far.
    # print(f"Latency: {latency}, roles: {roles}, clock_signals: {clock_signals}")
    # assert latency == 1, "The latency should be 1, or the read taint should be improved."

    # FUTURE add assertion to check that all clock signals are equal.
    clock_signal = clock_signals.pop()

    # Add the attribute to the module declaration
    module_lines = [f"(* {CELLIFT_NOINSTRUMENT_ATTR} *)"] + module_lines

    # Remove all empty lines
    module_lines = [line for line in module_lines if line.strip().replace('\n', '') != ""]

    # Add the taint ports to the module declaration
    module_lines = __do_add_taint_ports_to_parentheses(module_lines, roles, clock_signal, output_signal_and_width)

    # Add the new lines
    new_lines_start, new_lines_end = [], []
    new_lines_start += __do_add_taint_ports(roles, clock_signal, output_signal_and_width)
    new_lines_end += __do_instrument_memory_explicit(roles, clock_signal, metareset_name)
    new_lines_end += __do_instrument_memory_implicit(roles, clock_signal, metareset_name)
    new_lines_end += __do_summarize_taints(roles, clock_signal, output_signal_and_width)

    # Append newlines to the end of the new lines
    # First, find the id of the module declaration line
    for new_line_id, new_line in enumerate(new_lines_start):
        new_lines_start[new_line_id] = new_line + "\n"
    for new_line_id, new_line in enumerate(new_lines_end):
        new_lines_end[new_line_id] = new_line + "\n"

    # Insert the new lines at the start
    # Find the first line with a `)`
    module_declaration_line_id = None
    for line_id, line in enumerate(module_lines):
        if line.lstrip().startswith("module "):
            module_declaration_line_id = line_id
            break
    assert module_declaration_line_id is not None, "Could not find a line with a parenthesis"
    module_lines = module_lines[:module_declaration_line_id+1] + new_lines_start + module_lines[module_declaration_line_id+1:]

    # Find the last line with a `endmodule`
    lines_with_endmodule = []
    for line_id, line in enumerate(module_lines):
        if "endmodule" in line:
            lines_with_endmodule.append(line_id)
    assert len(lines_with_endmodule) == 1, f"Expected exactly one line with `endmodule`, but got {len(lines_with_endmodule)} such lines"
    last_line_with_endmodule = lines_with_endmodule[0]
    module_lines = module_lines[:last_line_with_endmodule] + new_lines_end + module_lines[last_line_with_endmodule:]

    return module_lines

    # with open(f"{MODULE_NAME}_instrumented.sv", "w") as f:
    #     f.writelines(module_content_post_yosys_lines)




#######################
# Find the memories and instrument them one by one
#######################

# A module is a substring that starts with "\nmodule " and ends with "\nendmodule\n"
# Returns a list of module contents
def __list_module_contents(sv_content):
    module_contents = []
    module_contents_incl_functions = []
    module_annotations = [] # Annotations are pairs of (port_name, role_str)
    start_idx = 0
    while True:

        start_idx = sv_content.find("\nmodule ", start_idx)
        if start_idx == -1:
            break
        end_idx = sv_content.find("\nendmodule\n", start_idx)
        if end_idx == -1:
            break

        curr_module_content_incl_functions = sv_content[start_idx:end_idx+11]
        content_lines = curr_module_content_incl_functions.split('\n')
        # Remove empty lines
        content_lines = [line for line in content_lines if line.strip().replace('\n', '') != ""]

        # Make sure that the first line contains the whole module declaration
        num_lines_in_first_line = 1
        first_line = content_lines[0]
        while not ');' in first_line:
            first_line += content_lines[num_lines_in_first_line]
            num_lines_in_first_line += 1
        first_line.split()
        assert first_line[-2:] == ");", f"The module declaration line should end with `);`"
        content_lines = [first_line] + content_lines[num_lines_in_first_line:]

        # Remove functions
        line_ids_to_remove = []
        currently_in_function = False
        for line_id, line in enumerate(content_lines):
            if re.match(r'\s*function\s+.*', line):
                currently_in_function = True
                line_ids_to_remove.append(line_id)
            elif line.startswith("endfunction"):
                currently_in_function = False
                line_ids_to_remove.append(line_id)
            elif currently_in_function:
                line_ids_to_remove.append(line_id)
        curr_module_content = '\n'.join([line for line_id, line in enumerate(content_lines) if line_id not in line_ids_to_remove])
        del line_id, line

        module_contents.append(curr_module_content)
        module_contents_incl_functions.append(curr_module_content_incl_functions)

        curr_module_annotations = []
        # Check for the annotations
        for candidate_annotation_id in range(1, len(content_lines)):
            # print(f"Checking line {candidate_annotation_id}: {content_lines[candidate_annotation_id]}")
            if content_lines[candidate_annotation_id].startswith("// @hybridift "):
                annotation_whole_str = content_lines[candidate_annotation_id][len("// @hybridift "):]
                signal_name, role_str = list(map(lambda s: s.strip(), annotation_whole_str.split(":")))

                # Find the width of the signal, which is given by the regex `put ([\d+:\d+])? <signal_name>;`
                signal_width_search_result = re.search(r'put\s+\[(\d+:\d+)\]\s+' + signal_name + r';', curr_module_content)
                if signal_width_search_result:
                    signal_width_str = signal_width_search_result.group(1)
                    signal_width = int(signal_width_str.split(':')[0]) - int(signal_width_str.split(':')[1]) + 1
                elif re.search(r'put\s+' + signal_name + r';', curr_module_content):
                    signal_width = 1
                else:
                    # The latency is a special case where the width is not interesting, and we put the latency in the role slot.
                    if not content_lines[candidate_annotation_id].startswith("// @hybridift hybridift_latency:"):
                        raise ValueError(f"Could not find the signal width for annotated signal `{content_lines[candidate_annotation_id]}` for module {content_lines[0].split(' ')[1].split('(')[0]}")
                    signal_width = None
                curr_module_annotations.append((signal_name, role_str, signal_width))
            else:
                break
        module_annotations.append(curr_module_annotations)
        start_idx = end_idx

    assert len(module_contents) == len(module_contents_incl_functions), f"Expected the same number of module contents and module contents incl functions, but got {len(module_contents)} and {len(module_contents_incl_functions)}"
    assert len(module_contents) == len(module_annotations), f"Expected the same number of module contents and module annotations, but got {len(module_contents)} and {len(module_annotations)}"
    return module_contents, module_contents_incl_functions, module_annotations

def __get_port_directions_and_widths(module_content):
    input_directions_and_widths = []
    for line in module_content.split('\n'):
        # The input/output can be single or multiple bits
        single_bit_input_search_result = re.search(r'input\s+[^\[].*', line)
        single_bit_output_search_result = re.search(r'output\s+[^\[].*', line)

        multiple_bit_input_search_result = re.search(r'input\s+\[(\d+):\d+\]\s+.*', line)
        multiple_bit_output_search_result = re.search(r'output\s+\[(\d+):\d+\]\s+.*', line)

        if single_bit_input_search_result:
            # single_bit_input_name = single_bit_input_search_result.group(0)
            input_directions_and_widths.append(('input', 1))
        elif single_bit_output_search_result:
            # single_bit_output_name = single_bit_output_search_result.group(0)
            input_directions_and_widths.append(('output', 1))
        elif multiple_bit_input_search_result:
            # multiple_bit_input_name = multiple_bit_input_search_result.group(0)
            width = int(multiple_bit_input_search_result.group(1))
            input_directions_and_widths.append(('input', width))
        elif multiple_bit_output_search_result:
            # multiple_bit_output_name = multiple_bit_output_search_result.group(0)
            width = int(multiple_bit_output_search_result.group(1))
            input_directions_and_widths.append(('output', width))

    return input_directions_and_widths

def __can_module_be_a_memory(port_directions_and_widths, module_content):
    # A module can be a memory if it has at least one input and one output
    # and the input and output have the same width
    input_widths = [width for direction, width in port_directions_and_widths if direction == 'input']
    output_widths = [width for direction, width in port_directions_and_widths if direction == 'output']

    # A memory has exactly one output signal
    if len(output_widths) != 1:
        return False

    # A memory has at least two input signals (address and data)
    if len(input_widths) < 2:
        return False

    # The input data signal should have the same width as the output signal
    if output_widths[0] not in input_widths:
        return False

    # Heuristic seen from the Yosys output
    if not "] <= " in module_content:
        return False

    # There may be false positives but they will be managed more carefully later
    return True

def __does_module_contain_an_instance_of(module_content, other_module_name):
    # if "module \\$paramod$f713e97f719503465056561ae63fa77c7ae33835\\fpga_ram" in module_content:
    #     if other_module_name + " " in module_content:
    #         print(f"Submodule: {other_module_name}")
    return re.search(r'\n\s*' + other_module_name + r'\s+.*\(', module_content)
# other_module_name + " " in module_content

def __get_module_name_from_content(module_content):
    # Search for "module\s+(.+)\("
    search_result = re.search(r'module\s+(.+)\s*\(', module_content)
    assert search_result, f"Module name not found in module content: {module_content}"

    return search_result.group(1)

# @param module_content includes the functions
# @param module_annotations a list of tuples (port_name, role_str, signal_width)
def __module_instrumentation_worker(module_name, module_content, module_annotations):
    module_content_lines = module_content.split('\n')
    return '\n\n' + '\n'.join(instrument_sram(module_name, module_content_lines, module_annotations)) + '\n\n'

def instrument_all_memories_in_design(sv_content):
    all_module_contents, all_module_contents_incl_functions, module_annotations = __list_module_contents(sv_content)
    print(f"Module annotations: {module_annotations}")
    all_module_names = [__get_module_name_from_content(module_content) for module_content in all_module_contents]
    if not is_manual_annotation:
        assert not any(module_annotations), "Unexpected hybridift annotations in the design when in fully automatic mode"
        # all_port_directions_and_widths = [__get_port_directions_and_widths(module_content) for module_content in all_module_contents]

        # Find candidate memories
        candidate_memory_module_ids = []
        for module_id, module_content in enumerate(all_module_contents):
            if __can_module_be_a_memory(__get_port_directions_and_widths(module_content), module_content):
                candidate_memory_module_ids.append(module_id)

        # Remove modules that contain instances of candidate memory modules
        # module_ids_to_remove are ids in candidate_memory_module_ids
        module_ids_to_remove = []
        for module_id in candidate_memory_module_ids:
            for other_module_id in candidate_memory_module_ids:
                if module_id == other_module_id:
                    continue

                if __does_module_contain_an_instance_of(all_module_contents[module_id], all_module_names[other_module_id]):
                    module_ids_to_remove.append(module_id)
                    print(f"Removing fake memory module: {all_module_names[module_id]}")
                    break

        candidate_memory_module_ids = [module_id for module_id in candidate_memory_module_ids if module_id not in module_ids_to_remove]

    else: # i.e., if there are manual annotations
        # The candidate module ids are the ones that have annotations
        candidate_memory_module_ids = [curr_module_id for curr_module_id, curr_module_annotation in enumerate(module_annotations) if curr_module_annotation]

    for candidate_memory_module_id in candidate_memory_module_ids:
        print(f"Candidate memory module: {all_module_names[candidate_memory_module_id]}")

    # FUTURE: Potentially do some multiprocessing here
    for candidate_memory_module_id in candidate_memory_module_ids:
        mem_module_lines = __module_instrumentation_worker(all_module_names[candidate_memory_module_id], all_module_contents_incl_functions[candidate_memory_module_id], module_annotations[candidate_memory_module_id])
        sv_content = sv_content.replace(all_module_contents_incl_functions[candidate_memory_module_id], mem_module_lines)

    # For all candidate memory module ids, instrument them
    return sv_content


if __name__ == '__main__':
    input_sv_path = sys.argv[1]
    output_sv_path = sys.argv[2]

    if len(sys.argv) > 3:
        is_manual_annotation = sys.argv[3] == "--annotations"
    
    with open(input_sv_path, "r") as f:
        sv_content = '\n\n'+f.read()

    sv_content = instrument_all_memories_in_design(sv_content)

    print(f"Writing to {output_sv_path}")
    with open(output_sv_path, "w") as f:
        f.write(sv_content)
