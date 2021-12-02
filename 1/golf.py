print(sum([j := 2, x := [int(h) for h in open('i').read().split('\n')], [1 for i in range(1+j,len(x)) if sum(x[i-1-j:i]) < sum(x[i-j:i+1])]][2]))
