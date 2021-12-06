# Advent of Code 2021 Day 6
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = list(map(int, input_file.read().strip().split(',')))

x = [inp.count(i) for i in range(9)]

for _ in range(256):
    n = x.pop(0)
    x[6] += n
    x.append(n)

print(sum(x))
