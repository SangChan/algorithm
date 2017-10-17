//: [Previous](@previous)

import Foundation

class Stack<T> {
    fileprivate var array : [T] = [T]()
    
    public func size() -> Int {
        return array.count
    }
    
    public func push(x : T) {
        array.append(x)
    }
    
    public func pop() -> T? {
        return array.popLast()
    }
    
    public func isEmpty() -> Bool {
        return (array.count == 0) ? true : false
    }
}

let stack = Stack<Int>()
stack.push(x: 1)
stack.push(x: 2)
stack.push(x: 4)
for _ in 0..<stack.size() + 1{
    stack.pop()
}

class Queue<T> {
    fileprivate var array : [T] = [T]()
    
    func size() -> Int {
        return array.count
    }
    
    func enqueue(x : T) {
        array.append(x)
    }
    
    func dequeue() -> T? {
        guard array.isEmpty == false else { return nil }
        return array.removeFirst()
    }
}

let queue = Queue<Int>()
queue.enqueue(x: 1)
queue.enqueue(x: 2)
queue.enqueue(x: 3)
queue.enqueue(x: 4)
for _ in 0..<queue.size() + 1 {
    queue.dequeue()
}

class Tree<T> {
    var x : T!
    var left : Tree?
    var right : Tree?
    
    init() {
        self.x = nil
        self.left = nil
        self.right = nil
    }
    
    convenience init(x : T) {
        self.init()
        self.x = x
    }
    
    convenience init(x : T, left : Tree, right : Tree) {
        self.init()
        self.x = x
        self.left = left
        self.right = right
    }
    
    func inOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        inOrder(tree: treeForUse.left)
        // process tree.value
        inOrder(tree: treeForUse.right)
    }
    
    func inOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let stack = Stack<Tree>()
        var currentTree : Tree? = treeForUse
        while currentTree != nil || stack.isEmpty() == false {
            while currentTree != nil {
                stack.push(x: currentTree!)
                currentTree = currentTree!.left
            }
            
            currentTree = stack.pop()
            // process tree.value
            currentTree = currentTree!.right
        }
    }
    
    func preOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        // process tree.value
        preOrder(tree: treeForUse.left)
        preOrder(tree: treeForUse.right)
    }
    
    func preOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let stack = Stack<Tree>()
        stack.push(x: treeForUse)
        while stack.isEmpty() == false {
            if let currentTree = stack.pop() {
            
                // process tree.value
                if let right = currentTree.right {
                    stack.push(x: right)
                }
                if let left = currentTree.left {
                    stack.push(x: left)
                }
            }
        }
    }
    
    func postOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        postOrder(tree: treeForUse.left)
        postOrder(tree: treeForUse.right)
        // process tree.value
    }
    
    func postOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let tmpStack = Stack<Tree>()
        let allStack = Stack<Tree>()
        tmpStack.push(x: treeForUse)
        while tmpStack.isEmpty() == false {
            if let currentTree = tmpStack.pop() {
                allStack.push(x: currentTree)
                if let right = currentTree.right {
                    tmpStack.push(x: right)
                }
                if let left = currentTree.left {
                    tmpStack.push(x: left)
                }
            }
        }
        
        while allStack.isEmpty() == false {
            if let currentTree = allStack.pop() {
                // process tree.value
            }
        }
    }
}

struct Edge : Hashable, Equatable {
    let weight : Int
    let from : Int
    let to : Int
    
    var hashValue: Int {
        get {
            return weight.hashValue << 100 + from.hashValue << 10 + to.hashValue
        }
    }
}

func ==(lhs:Edge, rhs: Edge) -> Bool {
    return lhs.weight == rhs.weight && lhs.from == rhs.from && lhs.to == rhs.to
}

class Vertex {
    var id : Int
    var edges : Set<Edge> = Set<Edge>()
    var parent : Vertex?
    var distance : Int = Int.max
    var discovered : Bool = false
    
    init(id : Int) {
        self.id = id
    }
    
    func compareTo(vertext : Vertex) -> Int {
        if self.distance < vertext.distance { return -1 }
        else if self.distance > vertext.distance { return 1 }
        return 0
    }
}

struct Graph {
    var vertices : [Int : Vertex] = [Int : Vertex]()
}

class Trie {
    var char : Character?
    var chars : [Character : Trie] = [Character : Trie]()
    var isLeaf : Bool = false
    
    init() {
        self.char = nil
    }
    
    convenience init(char : Character) {
        self.init()
        self.char = char
    }
}

class BitSet {
    typealias Byte = UInt8
    private var a : [Byte] = [Byte]()
    
    func get(index : Int) -> Bool {
        let i = Int(index / 8)
        let modI = Int(index % 8)
        if a.count < i + 1 { return false }
        return (a[i] & 1 << (modI)) == 1 << (modI)
    }
    
    func set(index : Int, value : Bool) {
        let i = Int(index / 8)
        let modI = Int(index % 8)
        if a.count < i + 1 {
            a.append(UInt8(0))
        }
        
        if value == true {
            a[i] |= 1 << modI
        }
    }
}

var bs = BitSet()
bs.set(index: 0, value: false)
bs.set(index: 1, value: true)
bs.set(index: 2, value: false)
bs.set(index: 3, value: true)
bs.set(index: 4, value: true)
bs.get(index: 0)
bs.get(index: 1)
bs.get(index: 2)
bs.get(index: 3)
bs.get(index: 4)


