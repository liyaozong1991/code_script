#!./python3env/bin/python3

import sys
import os

file_path = os.environ["mapreduce_map_input_file"]

label1 = ""
label2 = ""

for line in sys.stdin:
    line = line.strip("\n").strip("\r")
    line_items = line.split("\t")
    if label1 in file_path:
        if len(line_items) < 3:
            continue
        print("\t".join(["{}".format(k) for k in []]))
    elif label2 in file_path:
        if len(line_items) < 11:
            continue
        print("\t".join(["{}".format(k) for k in []]))
