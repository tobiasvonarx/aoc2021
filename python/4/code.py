# Advent of Code 2021 Day 4
# Author: Tobi
import sys

FILENAME = 'input.txt'
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

with open(FILENAME, 'r') as input_file:
    inp = input_file.read().strip().split('\n\n')

rules = inp[0]
rules = rules.split(",")

boards = inp[1:]

def win(b,draw,x):
    r = 0
    for i in b:
        for j in i.split():
            if j not in draw:
                r += int(j)

    print("UNMARKED SUM",r,"WIN WHILE PROCESSING",x) 
    print(int(r)*int(x))

    # p1
    #sys.exit(0)

draw = []

print(boards)

for x in rules:
    #print("processing number",x)
    draw.append(x)
    for i in boards:
        # 5 rows are a board
        b = i.strip().split("\n")
        #print("checking board",b)
        for j in range(5):
            board = b[j].split()
            #check how many cards are in there
            res = [ele for ele in draw if ele in board]
            #print("checking row",board,"with drawn numbers",draw)
            if len(res) == 5:
                win(b,draw,x)
                
                #p2
                boards.remove(i)
                continue
            elif len(res) > 5:
                print("oof")

            # cols
            res = [ele for ele in draw if ele in [b[k].split()[j] for k in range(5)]]
            
            if len(res) == 5:
                print("col win")
                win(b,draw,x)
                
                # p2
                boards.remove(i)
            elif len(res) > 5:
                print("oof")
            
            # diag
            """
            # postmortem: FUCK I DIDNT NEED THIS
            res = [ele for ele in draw if ele in [i.strip().split("\n")[k].split()[k] for k in range(5)]]
            if len(res) == 5:
                win(b,draw,x)
            elif len(res) > 5:
                print("oof")
            # other diag

            res = [ele for ele in draw if ele in [i.strip().split("\n")[k].split()[4-k] for k in range(5)]]
            if len(res) == 5:
                win(b,draw,x)
            elif len(res) > 5:
                print("oof")
            """
