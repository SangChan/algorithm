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
    
    public func clear() {
        array.removeAll()
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
        var _ : [ListNode] = []
        var newHead : ListNode? = head
        while newHead != nil {
            guard newHead != nil else { return false }
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

// 191. Number of 1 Bits

func hammingWeight(_ num: UInt32) -> Int {
    let binary = String(num, radix:2)
    var count = 0
    for b in binary {
        if b == "1" {
            count += 1
        }
    }
    return count
}

var exNumberOfOne : UInt32 = 255
hammingWeight(exNumberOfOne)


// 198. House Robber

func rob(_ nums: [Int]) -> Int {
    var prevNo : Int = 0
    var prevYes : Int = 0;
    for num in nums {
        let temp = prevNo
        prevNo = max(prevNo, prevYes)
        prevYes = num + temp
    }
    return max(prevNo, prevYes)
    
}

// 146. LRU Cache

class LRUCache {
    var cache : Array<[Int:Int]> =  Array<[Int:Int]>()
    var capacity : Int = 0
    
    init(capacity : Int) {
        self.capacity = capacity
    }
    
    func get(_ key : Int) -> Int {
        var index = 0
        for i in cache {
            if let value = i[key] {
                cache.remove(at: index)
                cache.append([key:value])
                return value
            }
            index += 1
        }
        return -1
    }

    func put(_ key: Int, value: Int) {
        // TODO : if key is exist, update value.
        if cache.count >= capacity {
            cache.remove(at: 0)
        }
        cache.append([key:value])
    }
}

let cache : LRUCache = LRUCache(capacity: 2)
cache.put(1, value: 1)
cache.put(2, value: 2)
cache.get(1) // returns 1
cache.put(3, value: 3) // evicts key 2
cache.get(2) // returns -1 (not found)
cache.put(4, value: 4) // evicts key 1
cache.get(1) // return -1 (not found)
cache.get(3) // returns 3
cache.get(4) // returns 4

// 217. Contains Duplicate
func containsDuplicate(_ nums: [Int]) -> Bool {
    var dic : [Int : Int] = [Int : Int]()
    for num in nums {
        if let value = dic[num] {
            dic[num] = value+1
        } else {
            dic[num] = 0
        }
    }
    
    for value in dic.values {
        if value > 0 {
            return true
        }
    }
    return false
}

var cdEX1 = [1,2,3,4,4,5]
containsDuplicate(cdEX1)

var cdEX2 = [29,33,456,77,22222,123,5347,0,8,579,4569,-1]
containsDuplicate(cdEX2)

// 225. Implement Stack using Queues
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

class MyStack {
    var queue : Queue<Int> = Queue<Int>()
    
    func push(_ x : Int) {
        queue.enqueue(x: x)
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        // dequeue until it's nil
        let size = queue.size()
        for i in 0 ..< size {
            if let deque = queue.dequeue() {
                if size - 1 == i {
                    return deque
                } else {
                    push(deque)
                }
            }
        }
        return Int.min
    }
    
    /** Get the top element. */
    func top() -> Int {
        // dequeue until it's nil
        let size = queue.size()
        for i in 0 ..< size {
            if let deque = queue.dequeue() {
                if size - 1 == i {
                    return deque
                } else {
                    push(deque)
                }
            }
        }

        return Int.min
    }
    
    /** Returns whether the stack is empty. */
    func empty()  -> Bool {
        if queue.array.count > 0 {
            return false
        }
        return true
    }
}

let myStack = MyStack()
myStack.push(1) // [1]
myStack.push(2) // [2,1]
myStack.pop() // 2
myStack.top() // 1
myStack.empty() // false

// 352. Data Stream as Disjoint Intervals
// TODO : Give up at 15th of Apr, 2018.

struct Interval {
    var start : Int
    var end : Int
    
    func interval() -> String {
        return "Start from \(start), End at \(end)"
    }
}

class SummaryRanges {
    var intervals : Array<Interval>  = Array<Interval>()
    func addNum(_ val : Int) {
        guard intervals.count > 0 else {
            //print("Append : \(val) because there's nothing")
            intervals.append(Interval(start: val, end: val))
            return
        }
        
        var index = 0
        
        //print("Add : \(val)")
        
        for var interval in intervals {
            if val < interval.start {
                //print("\(val) is smaller than Interval #\(index)'s start \(interval.start)")
                if interval.start - 1 == val {
                    interval.start = val
                    //print("start changes : \(interval.interval())")
                    return
                } else {
                    if index > 0 {
                        intervals.insert(Interval(start:val, end: val), at: index - 1)
                        //print("Insert at \(index - 1) for \(Interval(start:val, end: val).interval())")
                        return
                    }
                }
            } else if val > interval.end {
                //print("\(val) is bigger than Interval #\(index)'s end \(interval.end)")
                if interval.end + 1 == val {
                    interval.end = val
                    //print("end changes : \(interval.interval())")
                    return
                } else {
                    if index+1 < intervals.count-1 {
                        var nextInterval = intervals[index+1]
                        if nextInterval.start - 1 == val {
                            nextInterval.start = val
                            //print("next Interval's start changes : \(nextInterval.interval())")
                            return
                        } else if nextInterval.end + 1 == val {
                            nextInterval.end = val
                            //print("next Interval's end changes : \(nextInterval.interval())")
                            return
                        }
                    } else {
                        //intervals.append(Interval(start: val, end: val))
                        //print("Append for \(Interval(start:val, end: val).interval())")
                        //return
                    }
                }
            }
            index += 1
        }
    }
    
    func getIntervals() -> Array<Interval> {
        return intervals
    }
    
    func description() {
//        print("--start--")
//        for interval in getIntervals() {
//            print(interval.interval())
//        }
//        print("---end---")
    }
}

var summary = SummaryRanges()
summary.addNum(1) // [1,1]
summary.description()
summary.addNum(3) // [1,1], [3,3]
summary.description()
summary.addNum(7) // [1,1], [3,3], [7,7]
summary.description()
summary.addNum(2) // [1,3], [7,7]
summary.description()
summary.addNum(6) // [1,3], [6,7]
summary.description()

/*
 278. First Bad Version
 
 You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.
 
 Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.
 
 You are given an API bool isBadVersion(version) which will return whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.
 */

func firstBadVersion(_ n: Int) -> Int {
    var left = 1
    var right = n
    while (left < right) {
        let mid = left + (right - left) / 2;
        if (isBadVersion(mid)) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func isBadVersion(_ n : Int) -> Bool {
    return (Int(arc4random()) % 2 == 0) ? true : false
}

/*
 581. Shortest Unsorted Continuous Subarray
 
 Given an integer array, you need to find one continuous subarray that if you only sort this subarray in ascending order, then the whole array will be sorted in ascending order, too.
 
 You need to find the shortest such subarray and output its length.
 
 Example 1:
 Input: [2, 6, 4, 8, 10, 9, 15]
 Output: 5
 Explanation: You need to sort [6, 4, 8, 10, 9] in ascending order to make the whole array sorted in ascending order.
 Note:
 Then length of the input array is in range [1, 10,000].
 The input array may contain duplicates, so ascending order here means <=.
 */

func findUnsortedSubarray(_ nums: [Int]) -> Int {
    var min : Int = Int.max
    var max : Int = Int.min
    var flag : Bool = false;
    
    for i in 1 ..< nums.count {
        if (nums[i] < nums[i - 1]) {
            flag = true
        }
        if (flag) {
            min = (min > nums[i]) ? nums[i] : min
        }
    }
    
    flag = false
    
    for i in (1 ..< nums.count-2).reversed() {
        if (nums[i] > nums[i + 1]) {
            flag = true
        }
        if (flag) {
            max = (max > nums[i]) ? max : nums[i]
        }
    }
    
    var indexOfL : Int = 0
    for l in 0 ..< nums.count {
        if (min < nums[l]) {
            indexOfL = l
            break
        }
    }
    
    var indexOfR : Int = 0
    for r in (1 ..< nums.count-1).reversed() {
        if (max > nums[r]) {
            indexOfR = r
            break
        }
    }
    return (indexOfR - indexOfL < 0) ? 0 : indexOfR - indexOfL + 1;
}

let answerForFive = [2,6,4,8,10,9,15] // return 5
findUnsortedSubarray(answerForFive)

/*
 226. Invert Binary Tree
 Invert a binary tree.
 
      4
    /   \
   2     7
  / \   / \
 1   3 6   9
 
 to
 
      4
    /   \
   7     2
  / \   / \
 9   6 3   1
 
 */

protocol TreeNode {
    var left : TreeNode? { get set }
    var right : TreeNode? { get set }
}

func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard var newRoot = root else { return nil }
    let right : TreeNode? = invertTree(newRoot.right)
    let left : TreeNode? = invertTree(newRoot.left)
    newRoot.left = right
    newRoot.right = left
    return newRoot;
}

func invertTreeWithQueue(_ root: TreeNode?) -> TreeNode? {
    guard let newRoot = root else { return nil }
    let queue : Queue<TreeNode> = Queue<TreeNode>()
    queue.enqueue(x: newRoot)
    while queue.size() > 0 {
        var current = queue.dequeue()
        let temp = current?.left
        if let copyCurrent = current {
            current?.left = copyCurrent.right
            current?.right = temp
        }
        if let currentLeft = current?.left {
            queue.enqueue(x: currentLeft)
        }
        if let currentRight = current?.right {
            queue.enqueue(x: currentRight)
        }
    }
     return queue.dequeue()
}

/*
 232. Implement Queue using Stacks
 
 Implement the following operations of a queue using stacks.
   - push(x) -- Push element x to the back of queue.
   - pop() -- Removes the element from in front of queue.
   - peek() -- Get the front element.
   - empty() -- Return whether the queue is empty.
 
 Notes:
   - You must use only standard operations of a stack -- which means only push to top, peek/pop from top, size, and is empty operations are valid.
   - Depending on your language, stack may not be supported natively. You may simulate a stack by using a list or deque (double-ended queue), as long as you use only standard operations of a stack.
   - You may assume that all operations are valid (for example, no pop or peek operations will be called on an empty queue).
 
 */

class QueueUsingStack {
    var stack : Stack<Int> = Stack<Int>()

    /** Push element x to the back of queue. */
    func push(_ x : Int) {
        stack.push(x: x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if let pop = stack.pop() {
            return pop
        }
        return Int.min
    }
    
    /** Get the front element. */
    func peek() -> Int {
        if let peek = stack.pop() {
            stack.push(x: peek)
            return peek
        }
        return Int.min
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack.isEmpty()
    }
}

/*
 237. Delete Node in a Linked List
 
 Write a function to delete a node (except the tail) in a singly linked list, given only access to that node.
 
 Supposed the linked list is 1 -> 2 -> 3 -> 4 and you are given the third node with value 3, the linked list should become 1 -> 2 -> 4 after calling your function.
 */

extension LinkedList {
    func deleteNode() {
        guard let node = self.head, let next = node.next else { return }
        node.value = next.value
        node.next = next.next
    }
}

/*
 242. Valid Anagram

 Given two strings s and t , write a function to determine if t is an anagram of s.
 
 Example 1:
 
 Input: s = "anagram", t = "nagaram"
 Output: true
 Example 2:
 
 Input: s = "rat", t = "car"
 Output: false
 Note:
 You may assume the string contains only lowercase alphabets.
 
 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 */

func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    var counter : [Int] = Array(repeating: 0, count: 26)
    let aNumValue : UInt32 = 97
    
    for i in 0 ..< s.count {
        let index = s.index(s.startIndex, offsetBy: i)
        
        let sCharacter = s[index]
        for element in sCharacter.unicodeScalars {
            let sNum = Int(element.value - aNumValue)
            counter[sNum] += 1
        }
        
        let tCharacter = t[index]
        for element in tCharacter.unicodeScalars {
            let tNum = Int(element.value - aNumValue)
            counter[tNum] -= 1
        }
        
    }
    for count in counter {
        if count != 0 {
            return false
        }
    }
    return true
}

isAnagram("anagram", "nagaram")
isAnagram("rat", "car")

/*
 268. Missing Number
 Given an array containing n distinct numbers taken from 0, 1, 2, ..., n, find the one that is missing from the array.
 
 Example 1:
    Input: [3,0,1]
    Output: 2
 
 Example 2:
    Input: [9,6,4,2,3,5,7,0,1]
    Output: 8
 */

func missingNumber(_ nums: [Int]) -> Int {
    let sorted = nums.sorted()
    if (sorted[sorted.count-1] != sorted.count) {
        return sorted.count
    } else if (sorted[0] != 0) {
        return 0
    }

    let startIndex = sorted[0]
    for i in 0 ..< sorted.count {
        if startIndex+i != sorted[i] {
            return startIndex+i
        }
    }
    return startIndex+1
}

missingNumber([3,0,1]) // 2
missingNumber([9,6,4,2,3,5,7,0,1]) // 8
missingNumber([0]) // 1
missingNumber([1]) // 0

/*
 283. Move Zeroes

 Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 
 Example:
 
 Input: [0,1,0,3,12]
 Output: [1,3,12,0,0]
 Note:
 
 You must do this in-place without making a copy of the array.
 Minimize the total number of operations.
 */

func moveZeroes(_ nums: inout [Int]) {
    var lastNonZeroFoundAt = 0
    for cur in 0 ..< nums.count {
        if nums[cur] != 0 {
            lastNonZeroFoundAt += 1
            nums.swapAt(lastNonZeroFoundAt, cur)
        }
    }
}

var testMoveZeroesEx1 = [0,1,0,3,12]
moveZeroes(&testMoveZeroesEx1) //[1,3,12,0,0]
var testMoveZeroesEx2 = [0,0,1]
moveZeroes(&testMoveZeroesEx2) //[1,0,0]

/*
 11. Container With Most Water
 
 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 Note: You may not slant the container and n is at least 2.
 
 The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
 
 Example:
 
 Input: [1,8,6,2,5,4,8,3,7]
 Output: 49
 */

func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    for i in 0 ..< height.count {
        for j in i+1 ..< height.count {
            maxArea = max(maxArea, min(height[i], height[j]) * (j - i))
        }
    }
    return maxArea
}

maxArea([1,8,6,2,5,4,8,3,7]) //49

func maxAreaOpt(_ height: [Int]) -> Int {
    var maxArea = 0
    var l = 0
    var r = height.count-1
    
    while (l < r) {
        maxArea = max(maxArea, min(height[l], height[r]) * (r - l))
        if height[l] < height[r] {
            l += 1
        } else {
            r -= 1
        }
    }
    return maxArea
}

maxAreaOpt([1,8,6,2,5,4,8,3,7]) //49

/*
 890. Find and Replace Pattern
 You have a list of words and a pattern, and you want to know which words in words matches the pattern.
 
 A word matches the pattern if there exists a permutation of letters p so that after replacing every letter x in the pattern with p(x), we get the desired word.
 
 (Recall that a permutation of letters is a bijection from letters to letters: every letter maps to another letter, and no two letters map to the same letter.)
 
 Return a list of the words in words that match the given pattern.
 
 You may return the answer in any order.
 
 Example 1:
 
 Input: words = ["abc","deq","mee","aqq","dkd","ccc"], pattern = "abb"
 Output: ["mee","aqq"]
 Explanation: "mee" matches the pattern because there is a permutation {a -> m, b -> e, ...}.
 "ccc" does not match the pattern because {a -> c, b -> c, ...} is not a permutation,
 since a and b map to the same letter.
 
 
 Note:
 
 1 <= words.length <= 50
 1 <= pattern.length = words[i].length <= 20
 
 */

func findAndReplacePattern(_ words: [String], _ pattern: String) -> [String] {
    return []
}
