# Advent of Code 2021 Day 8
# Author: Tobi

import sys, itertools

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

f = {'cf': '1', 'bcdf': '4', 'acf': '7', 'abcdefg': '8', 'abcefg': '0', 'acdeg': '2', 'acdfg': '3', 'abdfg': '5', 'abdefg': '6', 'abcdfg': '9'}

def order(s):
    return ''.join(sorted(s))

n = m = 0
for line in inp:
    a, b = line.split(' | ')
    a = a.split(' ')
    b = b.split(' ')
    
    # all ways the wires could have been mixed up
    for p in itertools.permutations('abcdefg'):
        # mapping of the mixed up wires to the actual wires
        pp = {p[0]: 'a', p[1]: 'b', p[2]: 'c', p[3]: 'd', p[4]: 'e', p[5]: 'f', p[6]: 'g'}

        # for every num, replace it by a string of what it maps to using the attempted config
        aa = [order(''.join(pp[c] for c in x)) for x in a]
        bb = [order(''.join(pp[c] for c in x)) for x in b]

        # the lhs results in correct mapping
        if all(order(an) in f for an in aa):
            n += len(''.join(f[x] for x in bb if int(f[x]) in [1,4,7,8]))
            m += int(''.join(f[x] for x in bb))
            break
print(n,m)
