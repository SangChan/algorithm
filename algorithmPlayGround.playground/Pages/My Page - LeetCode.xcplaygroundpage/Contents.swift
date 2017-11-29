import Foundation

// 1. Two Sum

var list = [1,2,3,5,8,2,3,4,5]

func sum(a: [Int], sum: Int) -> Bool {
    var index = 0
    for i in a {
        for j in index ..< a.count {
            if i + j == sum {
                return true
            }
        }
        index += 1
    }
    return false
}

sum(a: list, sum: 10)

func sum2(a: [Int], sum: Int) -> Bool {
    var dic : [Int : Int] = [:]
    for i in a {
        dic[i] = sum - i
    }
    
    for i in dic.keys {
        if let withA = dic[i], let _ = a.index(of: withA) {
            return true
        }
    }
    return false
}

sum2(a: list, sum: 10)

func sum3(a: [Int], sum: Int) -> Bool {
    var index = 0
    for i in a {
        let withA = sum - i
        if let withAIndex = a.index(of: withA), withAIndex != index {
            return true
        }
        index += 1
    }
    return false
}

sum3(a: list, sum: 10)

// 657. Judge Route Circle

var isCircle = "UD" //return true
var isNotCircle = "LL" // return false

enum Moves {
    case up
    case down
    case left
    case right
    case none
}

struct Position {
    var x = 0
    var y = 0
}

struct Robot {
    var postion = Position(x: 0, y: 0)
    
    mutating func add(newPosition : Position) {
        self.postion.x += newPosition.x
        self.postion.y += newPosition.y
    }
}

func moves(fromChar : Character) -> Moves {
    let string = String(fromChar).lowercased()
    switch string {
    case "u":
        return .up
    case "d" :
        return .down
    case "l" :
        return .left
    case "r" :
        return .right
    default :
        return .none
    }
}

func position(fromMoves : Moves) -> Position {
    switch fromMoves {
    case .up:
        return Position(x: 0, y: 1)
    case .down:
        return Position(x: 0, y: -1)
    case .left:
        return Position(x: -1, y: 0)
    case .right:
        return Position(x: 1, y: 0)
    default :
        return Position(x: 0, y: 0)
    }
}

func judgeCircle(_ routes : String) -> Bool{
    var robot = Robot()
    let initialPosition = robot.postion
    for m in routes {
        robot.add(newPosition: position(fromMoves: moves(fromChar: m)))
    }
    if initialPosition.x == robot.postion.x && initialPosition.y == robot.postion.y {
        return true
    }
    return false
}

judgeCircle(isCircle)
judgeCircle(isNotCircle)

// 7. Reverse Integer

var reverseEx1 = 123 //should be 321
var reverseEx2 = -123 // shold be -321

func reverse(x : Int) -> Int {
    let isMinus : Bool = (x < 0) ? true : false
    let strX = String(abs(x))
    var reverseStrX : String = ""
    for i in strX.reversed() {
        reverseStrX.append(i)
    }
    let reverseX : Int = Int(reverseStrX) ?? 0
    return (isMinus) ? reverseX * -1 : reverseX
}

func reverse2(x : Int) -> Int {
    var inputX : Int = x
    var reverseX : Int = 0
    
    while inputX != 0 {
        reverseX *= 10
        reverseX += inputX % 10
        inputX /= 10
    }
    
    if reverseX > Int.max || reverseX < Int.min {
        return 0
    }
    
    return reverseX
}

reverse(x: reverseEx1)
reverse(x: reverseEx2)

reverse2(x: reverseEx1)
reverse2(x: reverseEx2)

// 9. Palindrome Number

func isPalindrome(x : Int) -> Bool {
    let reverseX = reverse2(x: x)
    if reverseX == x {
        return true
    }
    return false
}

var palindromeEx1 = 121
var palindromeEx2 = 432

isPalindrome(x: palindromeEx1)
isPalindrome(x: palindromeEx2)

// 14. Longest Common Prefix

let lcpEx1 = ["leet", "leetcode", "leets", "leeds"] //returns "lee"

func longestCommonPrefixByHorizontalScanning(a : [String]) -> String {
    guard a.count != 0 else { return "" }
    var prefix : String = a[0]
    for str in a[1..<a.count] {
        while str.range(of: prefix) == nil {
            prefix.removeLast()
            if prefix.isEmpty { return "" }
        }
    }
    
    return prefix
}

longestCommonPrefixByHorizontalScanning(a: lcpEx1)

func longestCommonPrefixByVerticalScanning(a : [String]) -> String {
    guard a.count != 0 else { return "" }
    let str = a[0]
    for i in 0 ..< str.lengthOfBytes(using: .utf8) {
        let c :Character = str[str.index(str.startIndex, offsetBy: i)]
        for j in 1 ..< a.count {
            let anotherStr = a[j]
            if i == a[j].lengthOfBytes(using: .utf8) || anotherStr[anotherStr.index(anotherStr.startIndex, offsetBy: i)] != c {
                
                return String(str[..<str.index(str.startIndex, offsetBy: i)])
            }
        }
    }
    return a[0]
}

longestCommonPrefixByVerticalScanning(a: lcpEx1)

// 26. Remove Duplicates from Sorted Array

var rmdEx1 = [1, 1, 3, 6, 8, 12]
var rmdEX2 = [2, 5, 5, 5, 14, 25]

func removeDulicates(a : inout [Int]) -> Int{
    var i : Int = 0
    for j in 1..<a.count {
        if a[j] != a[i] {
            i += 1
            a[i] = a[j]
        }
    }
    
    return i+1
}

removeDulicates(a: &rmdEx1)
removeDulicates(a: &rmdEX2)

// 27. Remove Element

var reEx1 = [3,2,2,3]

func removeElement(a : inout [Int], v : Int) -> Int {
    var i : Int = 0
    for j in 0 ..< a.count {
        if a.count < j {
            return a.count
        }
        if a[j] == v {
            a.remove(at: j)
            i += 1
        }
    }
    return a.count - i
}

removeElement(a: &reEx1, v: 3)

// 70. Climbing Stairs

func climbStairs(i: Int) -> Int {
    return climb_stairs(step: 0, i: i)
}

func climb_stairs(step: Int, i: Int) -> Int {
    if step > i {
        return 0
    }
    if step == i {
        return 1
    }
    
    return climb_stairs(step: step+1, i: i) + climb_stairs(step: step+2, i: i)
}

let climbEX1 = 5
climbStairs(i: climbEX1)

func climsStairsFibo(i: Int) -> Int {
    if i == 1 {
        return 1
    }
    
    var first = 1
    var second = 2
    for _ in 3 ..< i+1 {
        let third = first+second
        first = second
        second = third
    }
    
    return second
}

climsStairsFibo(i: climbEX1)

// 83. Remove Duplicates from Sorted Linked List

class ListNode {
    var value : Int?
    var next : ListNode?
}

class LinkedList {
    private var head : ListNode?
    private var tail: ListNode? {
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    func addLink(value: Int) {
        let newNode : ListNode = ListNode()
        newNode.value = value
        if let lastNode = tail {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    func printAllkeys() {
        guard let firstNode = head else { return }
        printNode(firstNode)
    }
    
    fileprivate func printNode(_ node : ListNode) {
        if let value = node.value {
            print("value = \(value)")
        }
        
        if let next = node.next {
            printNode(next)
        }
    }
    
    func deleteDuplicates() {
        guard let firstNode = head else { return }
        deleteDuplicates(firstNode)
    }
    
    fileprivate func deleteDuplicates(_ node : ListNode) {
        if let next = node.next {
            if next.value == node.value {
                if let afterNext = next.next {
                    node.next = afterNext
                    self.deleteDuplicates(afterNext)
                } else {
                    node.next = nil
                }
            } else {
                self.deleteDuplicates(next)
            }
        }
    }
}

var rmDpEx1 = LinkedList() //return [1,2]
rmDpEx1.addLink(value: 1)
rmDpEx1.addLink(value: 1)
rmDpEx1.addLink(value: 3)
rmDpEx1.deleteDuplicates()

var rmDpEx2 = LinkedList() // return [1,2,3]
rmDpEx2.addLink(value: 1)
rmDpEx2.addLink(value: 1)
rmDpEx2.addLink(value: 2)
rmDpEx2.addLink(value: 3)
rmDpEx2.addLink(value: 3)
rmDpEx2.deleteDuplicates()

// 101. Symmetric Tree

class AVLTree<T: Comparable> {
    var key : T!
    var left : AVLTree?
    var right : AVLTree?
    
    lazy var height : Int = {
        var nodeHeight = 0
        nodeHeight = max(getNodeHeight(aNode: self.left), getNodeHeight(aNode: self.right)) + 1
        return nodeHeight
    }()
    
    func addNode(key: T) {
        if self.key == nil {
            self.key = key
            return
        }
        
        guard let selfKey = self.key else { return }
        
        if key < selfKey {
            if self.left != nil {
                left!.addNode(key: key)
            } else {
                let leftChild = AVLTree<T>()
                leftChild.key = key
                self.left = leftChild
            }
        } else if key > selfKey {
            if self.right != nil {
                right!.addNode(key: key)
            } else {
                let rightChild = AVLTree<T>()
                rightChild.key = key
                self.right = rightChild
            }
        }
    }
    
    func getNodeHeight(aNode : AVLTree!) -> Int {
        if aNode == nil {
            return 0
        }
        return height
    }
    
    func isTreeBalanced() -> Bool {
        guard self.key != nil else { return false }
        
        if abs(getNodeHeight(aNode: self.left) - getNodeHeight(aNode: self.right)) <= 1 {
            return true
        } else {
            return false
        }
    }
}

let symmetricTreeEx1 : Array<Int> = [1,2,2,3,4,4,3]
//let symmetricTreeEx2 : Array<Int> = [1,2,2,nil,3,nil,3]
var root = AVLTree<Int>()

for number in symmetricTreeEx1 {
    root.addNode(key: number)
}


