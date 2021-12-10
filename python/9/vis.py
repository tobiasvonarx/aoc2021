# Advent of Code 2021 Day 9
# Author: Tobi

import sys, numpy as np
from PIL import Image

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n')

x = []
drw = []

for line in inp:
    x.append([int(l) for l in line])


def dbg(x):
    for i in range(len(x)):
        for j in range(len(x[i])):
            print(x[i][j],end='')
        print()

def a(nm):
    px = []
    for i in range(len(drw)):
        row = []
        for j in range(len(drw[i])):
            e = drw[i][j]
            #o = c(pn([i/100, j/100]) * 10)
            #print(o)

            if e==0: row.append((158,10,66))
            if e==1: row.append((213,62,79))
            if e==2: row.append((244,109,67))
            if e==3: row.append((253,174,97))
            if e==4: row.append((254,224,139))
            if e==5: row.append((230,245,152))
            if e==6: row.append((171,221,164))
            if e==7: row.append((102,194,165))
            if e==8: row.append((50,136,189))
            if e==9: row.append((94,79,162))
        px.append(row)
    ar = np.array(px, dtype=np.uint8)
    im = Image.fromarray(ar)
    im = im.resize((1000,1000), resample=Image.BOX)
    im.save(nm)


def prep(v,k):
    # color the visited ones with 9
    while not all(drw[i][j] == 9 for i,j in v):
        for i,j in v:
            if drw[i][j] < 9:
                drw[i][j] += 1
        a('im'+str(k)+'.png')
        k = k + 1
        print("generating picture",k)
    return k

drw = x
a('im0.png')

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
                islo = False
                break
        if islo:
            lo.append((i,j))
            
res = 0
for i,j in lo:
    res += x[i][j]+1
print(res)

# bfs for low points
b = []
k = 0
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
            k = prep(vis,k)
    # amount of visited nums is the size of the basin
    b.append(len(vis))

b = sorted(b)
print(b[-1] * b[-2] * b[-3])
