# Advent of Code 2021 Day 2
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

x = 0
d = 0
a = 0

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

    for line in inp:
        l = line.split(' ')
        if l[0] == 'forward':
            x += int(l[1])
            d += int(l[1])*a
        elif l[0] == 'down':
            a += int(l[1])
        elif l[0] == 'up':
            a -= int(l[1])
    print(x * d)



print('Part One : '+ str(None))



print('Part Two : '+ str(None))

