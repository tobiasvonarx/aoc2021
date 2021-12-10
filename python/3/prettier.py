# Advent of Code 2021 Day 3
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

def count_bits(arr):
    x = []
    for digit in arr[0]:
        x.append(int(digit))
    for line in arr[1:]:
        for i, digit in enumerate(line):
            if int(digit) == 1:
                x[i] += 1
            else:
                x[i] -= 1
    return x


with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

x = count_bits(inp)

print(x)

inp2 = inp

def p2(arr, flip):
    res = ''
    for i in range(len(arr[0])):
        if len(arr) == 0:
            break
        x = count_bits(arr)
        # most common val or least common one
        if flip:
            if x[i] > 0:
                arr = [k for k in arr if k[i] == '1']
            else:
                arr = [k for k in arr if k[i] == '0']
            if arr:
                res = arr[0]
        else:
            if x[i] < 0:
                arr = [k for k in arr if k[i] == '1']
            else:
                arr = [k for k in arr if k[i] == '0']
            if arr:
                res = arr[0]
    return res


o = p2(inp, False)
p = p2(inp2, True)

print(int(o,2)*int(p,2))

