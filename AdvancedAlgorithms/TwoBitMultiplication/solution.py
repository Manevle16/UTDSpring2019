import random
def Add(lh, rh):
    while(len(lh) != len(rh)):
        if(len(lh) < len(rh)):
            lh.insert(0, 0)
        else:
            rh.insert(0, 0)
    carry = 0
    total = []
    for j in reversed(range(len(lh))):

        xValue = lh[j]
        yValue = rh[j]

        sum = (xValue ^ yValue) ^ carry
        carry = ((xValue and carry) or (xValue and yValue) or (yValue and carry))
        total.insert(0, sum)
        if(j == 0 and carry == 1):
            total.insert(0, 1)
    return total

def MultBinary(x, y, xW, yW):
    global num
    num += 1

    if(len(x) == 1 and len(y) == 1):
        s = []
        s.append(x[0] * y[0])
        for i in range(xW[0] + yW[0]):
            s.append(0)
        return s

    halfX = int(len(x)/2)
    halfY = int(len(y)/2)
    rHX = x[halfX:]
    rHXW = xW[halfX:]
    lHX = x[:halfX]
    lHXW = xW[:halfX]

    rHY = y[halfY:]
    rHYW = yW[halfY:]
    lHY = y[:halfY]
    lHYW = yW[:halfY]

    llSum = []
    lrSum = []
    rlSum = []
    rrSum = []

    if(len(x) == 1 and len(y) == 2):
        llSum = MultBinary(rHX, lHY, rHXW, lHYW)
        rrSum = MultBinary(rHX, rHY, rHXW, rHYW)
    elif(len(y) == 1 and len(x) == 2):
        llSum = MultBinary(lHX, rHY, lHXW, rHYW)
        rrSum = MultBinary(rHX, rHY, rHXW, rHYW)
    else:
        llSum = MultBinary(lHX, lHY, lHXW, lHYW)
        lrSum = MultBinary(lHX, rHY, lHXW, rHYW)
        rlSum = MultBinary(rHX, lHY, rHXW, lHYW)
        rrSum = MultBinary(rHX, rHY, rHXW, rHYW)

    lSum = Add(llSum, lrSum)
    rSum = Add(rlSum, rrSum)
    total = Add(lSum, rSum)

    return total
num = 0
x = []
for i in range(3):
    x.append(random.randint(1,1))
    print(x[i], end='')

print()
y = []
for i in range(3):
    y.append(random.randint(1,1))
    print(y[i], end='')
print()

xW = list(reversed(range(len(x))))
yW = list(reversed(range(len(y))))

#01001010110
print(MultBinary(x, y, xW, yW))
