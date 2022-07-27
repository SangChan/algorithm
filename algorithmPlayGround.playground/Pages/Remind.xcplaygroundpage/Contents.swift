//: [Previous](@previous)

import Foundation

// Stack

protocol StackProtocol {
    associatedtype T : Equatable
    func push(_ item: T)
    func pop() -> T?
    func peek() -> T?
    func isEmpty() -> Bool
}

class StackByArray<T> : StackProtocol where T : Equatable {
    private var items : [T] = []
    
    func push(_ item: T) {
        items.append(item)
    }
    
    func pop() -> T? {
        return items.popLast()
    }
    
    func peek() -> T? {
        return items.last
    }
    func isEmpty() -> Bool {
        return items.isEmpty
    }
}

var stack = StackByArray<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)
stack.peek()
stack.peek()
stack.peek()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()

let stackString = StackByArray<String>()
stackString.push("가")
stackString.push("나다")
stackString.push("라마바사")
stackString.push("아자차카타파하")
stackString.push("A")
stackString.peek()
stackString.peek()
stackString.peek()
stackString.pop()
stackString.pop()
stackString.pop()
stackString.pop()
stackString.pop()
stackString.pop()
stackString.pop()
stackString.pop()

class LinkedListNode<T> : Equatable where T: Equatable {
    static func == (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        return lhs.data == rhs.data && lhs.next == rhs.next
    }
    
    let data : T
    var next : LinkedListNode<T>? = nil
    
    init(with value: T) {
        self.data = value
    }
}

class StackByLinkedList<T> : StackProtocol where T : Equatable {
    private var top : LinkedListNode<T>?
    
    func push(_ item: T) {
        let t : LinkedListNode<T> = LinkedListNode<T>.init(with: item)
        t.next = top
        top = t
    }
    
    func pop() -> T? {
        let item = top?.data
        top = top?.next
        return item
    }
    
    func peek() -> T? {
        return top?.data
    }
    
    func isEmpty() -> Bool {
        return (top == nil)
    }
}

var stackNode = StackByLinkedList<Int>()
stackNode.push(1)
stackNode.push(2)
stackNode.push(3)
stackNode.push(4)
stackNode.push(5)
stackNode.peek()
stackNode.peek()
stackNode.peek()
stackNode.pop()
stackNode.pop()
stackNode.pop()
stackNode.pop()
stackNode.pop()
stackNode.pop()
stackNode.pop()
stackNode.pop()

// Heap

class HeapType {
    private var heap: [Int] = [Int].init(repeating: Int.max, count: 20)
    private var size : Int
    
    init(with size: Int) {
        self.size = size
    }
    
    //max heap
    func insert(_ item: Int) {
        size += 1
        var index : Int = size
        
        while(index != 0 && item > heap[index/2]) {
            heap[index] = heap[index/2]
            index /= 2
        }
        heap[index] = item
    }
}

var heap1 : HeapType = .init(with: 0)
heap1.insert(1)
heap1.insert(2)
heap1.insert(2)
heap1.insert(3)
heap1.insert(3)
heap1.insert(4)
heap1.insert(5)
heap1.insert(6)
heap1.insert(7)
heap1.insert(9)
heap1.insert(8)

// Queue

protocol QueueProtocol {
    associatedtype T : Equatable
    func add(_ item: T)
    func remove() -> T?
    func peek() -> T?
    func isEmpty() -> Bool
}

class QueueByNode<T> : QueueProtocol where T : Equatable {
    private var first: LinkedListNode<T>? = nil
    private var last: LinkedListNode<T>? = nil

    func add(_ item: T) {
        print("add item \(item)")
        let t : LinkedListNode<T> = .init(with: item)
        if last != nil { last?.next = t }
        last = t
        if first == nil { first = last }
        print("first = \(first?.data), first.next = \(first?.next?.data), first.next = \(first?.next?.next?.data), first.next = \(first?.next?.next?.next?.data), first.next = \(first?.next?.next?.next?.next?.data)")
        print("last = \(last?.data), last.next = \(last?.next?.data)")
    }
    
    func remove() -> T? {
        guard first != nil else { return nil }
        let data : T = first!.data
        first = first!.next
        
        if first == nil { last = nil }
        return data
    }
    
    func peek() -> T? {
        return first?.data
    }
    
    func isEmpty() -> Bool {
        return first == nil
    }
}

let queue : QueueByNode<Int> = .init()
queue.add(1)
queue.add(2)
queue.add(3)
queue.add(4)
queue.add(5)
queue.peek()
queue.peek()
queue.peek()
queue.remove()
queue.remove()
queue.remove()
queue.remove()
queue.remove()
queue.remove()
queue.remove()
queue.remove()

// Binary Search

let sorted : [Int] = [5,10,14,25,27,32,39,45,52,60]

func binarySearchIteration(_ key: Int, low: Int, high: Int) -> Int {
    var low : Int = low
    var high : Int = high
    while low <= high {
        let mid: Int = low + ((high - low)/2)
        if sorted[mid] == key {
            return mid
        } else if sorted[mid] > key {
            high = mid - 1
        } else {
            low = mid + 1
        }
     }
    return -1
}

func binarySearchRecursion(_ key: Int, low: Int, high: Int) -> Int {
    guard low <= high else { return -1 }
    let mid : Int = low + ((high - low)/2)
    
    if sorted[mid] == key {
        return mid
    } else if sorted[mid] > key {
        return binarySearchRecursion(key, low: low, high: mid - 1)
    } else {
        return binarySearchRecursion(key, low: mid + 1, high: high)
    }
}

binarySearchIteration(32, low: 0, high: sorted.count - 1)
binarySearchRecursion(32, low: 0, high: sorted.count - 1)

// Bubble Sort

func swap(with arr : inout [Int], i : Int, j : Int) {
    let temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
}

var bubbleArr : [Int] = [7,4,5,1,3]

func bubbleSort(with arr : inout [Int]) {
    
    for i in 0 ..< arr.count {
        for j in 0 ..< arr.count - i - 1 {
            if arr[j] > arr[j+1] {
                swap(with: &arr, i: j, j: j+1)
            }
        }
    }
}

bubbleSort(with: &bubbleArr)

// Quick Sort

var quickArr : [Int] = [5,3,8,4,9,1,6,2,7]

func partition(with arr : inout [Int], left: Int, right : Int) -> Int {
    var low : Int = left
    var high : Int = right + 1
    let pivot = arr[left]
    
    repeat {
        repeat {
            low += 1
        } while (low <= right && arr[low] < pivot)
        
        repeat {
            high -= 1
        }while (high>=left && arr[high] > pivot)
        
        if low < high {
            swap(with: &arr, i: low, j: high)
        }
    } while (low < high)
    
    swap(with: &arr, i: left, j: high)
    
    return high
}

func quickSort(with arr : inout [Int], left : Int, right : Int) {
    if left < right {
        let q = partition(with: &arr, left: left, right: right)
        
        quickSort(with: &arr, left: left, right: q - 1)
        quickSort(with: &arr, left: q + 1, right: right)
    }
}

quickSort(with: &quickArr, left: 0, right: quickArr.count - 1)

// DFS

// BFS

var array : [Int] = [1,2,3,4,5]
array.sorted()
array.sorted { $0 < $1 }
let strArr : [String] = array.map { num -> String in
    return "\(num)"
}
array.compactMap { num in
    return String(format: "%02d", num)
}
array.insert(0, at: 0)
array.firstIndex(of: 3)
array.firstIndex { $0 == 3 }
array.lastIndex(of: 3)
var strings : String = "hello world"
strings[strings.index(strings.startIndex, offsetBy: 0)]
strings[strings.index(strings.startIndex, offsetBy: 4)]
String(strings[...strings.index(strings.startIndex, offsetBy: 4)])
strings.range(of: "world")
let binary = String(255, radix:2)
