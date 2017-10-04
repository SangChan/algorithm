//: [Previous](@previous)

import Foundation

/*
 Sorting
 */

var sortList : Array<Int> = [8,2,10,9,11,1,7,3,4]

func insertionSort() {
    var x = 0 ,y = 0
    for key in sortList {
        print("{\(x):\(key)}")
        let newList = sortList.prefix(through: x)
        y = newList.count - 1
        for reverseKey in newList.reversed()  {
            print("[\(y):\(reverseKey)]")
            if key < reverseKey {
                print("oldSortList=\(sortList)")
                sortList.remove(at: y+1)
                sortList.insert(key, at: y)
                print("newSortList=\(sortList)")
            }
            y -= 1
        }
        x += 1
    }
    
    print("done \(sortList)")
}

//insertionSort()

func bubbleSort() {
    var x,y,z,passes,key: Int
    
    for x in 0..<sortList.count {
        passes = sortList.count - 1 - x
        print("{x=\(x),passes=\(passes)}")
        for y in 0..<passes {
            key = sortList[y]
            print("[y=\(y), key=\(key)]")
            if key > sortList[y+1] {
                print("oldSortList=\(sortList)")
                z = sortList[y+1]
                sortList[y+1] = key
                sortList[y] = z
                print("newSortList=\(sortList)")
            }
        }
    }
    
    print("done \(sortList)")
}

//bubbleSort()

func quickSort() {
    
}

func mergeSort() {
    
}

func selectionSort() {
    
}
