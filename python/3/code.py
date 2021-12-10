# Advent of Code 2021 Day 3
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')
x = []

for digit in inp[0]:
    x.append(int(digit))
for line in inp[1:]:
    for i, digit in enumerate(line):
        if int(digit) == 1:
            x[i] += 1
        else:
            x[i] -= 1
print(x)

inp2 = inp

ox = ''
ot = ''

# oxygen
for i in range(len(inp2[0])):
    if len(inp2) == 0:
        break
    x = []
    for digit in inp2[0]:
        x.append(int(digit))
    for line in inp2[1:]:
        for j, digit in enumerate(line):
            if int(digit) == 1:
                x[j] += 1
            else:
                x[j] -= 1
    # most common val
    if x[i] > 0:
        inp2 = [k for k in inp2 if k[i] == '1']
    else:
        inp2 = [k for k in inp2 if k[i] == '0']
    if inp2:
        ox = inp2[0]

# other thingy
for i in range(len(inp[0])):
    if len(inp) == 0:
        break
    x = []
    for digit in inp[0]:
        x.append(int(digit))
    for line in inp[1:]:
        for j, digit in enumerate(line):
            if int(digit) == 1:
                x[j] += 1
            else:
                x[j] -= 1
    # most common val
    if x[i] < 0:
        inp = [k for k in inp if k[i] == '1']
    else:
        inp = [k for k in inp if k[i] == '0']
    if inp:
        ot = inp[0]

print(int(ox, 2)*int(ot, 2))
