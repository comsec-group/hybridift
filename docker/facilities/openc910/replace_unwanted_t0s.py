# Replaces all instances of unwanted taint wires

import re
import sys

in_filepath = sys.argv[1]
out_filepath = sys.argv[2]

first_regex = re.compile(r',\s*\n\s*\.taint_meta_reset_t0\(taint_meta_reset_t0\)')
second_regex = re.compile(r',\s*\n\s*\.PortAClk_t0\([^)]*\)')

with open(in_filepath, 'r') as in_file:
    content = in_file.read()

content = first_regex.sub('', content)
content = second_regex.sub('', content)

with open(out_filepath, 'w') as out_file:
    out_file.write(content)

