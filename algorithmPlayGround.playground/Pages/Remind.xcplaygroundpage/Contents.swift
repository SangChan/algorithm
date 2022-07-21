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

// Bubble Sort

// Quick Sort

// DFS

// BFS
