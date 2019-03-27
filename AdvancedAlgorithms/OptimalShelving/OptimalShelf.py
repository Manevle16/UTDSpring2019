import heapq
import math
def OptimalShelving(books, shelves, f):
    #books.sort(reverse = True)
    #print(books)

    i = 0
    j = 0
    space = int(shelves[0][0]*f)
    print(space)
    W = sum(books)
    parts = math.ceil(W/(shelves[0][0]*(1-f)))
    space = shelves[0][0] - math.floor(sum(books)/parts)
    print("parts: {0}   space: {1}".format(parts, space))


    '''
    Use max heap
    for shelf in shelves:
        heapq.heappush(shelf)
    '''
    '''
    while(len(books) > 0):
        max = 0
        ind = 0
        # Possibly use heap for this
        # shelf = heapq.pop()
        for i in range(0, parts):
            if(max < shelves[i][0]):
                max = shelves[i][0]
                ind = i
        #shelves[shelf.ind][0] -= books[0]
        #heappq.push(shelves[ind][0])
        #shelves[shelves].append(books.pop(0))
        shelves[ind][0] -= books[0]
        shelves[ind].append(books.pop(0))
    '''

    while(j < len(books)):
        if shelves[i][0] - space < books[j]:
            i += 1
        shelves[i][0] -= books[j]
        shelves[i].append(books[j])
        j += 1

    print(shelves)
