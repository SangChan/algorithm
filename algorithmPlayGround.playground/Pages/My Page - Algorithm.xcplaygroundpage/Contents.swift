//: [Previous](@previous)

import Foundation

func swap(a : inout [Int], i : Int, j : Int) {
    let tmp = a[i]
    a[i] = a[j]
    a[j] = tmp
}

var a : [Int] = [1,2,3,4,5]
swap(a : &a, i : 1, j : 2)

func insertionSort(a: inout [Int]) {
    for j in 1..<a.count {
        let key = a[j]
        var i = j-1
        
        while i >= 0 && a[i] > key {
            a[i+1] = a[i]
            i -= 1
        }
        
        a[i+1] = key
    }
}

var b: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
insertionSort(a: &b)

func selectionSort(a: inout [Int]) {
    for i in 0 ..< a.count {
        swap(a: &a, i: i, j: min(a: &a, start: i))
    }
}

fileprivate func min(a: inout [Int], start : Int) -> Int {
    var smallest = start
    
    for i in start+1 ..< a.count {
        if a[i] < a[smallest] {
            smallest = i
        }
    }
    
    return smallest
}
var c: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
min(a: &c, start: 0)
selectionSort(a: &c)

func mergeSort(a : [Int]) -> [Int] {
    if a.count <= 1 {
        return a
    }
    return mergeSort(a: a, low: 0, high: a.count-1)
}

fileprivate func mergeSort(a : [Int], low : Int, high : Int) -> [Int] {
    if low == high {
        return [a[low]]
    }
    let mid = Int((low + high)/2)
    let sorted1 = mergeSort(a: a, low: low, high: mid)
    let sorted2 = mergeSort(a: a, low: mid+1 , high: high)
    return merge(a: sorted1, b: sorted2)
}

fileprivate func merge(a: [Int], b: [Int]) -> [Int] {
    //print("a=\(a), b=\(b)")
    var res = [Int]()
    res.reserveCapacity(a.count + b.count)
    var i = 0
    var j = 0
    while i < a.count && j < b.count {
        if (a[i] < b[j]) {
            res.append(a[i])
            i += 1
        } else {
            res.append(b[j])
            j += 1
        }
    }
    
    while i < a.count {
        res.append(a[i])
        i += 1
    }
    
    while j < b.count {
        res.append(b[j])
        j += 1
    }
    
    //print("merge a and b = \(res)")
    
    return res
}
let d: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
let result = mergeSort(a: d)

func quickSort(a : inout [Int]) {
    quickSort(a: &a, low: 0, high: a.count-1)
}

fileprivate func quickSort(a : inout [Int], low : Int, high : Int) {
    if low >= high { return }
    let pivot = partition(a: &a, low: low, high: high)
    quickSort(a: &a, low: low, high: pivot-1)
    quickSort(a: &a, low: pivot+1, high: high)
}

fileprivate func partition(a: inout [Int], low : Int, high : Int) -> Int {
    var pivot = low
    let maxNum = high-low+1
    let rand = (Int(arc4random()) % maxNum) + low
    swap(a: &a, i: low, j: rand)
    
    for i in low+1 ..< high {
        if a[i] < a[pivot] {
            swap(a: &a, i: i, j: pivot+1)
            swap(a: &a, i: pivot, j: pivot+1)
            pivot += 1
        }
    }
    
    return pivot
}
var e: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
quickSort(a: &e)

func heapSort(a : inout [Int]) {
    for i in (0..<a.count).reversed() {
        heapify(a: &a, root: i, length: a.count)
    }
    
    for last in (0..<a.count).reversed() {
        swap(a: &a, i: 0, j: last)
        heapify(a: &a, root: 0, length: last)
    }
}

fileprivate func heapify(a : inout [Int], root : Int, length : Int) {
    let left = 2 * root + 1
    let right = 2 * root + 2
    var largest = root
    
    if left < length && a[largest] < a[left] {
        largest = left
    }
    if right < length && a[largest] < a[right] {
        largest = right
    }
    if largest != root {
        swap(a: &a, i: root, j: largest)
        heapify(a: &a, root: largest, length: length)
    }
}

var f: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
heapSort(a: &f)

func countingSort(a : [Int]) -> [Int] {
    let max = findMax(a: a)
    var sorted : [Int] = [Int](repeating: 0, count: a.count)
    var counts : [Int] = [Int](repeating: 0, count: max+1)
    
    for i in 0..<a.count {
        counts[a[i]] += 1
    }
    
    for i in 1..<counts.count {
        counts[i] += counts[i-1]
    }
    
    for i in 0..<a.count {
        sorted[counts[a[i]]-1] = a[i]
        counts[a[i]] -= 1
    }
    
    return sorted
}

fileprivate func findMax(a : [Int]) -> Int {
    if a.count == 0 {
        return 0
    }
    var max = Int.min
    for i in 0..<a.count {
        if a[i] > max {
            max = a[i]
        }
    }
    
    return max
}

let g: [Int] = [23, 1, 2, 34, 5, 98, 46, 1, 7, 57, 0, 8, 68, 6]
countingSort(a: g)

func binarySearch(a : [Int], x : Int) -> Int{
    return binarySearch(a: a, x: x, low: 0, high: a.count-1)
}

fileprivate func binarySearch(a : [Int], x : Int, low : Int, high : Int) -> Int {
    if low > high { return -1 }
    let mid = Int((low + high)/2)
    
    if a[mid] == x {
        return mid
    } else if a[mid] > x {
        return binarySearch(a: a, x: x, low: low, high: mid-1)
    } else {
        return binarySearch(a: a, x: x, low: mid+1, high: high)
    }
}

func quickSelect(a : inout [Int], k : Int)  -> Int{
    return quickSelect(a: &a, k: k, low: 0, high: a.count-1)
}

fileprivate func quickSelect(a : inout [Int], k : Int, low : Int, high : Int) -> Int {
    let pivot = partition(a: &a, low: low, high: high)
    if pivot == k {
        return a[pivot]
    } else if k < pivot {
        return quickSelect(a: &a, k: k, low: low, high: pivot-1)
    } else {
        return quickSelect(a: &a, k: k, low: pivot+1, high: high)
    }
}
