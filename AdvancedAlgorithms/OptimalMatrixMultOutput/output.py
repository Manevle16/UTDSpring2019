import math

p = [8, 4, 2, 4, 4, 8]
n = len(p) - 1
m = [[0 for x in range(1,6)] for y in range(1,6)]
s = [[0 for x in range(1,6)] for y in range(1, 6)]
print(m)
print(s)


print("L = 2 to n")
for l in range(2, n+1):
    print("   L =", l)
    print("   i = 1 to", n-l+1)
    for i in range(1, n-l+2):
        print("      i =", i)
        j = i - 1 + l
        print("         j =", j)
        m[i-1][j-1] = math.inf
        print("         m[{0:d}][{1:d}] = inf".format(i,j))
        print("         k = {0:d} to {1:d}".format(i,j-1))
        for k in range(i, j):
            print("            k =", i)
            q = m[i-1][k-1] + m[k][j-1] + p[i-1]*p[k]*p[j]
            print("            q = m[{0:d}][{1:d}]({2:d}) + m[{3:d}][{4:d}]({5:d}) + {6:d}*{7:d}*{8:d} = {9:d}".format(i,k,m[i-1][k-1],k+1,j,m[k][j-1],p[i-1],p[k],p[j], q))
            print("            if {0:d} < m[{1:d}][{2:d}]({3})".format(q, i, j, m[i-1][j-1]))
            if q < m[i-1][j-1]:
                print("               m[{0}][{1}] = {2}".format(i, j, q))
                print("               s[{0}][{1}] = {2}".format(i, j, k))
                m[i-1][j-1] = q
                s[i-1][j-1] = k

for x in range(0,5):
    for y in range(0,5):
        print(m[x][y], end=", ")
    print("")
print("")
for x in range(0,5):
    for y in range(0,5):
        print(s[x][y], end=", ")
    print("")

def Print_Optimal_Paren(s, i, j):
    if i == j:
        print("A{0}".format(i), end='')
    else:
        print("(", end='')
        Print_Optimal_Paren(s, i, s[i-1][j-1])
        Print_Optimal_Paren(s,s[i-1][j-1]+1,j)
        print(")",end='')

Print_Optimal_Paren(s, 1, 5)
