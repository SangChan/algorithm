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

class StackNode<T> : Equatable where T: Equatable {
    static func == (lhs: StackNode<T>, rhs: StackNode<T>) -> Bool {
        return lhs.data == rhs.data && lhs.next == rhs.next
    }
    
    let data : T
    var next : StackNode<T>? = nil
    
    init(with value: T) {
        self.data = value
    }
}

class StackByLinkedList<T> : StackProtocol where T : Equatable {
    private var top : StackNode<T>?
    
    func push(_ item: T) {
        let t : StackNode<T> = StackNode<T>.init(with: item)
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

// Queue

// Binary Search

// Bubble Sort

// Quick Sort

// DFS

// BFS
