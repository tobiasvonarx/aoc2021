# Advent of Code 2021 Day 6
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = list(map(int, input_file.read().strip().split(',')))

def solve(y, n):
    for _ in range(n):
        n = y.pop(0)
        y[6] += n
        y.append(n)
    return sum(y)

z = 0
for i in range(1,257):
    # total number of fishes in all timesteps added
    x = [inp.count(i) for i in range(9)]
    o = solve(x, i)
    z += o
    print(o)

print(z,"fishes")
