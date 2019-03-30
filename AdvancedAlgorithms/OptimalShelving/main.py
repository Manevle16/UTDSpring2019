import OptimalShelf
import partition_list
import random
import statistics
std = 0
length = 1
for i in range(length):
    random.seed(101)
    books = []
    shelves = []
    for j in range(0, 100):
        books.append(random.randint(1, 30))

    shelves.append([])
    shelves[0].append(90)

    space = .2

    shelve = OptimalShelf.OptimalShelving(books, shelves, space, 90)
    k = 0
    dev = []
    while(k != len(shelve)):
        dev.append(shelve[k][0])
        k += 1

    minDev = statistics.stdev(dev)
    std += minDev

    print("Standard Deviation Mine: {0}".format(minDev))
    print(shelves)
    print()



print(std/length)
