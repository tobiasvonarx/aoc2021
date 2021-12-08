# Advent of Code 2021 Day 7
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip()

z = 100000000000000000000000000000000000
res = -1

x = [int(i) for i in inp.split(',')]

for y in range(max(x)+1):
    s = 0
    for i in x:
        d = abs(i - y)
        for j in range(d):
            d += j

        # dist per fuel
        s += d
    if s < z:
        z = s
        res = s

print(z)


