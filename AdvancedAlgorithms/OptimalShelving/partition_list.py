import statistics
def partition_list(a, k):
    #check degenerate conditions
    if k <= 1: return [a]
    if k >= len(a): return [[x] for x in a]
    #create a list of indexes to partition between, using the index on the
    #left of the partition to indicate where to partition
    #to start, roughly partition the array into equal groups of len(a)/k (note
    #that the last group may be a different size)
    partition_between = []
    for i in range(k-1):
        partition_between.append((i+1)*len(a)/k)
    #the ideal size for all partitions is the total height of the list divided
    #by the number of paritions
    average_height = float(sum(a))/k
    best_score = None
    best_partitions = None
    count = 0
    no_improvements_count = 0
    #loop over possible partitionings
    while True:
        #partition the list
        partitions = []
        index = 0
        for div in partition_between:
            #create partitions based on partition_between
            div = int(div)
            partitions.append(a[index:div])
            index = div
        #append the last partition, which runs from the last partition divider
        #to the end of the list
        partitions.append(a[index:])
        #evaluate the partitioning
        worst_height_diff = 0
        worst_partition_index = -1
        for p in partitions:
            #compare the partition height to the ideal partition height
            height_diff = average_height - sum(p)
            #if it's the worst partition we've seen, update the variables that
            #track that
            if abs(height_diff) > abs(worst_height_diff):
                worst_height_diff = height_diff
                worst_partition_index = partitions.index(p)
        #if the worst partition from this run is still better than anything
        #we saw in previous iterations, update our best-ever variables
        if best_score is None or abs(worst_height_diff) < best_score:
            best_score = abs(worst_height_diff)
            best_partitions = partitions
            no_improvements_count = 0
        else:
            no_improvements_count += 1
        #decide if we're done: if all our partition heights are ideal, or if
        #we haven't seen improvement in >5 iterations, or we've tried 100
        #different partitionings
        #the criteria to exit are important for getting a good result with
        #complex data, and changing them is a good way to experiment with getting
        #improved results
        if worst_height_diff == 0 or no_improvements_count > 5 or count > 100:
            return best_partitions
        count += 1
        #adjust the partitioning of the worst partition to move it closer to the
        #ideal size. the overall goal is to take the worst partition and adjust
        #its size to try and make its height closer to the ideal. generally, if
        #the worst partition is too big, we want to shrink the worst partition
        #by moving one of its ends into the smaller of the two neighboring
        #partitions. if the worst partition is too small, we want to grow the
        #partition by expanding the partition towards the larger of the two
        #neighboring partitions
        if worst_partition_index == 0:   #the worst partition is the first one
            if worst_height_diff < 0: partition_between[0] -= 1   #partition too big, so make it smaller
            else: partition_between[0] += 1   #partition too small, so make it bigger
        elif worst_partition_index == len(partitions)-1: #the worst partition is the last one
            if worst_height_diff < 0: partition_between[-1] += 1   #partition too small, so make it bigger
            else: partition_between[-1] -= 1   #partition too big, so make it smaller
        else:   #the worst partition is in the middle somewhere
            left_bound = worst_partition_index - 1   #the divider before the partition
            right_bound = worst_partition_index   #the divider after the partition
            if worst_height_diff < 0:   #partition too big, so make it smaller
                if sum(partitions[worst_partition_index-1]) > sum(partitions[worst_partition_index+1]):   #the partition on the left is bigger than the one on the right, so make the one on the right bigger
                    partition_between[right_bound] -= 1
                else:   #the partition on the left is smaller than the one on the right, so make the one on the left bigger
                    partition_between[left_bound] += 1
            else:   #partition too small, make it bigger
                if sum(partitions[worst_partition_index-1]) > sum(partitions[worst_partition_index+1]): #the partition on the left is bigger than the one on the right, so make the one on the left smaller
                    partition_between[left_bound] -= 1
                else:   #the partition on the left is smaller than the one on the right, so make the one on the right smaller
                    partition_between[right_bound] += 1


def print_best_partition(a, k):
    print('Partitioning {0} into {1} partitions'.format(a, k))
    p = partition_list(a, k)
    print('The best partitioning is {0}\n    With heights {1}\n'.format(p, list(map(sum, p))))
    shelve = list(map(sum, p))
    dev = []
    k = 0
    while(k != len(shelve)):
        dev.append(shelve[k])
        k += 1

    minDev = statistics.stdev(dev)

    print("Standard Deviation His: {0}".format(minDev))
