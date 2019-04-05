'''
1.	(50 points) Design, analyze, and prove correctness for the multiplication of two n-bit numbers based on Divide-and-Conquer techniques including the order of growth.
'''
import math
import random

def MultBinary(x, y):

    total = None
    i = 0
    for yValue in reversed(y):
        prod = []

        for xValue in x:
            prod.append(xValue * yValue)
        for j in range(i):
            prod.append(0)
        print("Product:", prod)
        carry = 0
        if(total == None):
            total = prod
        else:
            longestLength = 0
            newTotal = []
            if(len(prod) > len(total)):
                while(len(prod) != len(total)):
                    total.insert(0, 0)
            if(len(prod) < len(total)):
                while(len(prod) != len(total)):
                    prod.insert(0, 0)
            for j in reversed(range(len(total))):

                prodValue = prod[j]
                totalValue = total[j]

                sum = (prodValue ^ totalValue) ^ carry
                carry = ((prodValue and carry) or (prodValue and totalValue) or (totalValue and carry))
                newTotal.insert(0, sum)
                if(j == longestLength and carry == 1):
                    newTotal.insert(0, 1)

            total = newTotal
        print("Total:", total, end='\n\n')
        i += 1
    print(total)




random.seed()
x = []
y = []
for i in range(random.randint(2,6)):
    x.append(random.randint(0,1))
    print(x[i], end='')

print()
for i in range(random.randint(2,6)):
    y.append(random.randint(0,1))
    print(y[i], end='')
print()




MultBinary(x, y)
