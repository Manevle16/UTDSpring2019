import heapq
import math
import statistics
import copy

def OptimalShelving(books, shelves, f, L):
    #books.sort(reverse = True)
    #print(books)

    i = 0
    j = 0

    minSpace = L*f

    print("j = 0 to 29")
    while(j < len(books)):
        print("    j =", j)
        print("        if shelves[{4}][0]({0}) - minSpace({1}) < books[{2}]({3})".format(shelves[i][0], minSpace, j, books[j],i))
        if shelves[i][0] - minSpace < books[j]:
            i += 1
            print("            shelves.append([])")
            print("            shelves[{0}].append(books[{1}])".format(i,j))
            shelves.append([])
            shelves[i].append(L)
        print("        shelves[{0}][0]({1}) -= books[{2}]({3}) = {4}".format(i, shelves[i][0], j, books[j], shelves[i][0] - books[j]))
        print("        shelves[{0}].append(books[{1}])".format(i, j))
        shelves[i][0] -= books[j]
        shelves[i].append(books[j])
        j += 1
    print("shelves:", shelves)
    print()
    print("dev = []")
    dev = []
    i = 0
    print("i = 0 to 6")
    while(i != len(shelves)):
        print("    i =", i)
        print("        dev.append(shelves[{0}][0])".format(i))
        dev.append(shelves[i][0])
        i += 1
    print("dev =", dev)
    print()
    minDev = statistics.stdev(dev)
    print("minDev = getStandardDeviation(dev) = {0:.2f}".format(minDev))
    avg = sum(dev)/len(dev)
    print("avg = sum(dev)({0})/dev.size()({1}) = {2:.2f}".format(sum(dev), len(dev), avg))
    print("j = 0")
    print("count = 0\nshelvesCopy = deepCopy(shelves)")
    j = 0
    count = 0
    shelvesCopy = copy.deepcopy(shelves)
    print("j = 0 to 9")
    while(j < 10):
        print("    j =",j)
        print("        x = 0 to 6")
        for x in range(len(shelvesCopy)):
            print("            x =", x)
            print("                if shelvesCopy[{0}][0]({1}) > avg*1.1({2:.2f})".format(x, shelvesCopy[x][0], avg*1.1))
            if shelvesCopy[x][0] > avg * 1.1:
                if x != 6 and x != 0:
                    print("                    if x({0}) == 6 or (x({0}) > 0 and shelvesCopy[{1}][{2}]({3}) >= shelvesCopy[{4}][0]({5})".format(x,x-1,len(shelvesCopy[x-1])-1, shelvesCopy[x-1][len(shelvesCopy[x-1]) - 1], x+1, shelves[x+1][0]))
                elif x == 0:
                    print("                    if x({0}) == 6 or(x({0}) > 0".format(x))
                else:
                    print("                    if x({0}) == 6 or".format(x))
                if x == len(shelvesCopy) - 1 or (x > 0 and shelvesCopy[x-1][0] <= shelvesCopy[x+1][0]):
                    print("                        if shelvesCopy[{0}][0]({1}) - shelvesCopy[{2}][{3}]({4}) >= minspace({5})".format(x,shelvesCopy[x][0],x-1,len(shelvesCopy[x-1]) - 1, shelvesCopy[x-1][len(shelvesCopy[x-1]) - 1], minSpace ))
                    if shelvesCopy[x][0] - shelvesCopy[x-1][len(shelvesCopy[x-1]) - 1] >= minSpace:
                        print("                            book = shelvesCopy[{0}].pop()({1})".format(x-1, shelvesCopy[x-1][len(shelvesCopy[x-1]) - 1]))
                        book = shelvesCopy[x-1].pop()
                        print("                            shelvesCopy[{0}][0]({1}) += book({2}) = {3}".format(x-1, shelvesCopy[x-1][0], book, shelvesCopy[x-1][0] + book))
                        shelvesCopy[x-1][0] += book
                        print("                            shelvesCopy[{0}][0]({1}) -= book({2}) = {3}".format(x, shelvesCopy[x][0], book, shelvesCopy[x][0] - book))
                        shelvesCopy[x][0] -= book
                        print("                            shelvesCopy[{0}].insert(1, book)".format(x))
                        shelvesCopy[x].insert(1, book)
                else:
                    print("                    else if shelvesCopy[{0}][0]({1}) - shelvesCopy[{2}][{3}]({4}) >= minspace({5})".format(x,shelvesCopy[x][0],x+1,1, shelvesCopy[x+1][1], minSpace))
                    if shelvesCopy[x][0] - shelvesCopy[x+1][1] >= minSpace:
                        print("                            book = shelvesCopy[{0}].pop()({1})".format(x+1, shelvesCopy[x+1][1]))
                        book = shelvesCopy[x+1].pop(1)
                        print("                            shelvesCopy[{0}][0]({1}) += book({2}) = {3}".format(x+1, shelvesCopy[x+1][0], book, shelvesCopy[x+1][0] + book))
                        shelvesCopy[x+1][0] += book
                        print("                            shelvesCopy[{0}][0]({1}) -= book({2}) = {3}".format(x, shelvesCopy[x][0], book, shelvesCopy[x][0] - book))
                        shelvesCopy[x][0] -= book
                        print("                            shelvesCopy[{0}].append(book)".format(x))
                        shelvesCopy[x].append(book)
                print("                shelvesCopy =", shelvesCopy)
                print()
                print("                dev = []")
                dev = []
                i = 0
                print("                i = 0 to 6")
                while(i != len(shelves)):
                    print("                    i =", i)
                    print("                        dev.append(shelves[{0}][0]({1}))".format(i, shelvesCopy[i][0]))
                    dev.append(shelvesCopy[i][0])
                    i += 1
                print("                dev = {0}", dev)
                print()
                std = statistics.stdev(dev)
                print("                std = getStandardDeviation(dev) = {0:.2f}".format(std))
                print("                std({0:.2f}) < minDev({1:.2f})".format(std, minDev))
                if std < minDev:
                    print("                    shelves = deepCopy(shelvesCopy)")
                    print("                    minDev = std({0:.2f})".format(std))
                    print("                    avg = sum(dev)({0})/dev.size()({1}) = {2:.2f}".format(sum(dev), len(dev), avg))
                    print("                    count = 0")
                    shelves = copy.deepcopy(shelvesCopy)
                    minDev = std
                    avg = sum(dev)/len(dev)
                    count = 0

        count += 1
        print("        count += 1 =", count)
        print("        if count({0}) == 3".format(count))
        if count == 3:
            print("            break")
            break
        j += 1
    print("return shelves")
    print()
    print("shelves =", shelves)
    return shelves
