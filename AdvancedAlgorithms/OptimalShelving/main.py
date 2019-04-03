import OptimalShelf
import partition_list
import random
import statistics
std = 0
length = 1
for i in range(length):
    random.seed(4)
    books = []
    shelves = []

    for j in range(0, 30):
        books.append(random.randint(1, 10))

    shelves.append([])
    shelves[0].append(30)
#    print(books)
    space = .2

    shelve = OptimalShelf.OptimalShelving(books, shelves, space, 30)
    k = 0
    dev = []
    while(k != len(shelve)):
        dev.append(shelve[k][0])
        k += 1

    minDev = statistics.stdev(dev)
    std += minDev
    avg = sum(dev)/len(dev)
    #print("Coef of Var: {0}".format(minDev/avg))
    #print(shelve)
    #print()



print(std/length)
