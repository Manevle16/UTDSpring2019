
import math
def OptimalShelving(books, shelves, f):
    books.sort(reverse = True)
    print(books)

    i = 0
    j = 0
    space = int(shelves[0][0]*f)
    W = sum(books)
    parts = math.ceil(W/(shelves[0][0]*(1-f)))
    print(parts)

    '''
    for book in books:
        if(shelves[i][0] - space < book):
            k = j + 1
            shelved = False
            while(k < len(books)):
                if(shelves[i][0] - space >= books[k]):
                    shelves[i][0] -= books[k]
                    shelves[i].append(books[k])
                    books.pop(k)
                    shelved = True
                k += 1
            if shelved == False:
                i += 1
                shelves[i][0] -= book
                shelves[i].append(book)
        else:
            shelves[i][0] -= book
            shelves[i].append(book)
        j += 1
    print(shelves)
    '''


    while(len(books) > 0):
        max = 0
        ind = 0
        for i in range(0, parts):
            if(max < shelves[i][0]):
                max = shelves[i][0]
                ind = i
        shelves[ind][0] -= books[0]
        shelves[ind].append(books.pop(0))

    print(shelves)
