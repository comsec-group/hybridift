# Copyright 2024 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

# Replaces instances of unwanted taint wires to avoid unhappy tools.

import re
import sys

in_filepath = sys.argv[1]
out_filepath = sys.argv[2]

regexes = [
    re.compile(r',\s*\n\s*\.taint_meta_reset_t0\(taint_meta_reset_t0\)'),
    re.compile(r',\s*\n\s*\.PortAClk_t0\([^)]*\)'),
    re.compile(r',\s*\n\s*\.RW0_clk_t0\([^)]*\)'),
    re.compile(r',\s*\n\s*\.W0_clk_t0\([^)]*\)'),
    re.compile(r',\s*\n\s*\.R0_clk_t0\([^)]*\)'),
]

with open(in_filepath, 'r') as in_file:
    content = in_file.read()

for curr_regex in regexes:
    content = curr_regex.sub('', content)

with open(out_filepath, 'w') as out_file:
    out_file.write(content)

