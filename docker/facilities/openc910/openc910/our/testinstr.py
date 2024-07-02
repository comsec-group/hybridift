import os
import re

filepaths = [
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x64.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x92.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x104.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x16.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_16384x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x88.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x100.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x196.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x23.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_32768x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x22.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x44.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x96.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_64x108.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_65536x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_8192x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_8192x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_1024x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_1024x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_1024x64.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x92.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_128x104.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_128x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_128x16.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_16384x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_2048x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_2048x32_split.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_2048x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x88.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_256x100.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_256x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/mmu/rtl/ct_spsram_256x196.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_256x23.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_256x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/mmu/rtl/ct_spsram_256x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_32768x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_4096x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_512x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x22.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x44.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_512x96.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_64x108.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_65536x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_8192x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_8192x32.v",
    "../openc910/smart_run/logical/mem/f_spsram_large.v",
    "../openc910/smart_run/logical/mem/f_spsram_32768x128.v",
]

# Check that all files exist
for filepath in filepaths:
    assert os.path.exists(filepath), f"File {filepath} does not exist"

def instr_file(src_filepath: str, dst_filepath: str):
    assert src_filepath.endswith(".v"), f"File {src_filepath} is not a .v file"
    with open(src_filepath, 'r') as f:
        lines = f.readlines()

    ##############
    # Add lines in the module declaration
    ##############

    # First, find the module declaration and all I/O signals in it
    # From our observations there should be no hashtag

    module_start_line_id = None
    for line_id, line in enumerate(lines):
        line = line.strip()
        if line.startswith("module") and line.endswith("("):
            module_start_line_id = line_id
            break
    assert module_start_line_id is not None, f"File {filepath} has no module declaration"
    module_intf_end_line_id = None
    for line_id, line in enumerate(lines[module_start_line_id + 1:]):
        if line.startswith(");"):
            module_intf_end_line_id = line_id + module_start_line_id + 1
            break
    assert module_intf_end_line_id is not None, f"File {filepath} has no end of module interface"

    # Find all I/O signals
    io_signals = []
    for line in lines[module_start_line_id + 1:module_intf_end_line_id]:
        line = line.strip().replace(',', '')
        if line == "":
            continue
        if line.startswith("//"):
            continue
        assert line[0].isalpha() and line[0].isupper(), f"File {filepath} has invalid signal name {line}"
        io_signals.append(line)

    # Add their taint counterparts except the clock
    assert "CLK" in io_signals, f"File {filepath} has no CLK signal"

    new_io_signals = []
    for signal in io_signals:
        new_io_signals.append(signal)
        if signal != "CLK":
            new_io_signals.append(f"{signal}_t0")
    # Add commas except for the last signal
    new_io_signals = [f"{signal},\n" for signal in new_io_signals[:-1]] + [f"{new_io_signals[-1]}\n"]
    # Replace the module interface with the new one
    lines = lines[:module_start_line_id + 1] + new_io_signals + lines[module_intf_end_line_id:]
    # The location of the `);` has changed
    del module_intf_end_line_id

    # Find the wire declaration lines. They can be of 2 forms:
    # wire [%d:%d] io_signal;
    # wire io_signal;

    # input/output declarations
    new_wire_lines = []
    for io_name in io_signals:
        for line_id, line in enumerate(lines):
            if re.match(r"input\s+(?:\[.*\])?\s+" + io_name + r";", line):
                if io_name != "CLK":
                    new_wire_lines.append(line.replace(";", f"_t0;"))
            if re.match(r"output\s+(?:\[.*\])?\s+" + io_name + r";", line):
                new_wire_lines.append(line.replace(";", f"_t0;"))

    # There should be exactly the same with input or output instead of line. Output is only for the Q signal.
    for io_name in io_signals:
        for line_id, line in enumerate(lines):
            if re.match(r"wire\s+(?:\[.*\])?\s+" + io_name + r";", line):
                new_wire_lines.append(line.replace(";", f"_t0;"))

    # Finally, ensure the Q signal exists, and assign it
    assert "Q" in io_signals, f"File {filepath} has no Q signal"
    new_wire_lines.append(f"assign Q_t0 = '0;\n")

    # Remove potential parasitic instances of CLK_t0
    new_wire_lines = list(filter(lambda line: "CLK_t0" not in line, new_wire_lines))

    ################
    # Blackbox management
    ################

    # Also do the blackbox content, which will be returned
    blackbox_lines_interm = lines[:module_start_line_id + 1] + new_io_signals + [");\n"]
    blackbox_lines_interm += "input CLK;\n"
    for line in new_wire_lines:
        blackbox_lines_interm.append(line)
        blackbox_lines_interm.append(line.replace("_t0;", ";").replace("_t0 =", " ="))
    blackbox_lines_interm += "\nendmodule\n"

    # Add a blackbox attribute before each module declaration
    blackbox_lines = []
    for line_id, line in enumerate(blackbox_lines_interm):
        if line.startswith("module"):
            blackbox_lines.append("(* blackbox *)\n")
            blackbox_lines.append("(* cellift_noinstrument *)\n")
        blackbox_lines.append(line)

    # # Add the `);` between interface and assignments
    # # Find the line id that starts with `assign` and insert the `);` before it
    # for line_id, line in enumerate(blackbox_lines):
    #     if line.startswith("assign"):
    #         blackbox_lines.insert(line_id, ");\n")
    #         break

    # For the memshade instrumentation
    # Add after the first `);`
    module_intf_end_line_id = None
    for line_id, line in enumerate(lines[module_start_line_id + 1:]):
        if line.startswith(");"):
            module_intf_end_line_id = line_id + module_start_line_id + 1
            break
    assert module_intf_end_line_id is not None, f"File {filepath} has no end of module interface"

    # Find the line id that starts with `);` and insert the memshade after it
    lines = lines[:module_intf_end_line_id+1] + ["\n"] + new_wire_lines + lines[module_intf_end_line_id+1:]

    # Replace the fpga_ram module name with my_fpga_ram
    for line_id in range(len(lines)):
        lines[line_id] = lines[line_id].replace("fpga_ram", "my_fpga_ram")

    ################
    # Write
    ################

    with open(dst_filepath, 'w') as f:
        f.writelines(lines)
    return blackbox_lines

# For each file,
src_filepaths = ["../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x128.v"]

src_filepaths = [
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x64.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_1024x92.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x104.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_128x16.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_16384x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_2048x88.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x100.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x196.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x23.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_256x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_32768x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_4096x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x22.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x44.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_512x96.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_64x108.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_65536x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_8192x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/fpga/rtl/ct_f_spsram_8192x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_1024x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_1024x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_1024x64.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_1024x92.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_128x104.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_128x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_128x16.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_16384x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_2048x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_2048x32_split.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_2048x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_2048x88.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_256x100.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_256x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/mmu/rtl/ct_spsram_256x196.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_256x23.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_256x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_256x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/mmu/rtl/ct_spsram_256x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_32768x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_4096x32.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_4096x84.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_512x144.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x22.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x44.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x52.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x54.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/ifu/rtl/ct_spsram_512x59.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_512x7.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_512x96.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_64x108.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_65536x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/l2c/rtl/ct_spsram_8192x128.v",
    "../openc910/C910_RTL_FACTORY/gen_rtl/lsu/rtl/ct_spsram_8192x32.v",
    "../openc910/smart_run/logical/mem/f_spsram_large.v",
    "../openc910/smart_run/logical/mem/f_spsram_32768x128.v",
]
# Make sure that all basenames are different
assert len(set(map(lambda p: os.path.basename(p), src_filepaths))) == len(src_filepaths)

dst_filepaths = list(map(lambda p: "tmp/" + os.path.basename(p).replace(".v", "_memshade.v"), src_filepaths))

blackbox_filecontent_lines_list = []
for src_filepath, dst_filepath in zip(src_filepaths, dst_filepaths):
    blackbox_filecontent_lines_list.append(instr_file(src_filepath, dst_filepath))


# Also combine all results into a single file
with open("tmp/all_memshade.v", 'w') as f:
    for dst_filepath in dst_filepaths:
        with open(dst_filepath, 'r') as g:
            f.writelines(g.readlines())

# Also combine all blackbox contents into a single file
blackbox_filecontent_lines_merged = []
for blackbox_filecontent_lines in blackbox_filecontent_lines_list:
    blackbox_filecontent_lines_merged += blackbox_filecontent_lines + ["\n"]
with open("tmp/all_blackbox.v", 'w') as f:
    f.writelines(blackbox_filecontent_lines_merged)
