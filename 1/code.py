# Advent of Code 2021 Day 1
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split("\n")
    x =  [int(x) for x in inp]

    z  = 0
    for i in range(3,len(x)):
        if x[i-3]+x[i-2]+x[i-1] < x[i-2]+x[i-1]+x[i]:
            z = z + 1


    print(z)



print('Part One : '+ str(None))



print('Part Two : '+ str(None))

