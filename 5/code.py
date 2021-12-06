# Advent of Code 2021 Day 5
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

arr = []

for i in range(1000):
    arr.append([0 for j in range(1000)])

for line in inp:
    fromx, fromy = line.split(" -> ")[0].split(",")
    tox, toy = line.split(" -> ")[1].split(",")
    
    fromx = int(fromx)
    fromy = int(fromy)
    tox = int(tox)
    toy = int(toy)

    minx = min(fromx, tox)
    maxx = max(fromx, tox)
    miny = min(fromy, toy)
    maxy = max(fromy, toy)

    if fromx != tox and fromy != toy:
        #consider diag
        dx = 1
        dy = 1

        if fromx > tox:
            dx = -1
        if fromy > toy:
            dy = -1
        
        while fromx != tox and fromy != toy:
            arr[fromy][fromx] += 1
            fromx += dx
            fromy += dy
        # last pt when theyre eq
        arr[fromy][fromx] += 1
        continue

    for i in range(minx, maxx+1):
        for j in range(miny, maxy+1):
            arr[j][i] += 1

c = 0

for row in arr:
    for x in row:
        if x > 1:
            c += 1

print(c)


