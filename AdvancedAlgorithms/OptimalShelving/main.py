import OptimalShelf
import random

#random.seed(55)
books = []
shelves = []
for i in range(0, 30):
    books.append(random.randint(1, 10))

shelves.append([])
shelves[0].append(30)
print(books)

space = .2

OptimalShelf.OptimalShelving(books, shelves, space)
