//: Playground - noun: a place where people can play

import Foundation

/*
 Big O Notation
*/

let numberList : Array<Int> = [1,2,3,4,5,6,7,8,9,10]

func linearSearch(key : Int) {
    var tryCount : Int = 0
    for number in numberList {
        tryCount += 1
        if number == key {
            print("#\(tryCount) value \(key) is found")
            break
        }
    }
}

//linearSearch(key: 2)
//linearSearch(key: 5)
//linearSearch(key: 9)

var binarySearchCount = 0

func binarySearch(key: Int, iMin: Int, iMax: Int) {
    binarySearchCount += 1
    let midIndex : Int = Int(round(Double(iMin + iMax) / 2.0))
    let midNumber = numberList[midIndex]
    
    if midNumber > key{
        binarySearch(key: key, iMin: iMin, iMax: midIndex - 1)
    } else if midNumber < key {
        binarySearch(key: key, iMin: midIndex + 1, iMax: iMax)
    } else {
        print("#\(binarySearchCount) value \(key) is found")
    }
}

//binarySearchCount = 0
//binarySearch(key: 3, iMin: 0, iMax: 9)
//binarySearchCount = 0
//binarySearch(key: 5, iMin: 0, iMax: 9)
//binarySearchCount = 0
//binarySearch(key: 10, iMin: 0, iMax: 9)
