import OptimalShelf
import random

random.seed(55)
books = []
shelves = []
for i in range(0, 30):
    books.append(random.randint(1, 10))

for i in range(0, 20):
    shelves.append([])
    shelves[i].append(30)

print(books)
print(shelves)

space = .2

OptimalShelf.OptimalShelving(books, shelves, space)
