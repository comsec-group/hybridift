# Does the manual annotation

import sys


rocket_modulenames_usual_wmask = [
]
rocket_modulenames_usual_wmode = [
    "split_tag_array_ext",
]
rocket_modulenames_usual_wmask_wmode = [
    "split_data_arrays_0_ext",
    "split_data_arrays_0_0_ext"
]


boom_modulenames_usual_wmode = [
    "split_dataArrayWay_0_ext",
    "split_l2_tlb_ram_ext",
]
boom_modulenames_usual_wmask = [
]
boom_modulenames_usual_wmask_wmode = [
    "split_tag_array_0_ext",
    "split_tag_array_ext",
]

boom_modulenames_usual_nowmask = [
]

boom_modulenames_splitrw = [
    "split_btb_0_ext",
    "split_array_0_0_ext",
    "split_data_ext",
    "split_hi_us_0_ext",
    "split_hi_us_ext",
    "split_rob_debug_inst_mem_ext",
    "split_table_0_ext",
    "split_table_1_ext",
    "split_table_ext",
    "split_meta_0_ext",
]

boom_modulenames_splitrw_nowmask = [
    "split_ebtb_ext",
    "split_ghist_0_ext",
]


annotation_lines_usual_wmode = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift RW0_addr: COMBINED_ADDRESS_SIGNAL\n"
    "// @hybridift RW0_clk: CLOCK\n"
    "// @hybridift RW0_wdata: INPUT_DATA\n"
    "// @hybridift RW0_rdata: READ_DATA\n"
    "// @hybridift RW0_en: ENABLE\n"
    "// @hybridift RW0_wmode: WRITE_MODE\n"
    # "// @hybridift RW0_wmask: WRITE_MASK\n"
]
annotation_lines_usual_wmask = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift RW0_addr: COMBINED_ADDRESS_SIGNAL\n"
    "// @hybridift RW0_clk: CLOCK\n"
    "// @hybridift RW0_wdata: INPUT_DATA\n"
    "// @hybridift RW0_rdata: READ_DATA\n"
    "// @hybridift RW0_en: ENABLE\n"
    # "// @hybridift RW0_wmode: WRITE_MODE\n"
    "// @hybridift RW0_wmask: WRITE_MASK\n"
]
annotation_lines_usual_wmask_wmode = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift RW0_addr: COMBINED_ADDRESS_SIGNAL\n"
    "// @hybridift RW0_clk: CLOCK\n"
    "// @hybridift RW0_wdata: INPUT_DATA\n"
    "// @hybridift RW0_rdata: READ_DATA\n"
    "// @hybridift RW0_en: ENABLE\n"
    "// @hybridift RW0_wmode: WRITE_MODE\n"
    "// @hybridift RW0_wmask: WRITE_MASK\n"
]

annotation_lines_usual_nowmask = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift RW0_addr: COMBINED_ADDRESS_SIGNAL\n"
    "// @hybridift RW0_clk: CLOCK\n"
    "// @hybridift RW0_wdata: INPUT_DATA\n"
    "// @hybridift RW0_rdata: READ_DATA\n"
    "// @hybridift RW0_en: ENABLE\n"
    "// @hybridift RW0_wmask: WRITE_MASK\n"
]

annotation_lines_splitrw = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift R0_addr: READ_ADDRESS_SIGNAL\n"
    "// @hybridift W0_addr: WRITE_ADDRESS_SIGNAL\n"
    "// @hybridift R0_clk: CLOCK\n"
    # "// @hybridift W0_clk: CLOCK\n"
    "// @hybridift W0_data: INPUT_DATA\n"
    "// @hybridift R0_data: READ_DATA\n"
    "// @hybridift R0_en: ENABLE\n"
    "// @hybridift W0_en: WRITE_ENABLE\n"
    "// @hybridift W0_mask: WRITE_MASK\n"
]

annotation_lines_splitrw_nowmask = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift R0_addr: READ_ADDRESS_SIGNAL\n"
    "// @hybridift W0_addr: WRITE_ADDRESS_SIGNAL\n"
    "// @hybridift R0_clk: CLOCK\n"
    # "// @hybridift W0_clk: CLOCK\n"
    "// @hybridift W0_data: INPUT_DATA\n"
    "// @hybridift R0_data: READ_DATA\n"
    "// @hybridift R0_en: ENABLE\n"
    "// @hybridift W0_en: WRITE_ENABLE\n"
]

# Should be the passthrough result
in_filepath = sys.argv[1]
out_filepath = sys.argv[2]

assert "rocket" in in_filepath or "boom" in in_filepath, f"Must have either Rocket or BOOM in the path, as we use the path to know which design it is. Path: {in_filepath}"
assert not ("rocket" in in_filepath and "boom" in in_filepath), "Cannot have both Rocket and BOOM in the same path, as we use the path to know which design it is"

is_rocket = "rocket" in in_filepath
modulenames_usual_wmode = rocket_modulenames_usual_wmode if is_rocket else boom_modulenames_usual_wmode
modulenames_usual_wmask = rocket_modulenames_usual_wmask if is_rocket else boom_modulenames_usual_wmask
modulenames_usual_wmask_wmode = rocket_modulenames_usual_wmask_wmode if is_rocket else boom_modulenames_usual_wmask_wmode
modulenames_splitrw = [] if is_rocket else boom_modulenames_splitrw
modulenames_splitrw_nowmask = [] if is_rocket else boom_modulenames_splitrw_nowmask

del rocket_modulenames_usual_wmode, boom_modulenames_usual_wmode            # For safety
del rocket_modulenames_usual_wmask, boom_modulenames_usual_wmask            # For safety
del boom_modulenames_splitrw, boom_modulenames_splitrw_nowmask  # For safety

with open(in_filepath, 'r') as in_file:
    content_lines = in_file.readlines()

interlines = 0 # So that they do not become shifted because of the insertions
for i, line in enumerate(content_lines):
    # TODO Continuer ici
    for modulename in modulenames_usual_wmode:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines_usual_wmode + content_lines[i+interlines+1:]
            interlines += 1
            break
    for modulename in modulenames_usual_wmask:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines_usual_wmask + content_lines[i+interlines+1:]
            interlines += 1
            break
    for modulename in modulenames_usual_wmask_wmode:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines_usual_wmask_wmode + content_lines[i+interlines+1:]
            interlines += 1
            break
    for modulename in modulenames_splitrw:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines_splitrw + content_lines[i+interlines+1:]
            interlines += 1
            break
    for modulename in modulenames_splitrw_nowmask:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines_splitrw_nowmask + content_lines[i+interlines+1:]
            interlines += 1
            break

with open(out_filepath, 'w') as out_file:
    out_file.write(''.join(content_lines))
