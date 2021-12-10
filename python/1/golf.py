print(sum([j := 3, x := [int(h) for h in open('i').read().split('\n')], [1 for i in range(j,len(x)) if x[i-j] < x[i]]][2]))
