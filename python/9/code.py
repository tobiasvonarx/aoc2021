# Advent of Code 2021 Day 9
# Author: Tobi

import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

x = []

# yeeted this relative map
# y = []

for line in inp:
    x.append([int(l) for l in line])
    #y.append([0 for _ in line])


def dbg(x):
    for i in range(len(x)):
        for j in range(len(x[i])):
            print(x[i][j],end='')
        print()

#dbg(x)

def neighbors(v):
    n = []
    i,j = v
    if i > 0:
        n.append((i-1,j))
    if i < 99:
        n.append((i+1,j))
    if j > 0:
        n.append((i,j-1))
    if j < 99:
        n.append((i,j+1))
    #print("neighbors of",v,"are",n)
    return n


lo = []
for i in range(len(x)):
    for j in range(len(x[i])):
        if x[i][j] == 9:
            continue

        n = neighbors((i,j))
        islo = True

        for ii,jj in n:
            if not (x[i][j] < x[ii][jj]):
                #print(i,j,"is not a lp")
                # i j not a sink
                islo = False
                break
        if islo:
            #print(i,j,"is a lp")
            lo.append((i,j))
            
#dbg(lo)

res = 0
for i,j in lo:
    res += x[i][j]+1
print(res)


# bfs for low points
b = []
for l in lo:
    vis = set()
    q = [l]
    while q:
        p = q.pop(0)
        for i,j in neighbors(p):
            if i < 0 or i > 99 or j < 0 or j > 99 or (i,j) in vis or x[i][j] == 9:
                continue
            vis.add((i,j))
            q.append((i,j))
    # amount of visited nums is the size of the basin
    b.append(len(vis))

b = sorted(b)
print(b[-1] * b[-2] * b[-3])
