# File: sorting.py
# Description: test sorting algorithms
# Student's Name: Alex Collins
# Course Name: CS 313E
# Unique Number: 51470

# Date Created: 11/29/2017
# Date Last Modified: 12/1/17

import random
import time
import sys
sys.setrecursionlimit(10000)

def bubbleSort(alist):
    for passnum in range(len(alist)-1,0,-1):
        for i in range(passnum):
            if alist[i] > alist[i+1]:
                temp = alist[i]
                alist[i] = alist[i+1]
                alist[i+1] = temp


def insertionSort(alist):
    for index in range(1,len(alist)):
        currentvalue = alist[index]
        position = index

        while position>0 and alist[position-1]>currentvalue:
            alist[position] = alist[position-1]
            position = position-1

        alist[position] = currentvalue


def mergeSort(alist):
    if len(alist) > 1:
        mid = len(alist) // 2
        lefthalf = alist[:mid]
        righthalf = alist[mid:]

        mergeSort(lefthalf)
        mergeSort(righthalf)

        i = 0
        j = 0
        k = 0

        while i<len(lefthalf) and j<len(righthalf):
            if lefthalf[i] < righthalf[j]:
                alist[k] = lefthalf[i]
                i += 1
            else:
                alist[k] = righthalf[j]
                j += 1
            k += 1

        while i < len(lefthalf):
            alist[k] = lefthalf[i]
            i += 1
            k += 1

        while j < len(righthalf):
            alist[k] = righthalf[j]
            j += 1
            k += 1


def quickSort(alist):
    quickSortHelper(alist,0,len(alist)-1)

def quickSortHelper(alist,first,last):
    if first < last:
        splitpoint = partition(alist,first,last)
        quickSortHelper(alist,first,splitpoint-1)
        quickSortHelper(alist,splitpoint+1,last)

def partition(alist,first,last):
    pivotvalue = alist[first]
    leftmark = first + 1
    rightmark = last
    done = False

    while not done:

        while leftmark <= rightmark and alist[leftmark] <= pivotvalue:
            leftmark += 1

        while alist[rightmark] >= pivotvalue and rightmark >= leftmark:
            rightmark -= 1

        if rightmark < leftmark:
            done = True
        else:
            temp = alist[leftmark]
            alist[leftmark] = alist[rightmark]
            alist[rightmark] = temp

    temp = alist[first]
    alist[first] = alist[rightmark]
    alist[rightmark] = temp

    return rightmark


def getRandList(length):
    myList = [i for i in range(length)]
    random.shuffle(myList)
    return myList

def getSortedList(length):
    myList = [i for i in range(length)]
    return myList

def getRevList(length):
    myList = getSortedList(length)
    myList[::-1]
    return myList

def getAlmostList(length):
    myList = getSortedList(length)
    # swap 10% of elements 
    for i in range(length//10):
        swap1 = random.randint(0, length-1)
        swap2 = random.randint(0, length-1)
        myList[swap1], myList[swap2] == myList[swap2], myList[swap1]
    return myList

def testBubble(listType, length):
    # create a var to hold total time
    totalTime = 0
   
    # time bubble sort
    for i in range(5):
        if listType == "rand":
            myList = getRandList(length)
        elif listType == "sort":
            myList = getSortedList(length)
        elif listType == "rev":
            myList = getRevList(length)
        else:
            myList = getAlmostList(length)

        startTime = time.clock()
        bubbleSort(myList)
        endTime = time.clock()    
       
        elapsedTime = endTime - startTime
        totalTime += elapsedTime
   
    # return the average time
    avgTime = float(totalTime) / 5.0
    return "{:.6f}".format(avgTime)

def testInsertion(listType, length):
    # create a var to keep track of total time
    totalTime = 0
   
    # time bubble sort
    for i in range(5):
        if listType == "rand":
            myList = getRandList(length)
        elif listType == "sort":
            myList = getSortedList(length)
        elif listType == "rev":
            myList = getRevList(length)
        else:
            myList = getAlmostList(length)

        startTime = time.clock()
        insertionSort(myList)
        endTime = time.clock()    
       
        elapsedTime = endTime - startTime
        totalTime += elapsedTime
   
    # return the average time
    avgTime = float(totalTime) / 5.0
    return "{:.6f}".format(avgTime)

def testMerge(listType, length):
    # create a var to keep track of total time
    totalTime = 0
   
    # time bubble sort
    for i in range(5):
        if listType == "rand":
            myList = getRandList(length)
        elif listType == "sort":
            myList = getSortedList(length)
        elif listType == "rev":
            myList = getRevList(length)
        else:
            myList = getAlmostList(length)

        startTime = time.clock()
        mergeSort(myList)
        endTime = time.clock()    
       
        elapsedTime = endTime - startTime
        totalTime += elapsedTime
   
    # return the average time
    avgTime = float(totalTime) / 5.0
    return "{:.6f}".format(avgTime)

def testQuick(listType, length):
    # create a var to keep track of total time
    totalTime = 0
   
    # time bubble sort
    for i in range(5):
        if listType == "rand":
            myList = getRandList(length)
        elif listType == "sort":
            myList = getSortedList(length)
        elif listType == "rev":
            myList = getRevList(length)
        else:
            myList = getAlmostList(length)

        startTime = time.clock()
        quickSort(myList)
        endTime = time.clock()    
       
        elapsedTime = endTime - startTime
        totalTime += elapsedTime
   
    # return the average time
    avgTime = float(totalTime) / 5.0
    return "{:.6f}".format(avgTime)

def main():
    print("Input type = Random")
    print("                    avg time   avg time   avg time")
    print("   Sort function     (n=10)    (n=100)    (n=1000)")
    print("-----------------------------------------------------")

    bubble10 = testBubble("rand", 10)
    bubble100 = testBubble("rand", 100)
    bubble1000 = testBubble("rand", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("bubbleSort", bubble10, bubble100, bubble1000))

    insertion10 = testInsertion("rand", 10)
    insertion100 = testInsertion("rand", 100)
    insertion1000 = testInsertion("rand", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("insertionSort", insertion10, insertion100, insertion1000))
    
    merge10 = testMerge("rand", 10)
    merge100 = testMerge("rand", 100)
    merge1000 = testMerge("rand", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("mergeSort", merge10, merge100, merge1000))

    quick10 = testQuick("rand", 10)
    quick100 = testQuick("rand", 100)
    quick1000 = testQuick("rand", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("quickSort", quick10, quick100, quick1000))


    print("\n\nInput type = Sorted")
    print("                    avg time    avg time   avg time")
    print("   Sort function     (n=10)     (n=100)    (n=1000)")
    print("-----------------------------------------------------")

    bubble10 = testBubble("sort", 10)
    bubble100 = testBubble("sort", 100)
    bubble1000 = testBubble("sort", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("bubbleSort", bubble10, bubble100, bubble1000))

    insertion10 = testInsertion("sort", 10)
    insertion100 = testInsertion("sort", 100)
    insertion1000 = testInsertion("sort", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("insertionSort", insertion10, insertion100, insertion1000))
    
    merge10 = testMerge("sort", 10)
    merge100 = testMerge("sort", 100)
    merge1000 = testMerge("sort", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("mergeSort", merge10, merge100, merge1000))

    quick10 = testQuick("sort", 10)
    quick100 = testQuick("sort", 100)
    quick1000 = testQuick("sort", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("quickSort", quick10, quick100, quick1000))


    print("\n\nInput type = Reverse")
    print("                    avg time   avg time   avg time")
    print("   Sort function     (n=10)    (n=100)    (n=1000)")
    print("-----------------------------------------------------")

    bubble10 = testBubble("rev", 10)
    bubble100 = testBubble("rev", 100)
    bubble1000 = testBubble("rev", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("bubbleSort", bubble10, bubble100, bubble1000))

    insertion10 = testInsertion("rev", 10)
    insertion100 = testInsertion("rev", 100)
    insertion1000 = testInsertion("rev", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("insertionSort", insertion10, insertion100, insertion1000))
    
    merge10 = testMerge("rev", 10)
    merge100 = testMerge("rev", 100)
    merge1000 = testMerge("rev", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("mergeSort", merge10, merge100, merge1000))

    quick10 = testQuick("rev", 10)
    quick100 = testQuick("rev", 100)
    quick1000 = testQuick("rev", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("quickSort", quick10, quick100, quick1000))


    print("\n\nInput type = Almost Sorted")
    print("                    avg time   avg time   avg time")
    print("   Sort function     (n=10)    (n=100)    (n=1000)")
    print("-----------------------------------------------------")

    bubble10 = testBubble("a", 10)
    bubble100 = testBubble("a", 100)
    bubble1000 = testBubble("a", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("bubbleSort", bubble10, bubble100, bubble1000))

    insertion10 = testInsertion("a", 10)
    insertion100 = testInsertion("a", 100)
    insertion1000 = testInsertion("a", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("insertionSort", insertion10, insertion100, insertion1000))
    
    merge10 = testMerge("a", 10)
    merge100 = testMerge("a", 100)
    merge1000 = testMerge("a", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("mergeSort", merge10, merge100, merge1000))

    quick10 = testQuick("a", 10)
    quick100 = testQuick("a", 100)
    quick1000 = testQuick("a", 1000)
    print("{:>16} {:>11} {:>10} {:>10}".format("quickSort", quick10, quick100, quick1000))

main()
