def MaxPairs(x, d):
    count = 0
    for i in range(len(x)):
        for j in range(1, d+1):
            if(j + i < len(x) and x[i] != x[j+i]):
                count += 1
    return count

x = [1, 0, 0, 1, 0, 1, 1]
d = 5
print(MaxPairs(x, d))
