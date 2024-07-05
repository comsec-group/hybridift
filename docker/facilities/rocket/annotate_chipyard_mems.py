# Does the manual annotation

import sys

rocket_modulenames = [
    "split_tag_array_ext",
    "split_data_arrays_0_0_ext",
    "split_data_arrays_0_ext",
]

boom_modulenames = [
    "split_array_0_0_ext",
    "split_btb_0_ext",
    "split_dataArrayWay_0_ext",
    "split_data_ext",
    "split_ebtb_ext",
    "split_ghist_0_ext",
    "split_hi_us_0_ext",
    "split_hi_us_ext",
    "split_l2_tlb_ram_ext",
    "split_meta_0_ext",
    "split_meta_ext",
    "split_rob_debug_inst_mem_ext",
    "split_table_0_ext",
    "split_table_1_ext",
    "split_table_ext",
    "split_tag_array_0_ext",
    "split_tag_array_ext",
]

annotation_lines = [
    "// @hybridift hybridift_latency: 1\n"
    "// @hybridift RW0_addr: COMBINED_ADDRESS_SIGNAL\n"
    "// @hybridift RW0_clk: CLOCK\n"
    "// @hybridift RW0_wdata: INPUT_DATA\n"
    "// @hybridift RW0_rdata: READ_DATA\n"
    "// @hybridift RW0_en: ENABLE\n"
    "// @hybridift RW0_wmode: WRITE_MASK\n"
]

# Should be the passthrough result
in_filepath = sys.argv[1]
out_filepath = sys.argv[2]

assert "rocket" in in_filepath or "boom" in in_filepath, f"Must have either Rocket or BOOM in the path, as we use the path to know which design it is. Path: {in_filepath}"
assert not ("rocket" in in_filepath and "boom" in in_filepath), "Cannot have both Rocket and BOOM in the same path, as we use the path to know which design it is"

is_rocket = "rocket" in in_filepath
modulenames = rocket_modulenames if is_rocket else boom_modulenames
del rocket_modulenames, boom_modulenames # For safety

with open(in_filepath, 'r') as in_file:
    content_lines = in_file.readlines()

interlines = 0 # So that they do not become shifted because of the insertions
for i, line in enumerate(content_lines):
    for modulename in modulenames:
        if line.startswith(f"module {modulename}("):
            content_lines = content_lines[:i+interlines+1] + annotation_lines + content_lines[i+interlines+1:]
            interlines += 1
            break

with open(out_filepath, 'w') as out_file:
    out_file.write(''.join(content_lines))
