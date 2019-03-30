import heapq
import math
import statistics
import copy

def OptimalShelving(books, shelves, f, L):
    #books.sort(reverse = True)
    #print(books)

    i = 0
    j = 0

    minSpace = int(L*f)


    while(j < len(books)):
        if shelves[i][0] - minSpace < books[j]:
            i += 1
            shelves.append([])
            shelves[i].append(L)
        shelves[i][0] -= books[j]
        shelves[i].append(books[j])
        j += 1

    dev = []
    i = 0
    while(i != len(shelves)):
        dev.append(shelves[i][0])
        i += 1


    minDev = statistics.stdev(dev)
    avg = sum(dev)/len(dev)

    j = 0
    count = 0
    shelvesCopy = copy.deepcopy(shelves)
    while(j < 10):
        for x in range(len(shelvesCopy)):
            if shelvesCopy[x][0] > avg:
                if x == len(shelvesCopy) - 1 or (x > 0 and x < len(shelvesCopy) - 1 and shelvesCopy[x-1][0] <= shelvesCopy[x+1][0]):
                    if shelvesCopy[x][0] - shelvesCopy[x-1][len(shelvesCopy[x-1]) - 1] >= minSpace:
                        book = shelvesCopy[x-1].pop()
                        shelvesCopy[x-1][0] += book
                        shelvesCopy[x][0] -= book
                        shelvesCopy[x].insert(1, book)
                elif shelvesCopy[x][0] - shelvesCopy[x+1][1] >= minSpace:
                    book = shelvesCopy[x+1].pop(1)
                    shelvesCopy[x+1][0] += book
                    shelvesCopy[x][0] -= book
                    shelvesCopy[x].append(book)
            dev = []
            i = 0
            while(i != len(shelves)):
                dev.append(shelvesCopy[i][0])
                i += 1
            std = statistics.stdev(dev)

            if std < minDev:
                shelves = copy.deepcopy(shelvesCopy)
                minDev = std
                count = 0

        count += 1
        if count == 3:
            break
        j += 1

    return shelves
