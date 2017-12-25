#!./python3env/bin/python3
import sys

label1 = ""
label2 = ""

def update():
    global key_pre, key_cur, a, b, c
    a, b, c = "", "", ""

def add():
    global key_pre, key_cur, a, b, c
    key_pre = key_cur
    # pingback url
    if label == label1:
        pass
    elif label == label2:
        pass

def output():
    global key_pre, key_cur, a, b, c
    pass

key_pre, key_cur = "", ""
update()
for line in sys.stdin:
    line = line.strip("\n").strip("\r")
    line_items = line.split("\t")
    if len(line_items) < 2:
        continue
    key_cur = line_items[0]
    label = line_items[1]
    if key_pre != "" and key_pre != key_cur:
        output()
        update()
    add()
if key_pre != "":
    output()
