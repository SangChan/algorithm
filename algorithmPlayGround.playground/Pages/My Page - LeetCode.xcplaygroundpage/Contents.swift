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

func judgeCircleByStack(_ routes: String) -> Bool {
    let upDownStack = Stack<Int>()
    let leftRightStack = Stack<Int>()
    for m in routes {
        switch moves(fromChar: m) {
        case .up:
            upDownStack.push(x: 1)
        case .down:
            upDownStack.pop()
        case .left:
            leftRightStack.push(x: 1)
        case .right:
            leftRightStack.pop()
        default:
            upDownStack.push(x: 1)
            upDownStack.pop()
            leftRightStack.push(x: 1)
            leftRightStack.pop()
        }
    }
    if upDownStack.isEmpty() == true && leftRightStack.isEmpty() == true {
        return true
    }
    return false
}

judgeCircleByStack(isCircle)
judgeCircleByStack(isNotCircle)

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
}

extension LinkedList {
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
let symmetricTreeEx2 : Array<Int> = [1,2,2,Int.min,3,Int.min,3]
var root = AVLTree<Int>()

for number in symmetricTreeEx1 {
    root.addNode(key: number)
}

var root2 = AVLTree<Int>()
for number in symmetricTreeEx2 {
    root2.addNode(key: number)
}

//121. Best Time to Buy and Sell Stock

let stocksEx1 : [Int] = [7, 1, 5, 3, 6, 4] // return 5
let stocksEx2 : [Int] = [7, 6, 4, 3, 1] // return 0

func maxProfitBruteForce(_ prices : [Int]) -> Int {
    var maxProfit : Int = 0
    for i in 0 ..< prices.count {
        for j in i+1 ..< prices.count {
            let profit = prices[j] - prices[i]
            if profit > maxProfit {
                maxProfit = profit
            }
        }
    }
    return maxProfit
}

maxProfitBruteForce(stocksEx1)
maxProfitBruteForce(stocksEx2)

func maxProfit(_ prices : [Int]) -> Int {
    var minPrice = Int.max
    var maxProfit = 0
    for i in 0 ..< prices.count {
        if prices[i] < minPrice {
            minPrice = prices[i]
        } else if prices[i] - minPrice > maxProfit {
            maxProfit = prices[i] - minPrice
        }
    }
    return maxProfit
}

maxProfit(stocksEx1)
maxProfit(stocksEx2)

//122. Best Time to Buy and Sell Stock

func maxProfitUsingPeak(_ prices : [Int]) -> Int {
    var i = 0
    var valley = prices[0]
    var peak = prices[0]
    var maxProfit = 0
    
    while i < prices.count - 1 {
        while i < prices.count - 1 && prices[i] >= prices[i+1] {
            i += 1
        }
        valley = prices[i]
        while i < prices.count - 1 && prices[i] <= prices[i+1] {
            i += 1
        }
        peak = prices[i]
        maxProfit += peak - valley
    }
    
    return maxProfit
}

maxProfitUsingPeak(stocksEx1)
maxProfitUsingPeak(stocksEx2)

func maxPrifitOnePass(_ prices : [Int]) -> Int {
    var maxProfit = 0
    for i in 1 ..< prices.count {
        if prices[i] > prices[i-1] {
            maxProfit += prices[i] - prices[i-1]
        }
    }
    return maxProfit
}

maxPrifitOnePass(stocksEx1)
maxPrifitOnePass(stocksEx2)

//136. Single Number

let singleNumberEx1 : [Int] = [1,2,3,4,5,6,2,3,4,5,6] // return 1, must be linear
let singleNumberEx2 : [Int] = [2,6,8,3,9,11,2,6,3,9,11] //return 8, must be linear

func singleNumber(_ nums: [Int]) -> Int {
    let reversedNums : [Int] = nums.reversed()
    for i in 0 ..< nums.count {
        let number = nums[i]
        if let reversedIndex = reversedNums.index(of: number), let index = nums.index(of: number) {
            if reversedIndex + index == nums.count - 1{
                return number
            }
        }
    }
    return 0
}

singleNumber(singleNumberEx1)
singleNumber(singleNumberEx2)

func singleNumberByMath(_ nums: [Int]) -> Int {
    var singlers : [Int] = []
    for i in 0 ..< nums.count {
        let number = nums[i]
        if singlers.index(of: number) == nil {
            singlers.append(number)
        }
    }
    
    var sumOfSinglers : Int = 0
    for i in 0 ..< singlers.count {
        sumOfSinglers += singlers[i]
    }
    
    var sumOfNums : Int = 0
    for i in 0 ..< nums.count {
        sumOfNums += nums[i]
    }
    
    return (sumOfSinglers * 2) - sumOfNums
}

singleNumberByMath(singleNumberEx1)
singleNumberByMath(singleNumberEx2)

//141. Linked List Cycle

extension LinkedList {
    func hasCycle(_ head : ListNode?) -> Bool {
        var nodes : [ListNode] = []
        var newHead : ListNode? = head
        while newHead != nil {
            guard let node = newHead else { return false }
            newHead = newHead?.next
        }
        return false
    }
}

// 160. Intersection of Two Linked Lists

var listOne = LinkedList()
var listTwo = LinkedList()

// 118. Pascal's Triangle

func generatePascalTriangle(_ numRows: Int) -> [[Int]] {
    guard numRows > 0 else { return [[0]] }
    
    var trianleArray = [[Int]]()
    
    trianleArray.append([1])
    
    for i in 1 ..< numRows {
        var rowArray = [Int]()
        rowArray.append(1)
        
        var preRowArray = [Int]()
        preRowArray = trianleArray[i-1]
        
        for j in 1 ..< i {
            let sum = preRowArray[j-1] + preRowArray[j]
            rowArray.append(sum)
        }
        [rowArray .append(1)]
        
        trianleArray.append(rowArray)
    }
    
    return trianleArray
}

generatePascalTriangle(5)

/* of gives 5, it returns
[    [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]]
*/

// 167. Two Sum II - Input array is sorted

func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    return [Int.min]
}

// 169. Majority Element

func majorityElement(_ nums: [Int]) -> Int {
    return Int.min
}

// 189. Rotate Array

func rotate(_ nums: inout [Int], _ k: Int) {
    for _ in 0 ..< k {
        if let temp = nums.popLast() {
            nums.insert(temp, at: 0)
        }
    }
}

var ex1Rotate = [1,2,3,4,5,6,7]
rotate(&ex1Rotate, 3) //return [5,6,7,1,2,3,4]

func rotateWithBruteForce(_ nums: inout [Int], _ k: Int) {
    var temp : Int = 0
    var previous : Int = 0
    for _ in 0 ..< k {
        previous = nums[nums.count - 1]
        for j in 0 ..< nums.count {
            temp = nums[j]
            nums[j] = previous
            previous = temp
        }
    }
}

var ex2Rotate = [1,2,3,4,5,6,7]
rotateWithBruteForce(&ex2Rotate, 3) //return [5,6,7,1,2,3,4]

func rotateWithExtraArray(_ nums: inout [Int], _ k: Int) {
    var a : [Int] = [Int](repeating:0, count: nums.count)
    for i in 0 ..< nums.count {
        a[(i+k)%nums.count] = nums[i]
    }
    for i in 0 ..< nums.count {
        nums[i] = a[i]
    }
}
var ex3Rotate = [1,2,3,4,5,6,7]
rotateWithExtraArray(&ex3Rotate, 3) //return [5,6,7,1,2,3,4]

func rotateWithReverse(_ nums: inout [Int], _ k: Int) {
    let processedK = k % nums.count
    reverseArray(&nums, 0, nums.count - 1)
    reverseArray(&nums, 0, processedK - 1)
    reverseArray(&nums, processedK, nums.count - 1)
}

func reverseArray(_ nums: inout [Int], _ start: Int, _ end: Int) {
    var tempStart = start
    var tempEnd = end
    while tempStart < tempEnd {
        let temp = nums[tempStart]
        nums[tempStart] = nums[tempEnd]
        nums[tempEnd] = temp
        tempStart += 1
        tempEnd -= 1
    }
}

var ex4Rotate = [1,2,3,4,5,6,7]
rotateWithReverse(&ex4Rotate, 3) //return [5,6,7,1,2,3,4]
