//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/*
 2. Add Two Numbers
 
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.
 
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]
 
 Constraints:

 The number of nodes in each linked list is in the range [1, 100].
 0 <= Node.val <= 9
 It is guaranteed that the list represents a number that does not have leading zeros.
 
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let dummy : ListNode? = ListNode()
    var current : ListNode? = dummy
    
    var carry : Int = 0
    var cl1 : ListNode? = l1
    var cl2 : ListNode? = l2
    while (cl1 != nil || cl2 != nil || carry != 0) {
        let val1 = cl1?.val ?? 0
        let val2 = cl2?.val ?? 0
        let sum = carry + val1 + val2
        carry = Int(sum / 10)
        current?.next = ListNode(sum % 10)
        current = current?.next
        cl1 = cl1?.next
        cl2 = cl2?.next
    }
    return dummy?.next
}

/*
 
 12. Integer to Roman
 
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000
 For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given an integer, convert it to a roman numeral.
 
 Example 1:

 Input: num = 3
 Output: "III"
 Explanation: 3 is represented as 3 ones.
 Example 2:

 Input: num = 58
 Output: "LVIII"
 Explanation: L = 50, V = 5, III = 3.
 Example 3:

 Input: num = 1994
 Output: "MCMXCIV"
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
  

 Constraints:

 1 <= num <= 3999
 
 */

let romanTable : [Int: String] = [
    1000 : "M",
    900 : "CM",
    500 : "D",
    400 : "CD",
    100 : "C",
    90 : "XC",
    50 : "L",
    40 : "XL",
    10 : "X",
    9 : "IX",
    5 : "V",
    4 : "IV",
    1 : "I",
]

func intToRoman(_ num: Int) -> String {
    guard num > 0 && num < 4000 else { return "" }
    
    var roman : String = ""
    var inputNum : Int = num
    let keys : [Int] = romanTable.keys.sorted{ $0 > $1 }
    
    while inputNum != 0 {
        for key in keys {
            if inputNum >= key, let value = romanTable[key] {
                inputNum -= key
                roman += value
                break
            }
        }
    }
    
    return roman
}

intToRoman(1)
intToRoman(2)
intToRoman(3)
intToRoman(4)
intToRoman(5)
intToRoman(6)
intToRoman(7)
intToRoman(8)
intToRoman(9)
intToRoman(10)
intToRoman(20)
intToRoman(42)
intToRoman(58)
intToRoman(1994)

/*
 Given a time in -hour AM/PM format, convert it to military (24-hour) time.

 Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
 - 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.

 Example


 Return '12:01:00'.


 Return '00:01:00'.

 Function Description

 Complete the timeConversion function in the editor below. It should return a new string representing the input time in 24 hour format.

 timeConversion has the following parameter(s):

 string s: a time in  hour format
 Returns

 string: the time in  hour format
 Input Format

 A single string  that represents a time in -hour clock format (i.e.:  or ).

 Constraints

 All input times are valid
 Sample Input

 07:05:45PM
 Sample Output

 19:05:45
 */
func timeConversion(s: String) -> String {
    // Write your code here
    let isAM = s.hasSuffix("AM")
    let processedTime = s[...s.index(s.startIndex, offsetBy: 7)]
    let times = processedTime.split(separator: ":")
    let hh : String = {
        var intHH = Int(times[0]) ?? 0
        if isAM == true {
            if intHH == 12 {
                intHH = 0
            }
        }
        else {
            if intHH < 12 {
                intHH += 12
            }
        }
        return String(format: "%02d", intHH)
    }()
    let mm = times[1]
    let ss = times[2]
    return "\(hh):\(mm):\(ss)"
}

timeConversion(s: "07:05:45PM")
timeConversion(s: "12:00:01AM")

/*
 15. 3Sum
 
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.

  

 Example 1:

 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]
 Explanation:
 nums[0] + nums[1] + nums[1] = (-1) + 0 + 1 = 0.
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
 The distinct triplets are [-1,0,1] and [-1,-1,2].
 Notice that the order of the output and the order of the triplets does not matter.
 Example 2:

 Input: nums = [0,1,1]
 Output: []
 Explanation: The only possible triplet does not sum up to 0.
 Example 3:

 Input: nums = [0,0,0]
 Output: [[0,0,0]]
 Explanation: The only possible triplet sums up to 0.
  

 Constraints:

 3 <= nums.length <= 3000
 -105 <= nums[i] <= 105
 
 */
func threeSum(_ nums: [Int]) -> [[Int]] {
    let sortedNums : [Int] = nums.sorted { $0 < $1 }
    var resultSet : Set<[Int]> = []
    for index in 0 ..< sortedNums.count {
        var leftIndex : Int = index + 1
        var rightIndex : Int = sortedNums.count - 1
        while leftIndex < rightIndex {
            if sortedNums[index] + sortedNums[leftIndex] + sortedNums[rightIndex] < 0 {
                leftIndex += 1
            } else if sortedNums[index] + sortedNums[leftIndex] + sortedNums[rightIndex] == 0 {
                resultSet.insert([sortedNums[index], sortedNums[leftIndex], sortedNums[rightIndex]])
                leftIndex += 1
                rightIndex -= 1
            } else {
                rightIndex -= 1
            }
        }
    }
    
    return resultSet.map { nums in
        return nums
    }
}

threeSum([-1,0,1,2,-1,-4])
threeSum([0,1,1])
threeSum([0,0,0])

/*
1. Two Sum

Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

 

Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]
Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]
 

Constraints:

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
Only one valid answer exists.
*/

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict : [Int : Int] = [:]
    
    var i : Int = 0
    for num in nums {
        if let remain = dict[target - num] {
            return [i, remain]
        }
        
        dict[num] = i
        i += 1
    }
    
    return []
}

twoSum([2,7,11,15], 9)
twoSum([3,2,4], 6)
twoSum([3,3], 6)

/*
 
 7. Reverse Integer
 Medium

 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

 Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

  

 Example 1:

 Input: x = 123
 Output: 321
 Example 2:

 Input: x = -123
 Output: -321
 Example 3:

 Input: x = 120
 Output: 21
  
 */

func reverse(_ x: Int) -> Int {
    let strX : String = String(abs(x))
    var newStr : String = ""
    for c in strX.reversed() {
        newStr.append(c)
    }
    let value : Int = (x >= 0) ? Int(newStr)! : Int(newStr)! * -1
    return (value <= Int32.max && value >= Int32.min) ? value : 0
}

reverse(123) // 321
reverse(-123) // -321
reverse(120) // 21

/*
86. Partition List
Medium

Given the head of a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

You should preserve the original relative order of the nodes in each of the two partitions.

 

Example 1:


Input: head = [1,4,3,2,5,2], x = 3
Output: [1,2,2,4,3,5]
Example 2:

Input: head = [2,1], x = 2
Output: [1,2]
 

Constraints:

The number of nodes in the list is in the range [0, 200].
-100 <= Node.val <= 100
-200 <= x <= 200
*/

let numbers = [1,4,3,2,5,2] //[1,2,2,4,3,5]
var headList : ListNode? = ListNode()
for num in numbers {
    headList?.next = ListNode(num, headList?.next)
}

func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    // 링크드 리스트 두개 만들어서 x 보다 작은 것과 x 보다 큰 애들을 따로 모은 다음 리스트 두개 합치기
    let beforeList : ListNode? = ListNode()
    var before : ListNode? = beforeList
    let afterList : ListNode? = ListNode()
    var after : ListNode? = afterList
    var curr : ListNode? = head
    while curr != nil {
        if curr!.val < x {
            before?.next = curr
            before = before?.next
        } else {
            after?.next = curr
            after = after?.next
        }
        curr = curr?.next
    }
    
    after?.next = nil
    before?.next = afterList?.next
    return beforeList?.next
}

let list = partition(headList?.next, 3)

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let merged : [Int] = (nums1 + nums2).sorted()
    let mid : Int = (merged.count) / 2
    return (merged.count % 2 == 1) ? Double(merged[mid]) : (Double(merged[mid-1]) + Double(merged[mid])) / 2.0
}

findMedianSortedArrays([1,3], [2])
findMedianSortedArrays([1,2], [3,4])
//findMedianSortedArrays([], [1])
//findMedianSortedArrays([], [])

/*
 13. Roman to Integer
 
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000
 For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given a roman numeral, convert it to an integer.

  

 Example 1:

 Input: s = "III"
 Output: 3
 Explanation: III = 3.
 Example 2:

 Input: s = "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.
 Example 3:

 Input: s = "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
  

 Constraints:

 1 <= s.length <= 15
 s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
 It is guaranteed that s is a valid roman numeral in the range [1, 3999].
 */

func romanToInt(_ s: String) -> Int {
    let romanTable : [Character : Int] = [
        "I"     :   1,
        "V"     :   5,
        "X"     :   10,
        "L"     :   50,
        "C"     :   100,
        "D"     :   500,
        "M"     :   1000
    ]
    
    var romanInt : Int = 0
    
    var romanStr : String = s
    romanStr = romanStr.replacingOccurrences(of: "IV", with: "IIII")
    romanStr = romanStr.replacingOccurrences(of: "IX", with: "VIIII")
    romanStr = romanStr.replacingOccurrences(of: "XL", with: "XXXX")
    romanStr = romanStr.replacingOccurrences(of: "XC", with: "LXXXX")
    romanStr = romanStr.replacingOccurrences(of: "CD", with: "CCCC")
    romanStr = romanStr.replacingOccurrences(of: "CM", with: "DCCCC")
    
    for char in romanStr {
        if let num = romanTable[char] {
            romanInt += num
        }
    }
    
    return romanInt
}

romanToInt("III")
romanToInt("LVIII")
romanToInt("MCMXCIV")

/*
 
 315. Count of Smaller Numbers After Self
 
 You are given an integer array nums and you have to return a new counts array. The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].

  

 Example 1:

 Input: nums = [5,2,6,1]
 Output: [2,1,1,0]
 Explanation:
 To the right of 5 there are 2 smaller elements (2 and 1).
 To the right of 2 there is only 1 smaller element (1).
 To the right of 6 there is 1 smaller element (1).
 To the right of 1 there is 0 smaller element.
 Example 2:

 Input: nums = [-1]
 Output: [0]
 Example 3:

 Input: nums = [-1,-1]
 Output: [0,0]
  

 Constraints:

 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 */

func countSmaller(_ nums: [Int]) -> [Int] {
    var countList : [Int] = []
    for (index, num) in nums.enumerated() {
        var count : Int = 0
        for j in index + 1 ..< nums.count {
            if num > nums[j] {
                count += 1
            }
        }
        countList.append(count)
    }
    return countList
}

countSmaller([5,2,6,1])
countSmaller([-1])
countSmaller([-1,-1])

/*
 29. Divide Two Integers
 Medium
 
 Given two integers dividend and divisor, divide two integers without using multiplication, division, and mod operator.

 The integer division should truncate toward zero, which means losing its fractional part. For example, 8.345 would be truncated to 8, and -2.7335 would be truncated to -2.

 Return the quotient after dividing dividend by divisor.

 Note: Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: [−231, 231 − 1]. For this problem, if the quotient is strictly greater than 231 - 1, then return 231 - 1, and if the quotient is strictly less than -231, then return -231.

  

 Example 1:

 Input: dividend = 10, divisor = 3
 Output: 3
 Explanation: 10/3 = 3.33333.. which is truncated to 3.
 Example 2:

 Input: dividend = 7, divisor = -3
 Output: -2
 Explanation: 7/-3 = -2.33333.. which is truncated to -2.
  

 Constraints:

 -231 <= dividend, divisor <= 231 - 1
 divisor != 0
 */

func divide(_ dividend: Int, _ divisor: Int) -> Int {
    let numNegative : Int = (dividend < 0) ? -1 : 1
    let divNegative : Int = (divisor < 0) ? -1 : 1
    var num : Int = abs(dividend)
    let div : Int = abs(divisor)
    
    if div == 1 {
        let justNum : Int = num * numNegative * divNegative
        
        if justNum > Int32.max { return Int(Int32.max) }
        if justNum < Int32.min { return Int(Int32.min) }
        return justNum
    }
    
    var count : Int = 0
    while num > 0 {
        num -= div
        if num >= 0 { count += 1}
    }
    let answer : Int = count * numNegative * divNegative
    
    if answer > Int32.max { return Int(Int32.max) }
    if answer < Int32.min { return Int(Int32.min) }
    return answer
}

divide(10, 3)

/*
 36. Valid Sudoku
 Medium

 Share
 Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
 Note:

 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 
 Input: board =
 [["5","3",".",".","7",".",".",".","."]
 ,["6",".",".","1","9","5",".",".","."]
 ,[".","9","8",".",".",".",".","6","."]
 ,["8",".",".",".","6",".",".",".","3"]
 ,["4",".",".","8",".","3",".",".","1"]
 ,["7",".",".",".","2",".",".",".","6"]
 ,[".","6",".",".",".",".","2","8","."]
 ,[".",".",".","4","1","9",".",".","5"]
 ,[".",".",".",".","8",".",".","7","9"]]
 Output: true
 
 Input: board =
 [["8","3",".",".","7",".",".",".","."]
 ,["6",".",".","1","9","5",".",".","."]
 ,[".","9","8",".",".",".",".","6","."]
 ,["8",".",".",".","6",".",".",".","3"]
 ,["4",".",".","8",".","3",".",".","1"]
 ,["7",".",".",".","2",".",".",".","6"]
 ,[".","6",".",".",".",".","2","8","."]
 ,[".",".",".","4","1","9",".",".","5"]
 ,[".",".",".",".","8",".",".","7","9"]]
 Output: false
 Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
 */

func isValidSudoku(_ board: [[Character]]) -> Bool {
    var nums : [Character] = []
    // 1x9 체크
    for i in 0 ..< board.count {
        nums = []
        let line : [Character] = board[i]
        for j in 0 ..< line.count {
            let char : Character = line[j]
            if char != "." {
                if nums.firstIndex(of: char) != nil {
                    return false
                }
                nums.append(char)
            }
        }
    }
    
    // 9x1 체크
    
    var newBoard : [[Character]] = .init(repeating: .init(repeating: .init("."), count: board.count), count: board.count)
    for i in 0 ..< board.count {
        let line : [Character] = board[i]
        for j in 0 ..< line.count {
            newBoard[j][i] = board[i][j]
        }
    }
    
    for i in 0 ..< newBoard.count {
        nums = []
        let line : [Character] = newBoard[i]
        for j in 0 ..< line.count {
            let char : Character = line[j]
            if char != "." {
                if nums.firstIndex(of: char) != nil {
                    return false
                }
                nums.append(char)
            }
        }
    }
    
    // 3x3 체크
    
    for i in 0 ..< board.count / 3 {
        for j in 0 ..< board.count / 3 {
            nums = []
            for k in 0 ..< 3 {
                for l in 0 ..< 3 {
                    let char = board[(i*3)+k][(j*3)+l]
                    if char != "." {
                        if nums.firstIndex(of: char) != nil {
                            return false
                        }
                        nums.append(char)
                    }
                }
            }
        }
    }
    
    return true
}

let rightBoard : [[Character]] = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]
isValidSudoku(rightBoard)

let wrongBoard : [[Character]] = [
    ["8","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]
isValidSudoku(wrongBoard)

/*
 240. Search a 2D Matrix II
 Medium

 Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:

 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
  

 Example 1:


 Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
 Output: true
 Example 2:


 Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
 Output: false
  

 Constraints:

 m == matrix.length
 n == matrix[i].length
 1 <= n, m <= 300
 -109 <= matrix[i][j] <= 109
 All the integers in each row are sorted in ascending order.
 All the integers in each column are sorted in ascending order.
 -109 <= target <= 109
 
 */
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    for nums in matrix {
        if nums.firstIndex(of: target) != nil {
            return true
        }
    }
    
    return false
}


let matrix = [
    [1,4,7,11,15],
    [2,5,8,12,19],
    [3,6,9,16,22],
    [10,13,14,17,24],
    [18,21,23,26,30]
]
searchMatrix(matrix, 5)
searchMatrix(matrix, 20)

/*
 46. Permutations
 Medium

 Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

  

 Example 1:

 Input: nums = [1,2,3]
 Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 Example 2:

 Input: nums = [0,1]
 Output: [[0,1],[1,0]]
 Example 3:

 Input: nums = [1]
 Output: [[1]]
  

 Constraints:

 1 <= nums.length <= 6
 -10 <= nums[i] <= 10
 All the integers of nums are unique.
 */

func permute(_ nums: [Int]) -> [[Int]] {
    guard nums.count != 0 else { return [] }
    
    // [1]
    var answer : [[Int]] = []
    let firstList : [Int] = [nums[0]]
    answer.append(firstList)
    
    // [1] -> [1,2], [2,1]
    // [1,2], [2,1] -> [3,1,2], [1,3,2], [1,2,3], [3,2,1], [2,3,1], [2,1,3]
    for i in 1 ..< nums.count {
        var newAnswer : [[Int]] = []
        for j in 0 ... i {
            for list in answer {
                var newList = list
                newList.insert(nums[i], at: j)
                newAnswer.append(newList)
            }
        }
        answer = newAnswer
    }
    
    return answer
}
permute([1,2,3])

var testArr : [Int] = [1,3,5,67,99,2,3,5,1]
let new = testArr.compactMap { ($0 > 10) ? $0 : $0 * 10 }
print(new)

func sum(_ max : Int) -> Int {
    // brute force
    var sum : Int = 0
    for i in 1 ... 10 {
        sum += i
    }
    return sum
    // swift api
    return (1 ... 10).reduce(0) { $0 + $1 }
    // 11+11+11+11+11 -> n*(n+1)/2
    return max * (max + 1) / 2
}
sum(10)
/*
47. Permutations II
Medium

Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.

 

Example 1:

Input: nums = [1,1,2]
Output:
[[1,1,2],
 [1,2,1],
 [2,1,1]]
Example 2:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 

Constraints:

1 <= nums.length <= 8
-10 <= nums[i] <= 10
 */

func permuteUnique(_ nums: [Int]) -> [[Int]] {
    guard nums.count != 0 else { return [] }
    // input [1,1,2]
    // [1]
    var answer : [[Int]] = []
    let firstList : [Int] = [nums[0]]
    answer.append(firstList)
    
    // [1] -> [1,1], [1,2]
    // [1,1], [1,2] -> [2,1,1], [1,2,1], [1,1,2], [1,1,2], [1,1,2], [1,2,1] -> [2,1,1], [1,2,1], [1,1,2]
    for i in 1 ..< nums.count {
        var newAnswer : Set<[Int]> = .init()
        for j in 0 ... i {
            for list in answer {
                var newList = list
                newList.insert(nums[i], at: j)
                newAnswer.insert(newList)
            }
        }
        answer = newAnswer.compactMap { $0 }
    }
    
    return answer
}
permuteUnique([1,1,2])

func lonelyinteger(a: [Int]) -> Int {
    // Write your code here
    var dict : [Int : Int] = [:]
    for i in a {
        if let value = dict[i] {
            dict[i] = value + 1
        } else {
            dict[i] = 1
        }
    }
    var answer : Int = 0
    for key in dict.keys {
        if let value = dict[key], value == 1 {
            answer = key
        }
    }
    return answer
}

lonelyinteger(a: [1,1])

var squareMatrix : [[Int]] = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]

for i in 0 ..< squareMatrix.count {
    for j in 0 ..< squareMatrix[i].count {
        print("[i = \(i), j =\(j)] \(squareMatrix[i][j])")
    }
}

func diagonalDifference(arr: [[Int]]) -> Int {
    // Write your code here
    let size : Int = arr.count
    var leftDiagnal : Int = 0
    var rightDiagnal : Int = 0
    for i in 0 ..< size {
        leftDiagnal += arr[i][i]
        rightDiagnal += arr[size-i-1][i]
    }
    return abs(leftDiagnal-rightDiagnal)
}

func flipMatrix(matrix: [[Int]]) -> Int {
    var sum : Int = 0
    let n : Int = matrix.count / 2

    for r in 0 ..< n {
        for c in 0 ..< n {
            let p1 = matrix[r][matrix.count - c - 1]
            let p2 = matrix[r][c]
            let p3 = matrix[matrix.count - r - 1][c]
            let p4 = matrix[matrix.count - r - 1][matrix.count - c - 1]
            print("\(p1),\(p2),\(p3),\(p4)")
            sum += max(p1, p2, p3, p4)
        }
    }
    
    return sum
}

flipMatrix(matrix: [
    [112,42,83,119],
    [56,125,56,49],
    [15,78,101,43],
    [62,98,114,108]
])

class TreeNode {
    var val : Int
    var left : TreeNode?
    var right : TreeNode?
    
    init(_ val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// root -> left -> right

func preorder(current : TreeNode?) {
    guard let current = current else { return }
    preorder(current: current.left)
    preorder(current: current.right)
}

func findPreorder(current : TreeNode?, p : TreeNode?, q : TreeNode?) -> TreeNode? {
    guard let current = current else { return nil }
    
    if current.val == p?.val { return current }
    if current.val == q?.val { return current }
    
    let left = findPreorder(current: current.left, p: p, q: q)
    let right = findPreorder(current: current.right, p: p, q: q)
    
    if left != nil && right != nil {
        return current
    } else if left == nil && right != nil {
        return right
    } else if left != nil && right == nil {
        return left
    } else {
        return nil
    }
}

/*
 69. Sqrt(x)
 
 Given a non-negative integer x, compute and return the square root of x.

 Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

 Note: You are not allowed to use any built-in exponent function or operator, such as pow(x, 0.5) or x ** 0.5.

  

 Example 1:

 Input: x = 4
 Output: 2
 Example 2:

 Input: x = 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.
  

 Constraints:

 0 <= x <= 231 - 1
 */

func mySqrt(_ x: Int) -> Int {
    guard x > 0 else { return 0 }
    if x == 1 { return 1 }
    var smaller : Bool = false
    var bigger : Bool = false
    var result : Int = 0
    for i in 1 ... x/2 {
        if (i*i) < x { smaller = true }
        else if (i*i) == x { return i }
        else if (i*i) > x { bigger = true }
        
        if smaller == true && bigger == true { return i - 1 }
        result = i
    }
    return result
}

mySqrt(1)
mySqrt(2)
mySqrt(4)
mySqrt(8)

/*
 355. Design Twitter
 Medium

 Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the 10 most recent tweets in the user's news feed.

 Implement the Twitter class:

 - *Twitter()* Initializes your twitter object.
 - *void postTweet(int userId, int tweetId)* Composes a new tweet with ID tweetId by the user userId. Each call to this function will be made with a unique tweetId.
 - *List<Integer> getNewsFeed(int userId)* Retrieves the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
 - *void follow(int followerId, int followeeId)* The user with ID followerId started following the user with ID followeeId.
 - *void unfollow(int followerId, int followeeId)* The user with ID followerId started unfollowing the user with ID followeeId.
  

 Example 1:

 Input
 ["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
 [[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
 Output
 [null, null, [5], null, null, [6, 5], null, [5]]

 Explanation
 Twitter twitter = new Twitter();
 twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
 twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
 twitter.follow(1, 2);    // User 1 follows user 2.
 twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
 twitter.getNewsFeed(1);  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
 twitter.unfollow(1, 2);  // User 1 unfollows user 2.
 twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.
  

 Constraints:

 1 <= userId, followerId, followeeId <= 500
 0 <= tweetId <= 104
 All the tweets have unique IDs.
 At most 3 * 104 calls will be made to postTweet, getNewsFeed, follow, and unfollow.
 */
class Twitter {
    private var _tweets : [Int:Set<Int>]
    private var _followers : [Int: Set<Int>]
    private var _news : [Int]
    
    init() {
        _tweets = [:]
        _followers = [:]
        _news = []
    }
    
    func postTweet(_ userId: Int, _ tweetId: Int) {
        if var tweet = _tweets[userId] {
            tweet.insert(tweetId)
            _tweets[userId] = tweet
        } else {
            _tweets[userId] = [tweetId]
        }
        _news.append(tweetId)
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        var newsfeed : [Int] = []
        _news.reversed().forEach { tweetId in
            if newsfeed.count >= 10 { return }
            if let _ = _tweets[userId]?.firstIndex(of: tweetId) {
                newsfeed.append(tweetId)
            } else if let follwers = _followers[userId] {
                follwers.map { follower in
                    if let _ = _tweets[follower]?.firstIndex(of: tweetId) {
                        newsfeed.append(tweetId)
                    }
                }
            }
            
        }
        
        return newsfeed
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        if var follower = _followers[followerId] {
            follower.insert(followeeId)
            _followers[followerId] = follower
        } else {
            _followers[followerId] = [followeeId]
        }
    }
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        if var follower = _followers[followerId] {
            if let index = follower.firstIndex(of: followeeId) {
                follower.remove(at: index)
                _followers[followerId] = follower
            }
        }
    }
}

var twitter : Twitter = .init()
twitter.postTweet(1, 5) // User 1 posts a new tweet (id = 5).
twitter.getNewsFeed(1)  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
twitter.follow(1, 2)    // User 1 follows user 2.
twitter.postTweet(2, 6) // User 2 posts a new tweet (id = 6).
twitter.getNewsFeed(1)  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
twitter.unfollow(1, 2)  // User 1 unfollows user 2.
twitter.getNewsFeed(1)  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.

/*
 705. Design HashSet
 Easy
 
 Design a HashSet without using any built-in hash table libraries.

 Implement MyHashSet class:

 void add(key) Inserts the value key into the HashSet.
 bool contains(key) Returns whether the value key exists in the HashSet or not.
 void remove(key) Removes the value key in the HashSet. If key does not exist in the HashSet, do nothing.
  

 Example 1:

 Input
 ["MyHashSet", "add", "add", "contains", "contains", "add", "contains", "remove", "contains"]
 [[], [1], [2], [1], [3], [2], [2], [2], [2]]
 Output
 [null, null, null, true, false, null, true, null, false]

 Explanation
 MyHashSet myHashSet = new MyHashSet();
 myHashSet.add(1);      // set = [1]
 myHashSet.add(2);      // set = [1, 2]
 myHashSet.contains(1); // return True
 myHashSet.contains(3); // return False, (not found)
 myHashSet.add(2);      // set = [1, 2]
 myHashSet.contains(2); // return True
 myHashSet.remove(2);   // set = [1]
 myHashSet.contains(2); // return False, (already removed)
  

 Constraints:

 0 <= key <= 106
 At most 104 calls will be made to add, remove, and contains.
 Accepted
 243,953
 Submissions
 369,272
 */
class MyHashSet {
    var hash: [Int]
    
    init() {
        hash = []
    }
    
    func add(_ key: Int) {
        if hash.firstIndex(of: key) != nil { return }
        hash.append(key)
    }
    
    func remove(_ key: Int) {
        if let index = hash.firstIndex(of: key) {
            hash.remove(at: index)
        }
    }
    
    func contains(_ key: Int) -> Bool {
        return hash.firstIndex(of: key) != nil
    }
}

/*
 1396. Design Underground System
 Medium

 An underground railway system is keeping track of customer travel times between different stations. They are using this data to calculate the average time it takes to travel from one station to another.

 Implement the UndergroundSystem class:

 void checkIn(int id, string stationName, int t)
 A customer with a card ID equal to id, checks in at the station stationName at time t.
 A customer can only be checked into one place at a time.
 void checkOut(int id, string stationName, int t)
 A customer with a card ID equal to id, checks out from the station stationName at time t.
 double getAverageTime(string startStation, string endStation)
 Returns the average time it takes to travel from startStation to endStation.
 The average time is computed from all the previous traveling times from startStation to endStation that happened directly, meaning a check in at startStation followed by a check out from endStation.
 The time it takes to travel from startStation to endStation may be different from the time it takes to travel from endStation to startStation.
 There will be at least one customer that has traveled from startStation to endStation before getAverageTime is called.
 You may assume all calls to the checkIn and checkOut methods are consistent. If a customer checks in at time t1 then checks out at time t2, then t1 < t2. All events happen in chronological order.

  

 Example 1:

 Input
 ["UndergroundSystem","checkIn","checkIn","checkIn","checkOut","checkOut","checkOut","getAverageTime","getAverageTime","checkIn","getAverageTime","checkOut","getAverageTime"]
 [[],[45,"Leyton",3],[32,"Paradise",8],[27,"Leyton",10],[45,"Waterloo",15],[27,"Waterloo",20],[32,"Cambridge",22],["Paradise","Cambridge"],["Leyton","Waterloo"],[10,"Leyton",24],["Leyton","Waterloo"],[10,"Waterloo",38],["Leyton","Waterloo"]]

 Output
 [null,null,null,null,null,null,null,14.00000,11.00000,null,11.00000,null,12.00000]

 Explanation
 UndergroundSystem undergroundSystem = new UndergroundSystem();
 undergroundSystem.checkIn(45, "Leyton", 3);
 undergroundSystem.checkIn(32, "Paradise", 8);
 undergroundSystem.checkIn(27, "Leyton", 10);
 undergroundSystem.checkOut(45, "Waterloo", 15);  // Customer 45 "Leyton" -> "Waterloo" in 15-3 = 12
 undergroundSystem.checkOut(27, "Waterloo", 20);  // Customer 27 "Leyton" -> "Waterloo" in 20-10 = 10
 undergroundSystem.checkOut(32, "Cambridge", 22); // Customer 32 "Paradise" -> "Cambridge" in 22-8 = 14
 undergroundSystem.getAverageTime("Paradise", "Cambridge"); // return 14.00000. One trip "Paradise" -> "Cambridge", (14) / 1 = 14
 undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000. Two trips "Leyton" -> "Waterloo", (10 + 12) / 2 = 11
 undergroundSystem.checkIn(10, "Leyton", 24);
 undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000
 undergroundSystem.checkOut(10, "Waterloo", 38);  // Customer 10 "Leyton" -> "Waterloo" in 38-24 = 14
 undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 12.00000. Three trips "Leyton" -> "Waterloo", (10 + 12 + 14) / 3 = 12
 Example 2:

 Input
 ["UndergroundSystem","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime","checkIn","checkOut","getAverageTime"]
 [[],[10,"Leyton",3],[10,"Paradise",8],["Leyton","Paradise"],[5,"Leyton",10],[5,"Paradise",16],["Leyton","Paradise"],[2,"Leyton",21],[2,"Paradise",30],["Leyton","Paradise"]]

 Output
 [null,null,null,5.00000,null,null,5.50000,null,null,6.66667]

 Explanation
 UndergroundSystem undergroundSystem = new UndergroundSystem();
 undergroundSystem.checkIn(10, "Leyton", 3);
 undergroundSystem.checkOut(10, "Paradise", 8); // Customer 10 "Leyton" -> "Paradise" in 8-3 = 5
 undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.00000, (5) / 1 = 5
 undergroundSystem.checkIn(5, "Leyton", 10);
 undergroundSystem.checkOut(5, "Paradise", 16); // Customer 5 "Leyton" -> "Paradise" in 16-10 = 6
 undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 5.50000, (5 + 6) / 2 = 5.5
 undergroundSystem.checkIn(2, "Leyton", 21);
 undergroundSystem.checkOut(2, "Paradise", 30); // Customer 2 "Leyton" -> "Paradise" in 30-21 = 9
 undergroundSystem.getAverageTime("Leyton", "Paradise"); // return 6.66667, (5 + 6 + 9) / 3 = 6.66667
  

 Constraints:

 1 <= id, t <= 106
 1 <= stationName.length, startStation.length, endStation.length <= 10
 All strings consist of uppercase and lowercase English letters and digits.
 There will be at most 2 * 104 calls in total to checkIn, checkOut, and getAverageTime.
 Answers within 10-5 of the actual value will be accepted.
 Accepted
 140,395
 Submissions
 190,809
 */


class UndergroundSystem {
    
    enum CheckType {
        case checkIn
        case checkOut
    }
    struct UserActivity {
        let id : Int
        let stationName : String
        let time : Int
        let checkType : CheckType
    }
    struct AverageTime {
        let startStation : String
        let endStation : String
        let time : Int
    }
    
    private var _userActivities : [UserActivity]
    private var _averageTimes : [AverageTime]

    init() {
        _userActivities = []
        _averageTimes = []
    }
    
    func checkIn(_ id: Int, _ stationName: String, _ t: Int) {
        _userActivities.append(.init(id: id, stationName: stationName, time: t, checkType : .checkIn))
    }
    
    func checkOut(_ id: Int, _ stationName: String, _ t: Int) {
        let activities = _userActivities.filter { activity in
            activity.id == id && activity.checkType == .checkIn
        }
        guard let checkIn = activities.last else { return }
        _userActivities.append(.init(id: id, stationName: stationName, time: t, checkType : .checkOut))
        _averageTimes.append(.init(startStation: checkIn.stationName, endStation: stationName, time: t - checkIn.time))
    }
    
    func getAverageTime(_ startStation: String, _ endStation: String) -> Double {
        let averageTimes = _averageTimes.filter { time in
            time.startStation == startStation && time.endStation == endStation
        }
        
        let sum :Int = averageTimes.reduce(0) { $0 + $1.time }
        
        return Double(sum) / Double(averageTimes.count)
    }
}

class UndergroundSystemV2 {
    
    enum CheckType {
        case checkIn
        case checkOut
    }
    struct StationCheckTime {
        let stationName : String
        let time : Int
        let checkType : CheckType
    }
    struct RouteInfo : Hashable {
        let startStation : String
        let endStation : String
    }
    
    private var _userData : [Int: [StationCheckTime]]
    private var _timeData : [RouteInfo: [Int]]

    init() {
        _userData = [:]
        _timeData = [:]
    }
    
    func checkIn(_ id: Int, _ stationName: String, _ t: Int) {
        if var userData = _userData[id] {
            userData.append(.init(stationName: stationName, time: t, checkType: .checkIn))
            _userData[id] = userData
        } else {
            _userData[id] = [
                StationCheckTime(stationName: stationName, time: t, checkType: .checkIn),
            ]
        }
    }
    
    func checkOut(_ id: Int, _ stationName: String, _ t: Int) {
        guard
            var userData = _userData[id],
            let checkIn = userData.last,
            checkIn.checkType == .checkIn
        else { return }
        userData.append(.init(stationName: stationName, time: t, checkType: .checkOut))
        _userData[id] = userData
        let route : RouteInfo = .init(startStation: checkIn.stationName, endStation: stationName)
        let time : Int = t - checkIn.time
        if var timeData = _timeData[route] {
            timeData.append(time)
            _timeData[route] = timeData
        } else {
            _timeData[route] = [
                time,
            ]
        }
    }
    
    func getAverageTime(_ startStation: String, _ endStation: String) -> Double {
        guard let timeData = _timeData[.init(startStation: startStation, endStation: endStation)] else { return 0.0 }
        let sum : Int = timeData.reduce(0) { $0 + $1 }
        return Double(sum) / Double(timeData.count)
    }
}


var undergroundSystem : UndergroundSystemV2 = .init()
undergroundSystem.checkIn(45, "Leyton", 3);
undergroundSystem.checkIn(32, "Paradise", 8);
undergroundSystem.checkIn(27, "Leyton", 10);
undergroundSystem.checkOut(45, "Waterloo", 15);  // Customer 45 "Leyton" -> "Waterloo" in 15-3 = 12
undergroundSystem.checkOut(27, "Waterloo", 20);  // Customer 27 "Leyton" -> "Waterloo" in 20-10 = 10
undergroundSystem.checkOut(32, "Cambridge", 22); // Customer 32 "Paradise" -> "Cambridge" in 22-8 = 14
undergroundSystem.getAverageTime("Paradise", "Cambridge"); // return 14.00000. One trip "Paradise" -> "Cambridge", (14) / 1 = 14
undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000. Two trips "Leyton" -> "Waterloo", (10 + 12) / 2 = 11
undergroundSystem.checkIn(10, "Leyton", 24);
undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 11.00000
undergroundSystem.checkOut(10, "Waterloo", 38);  // Customer 10 "Leyton" -> "Waterloo" in 38-24 = 14
undergroundSystem.getAverageTime("Leyton", "Waterloo");    // return 12.00000. Three trips "Leyton" -> "Waterloo", (10 + 12 + 14) / 3 = 12

var undergroundSystem2 : UndergroundSystemV2 = .init()
undergroundSystem2.checkIn(10, "Leyton", 3);
undergroundSystem2.checkOut(10, "Paradise", 8); // Customer 10 "Leyton" -> "Paradise" in 8-3 = 5
undergroundSystem2.getAverageTime("Leyton", "Paradise"); // return 5.00000, (5) / 1 = 5
undergroundSystem2.checkIn(5, "Leyton", 10);
undergroundSystem2.checkOut(5, "Paradise", 16); // Customer 5 "Leyton" -> "Paradise" in 16-10 = 6
undergroundSystem2.getAverageTime("Leyton", "Paradise"); // return 5.50000, (5 + 6) / 2 = 5.5
undergroundSystem2.checkIn(2, "Leyton", 21);
undergroundSystem2.checkOut(2, "Paradise", 30); // Customer 2 "Leyton" -> "Paradise" in 30-21 = 9
undergroundSystem2.getAverageTime("Leyton", "Paradise"); // return 6.66667, (5 + 6 + 9) / 3 = 6.66667

/*
 1472. Design Browser History
 Medium

 You have a browser of one tab where you start on the homepage and you can visit another url, get back in the history number of steps or move forward in the history number of steps.

 Implement the BrowserHistory class:

 BrowserHistory(string homepage) Initializes the object with the homepage of the browser.
 void visit(string url) Visits url from the current page. It clears up all the forward history.
 string back(int steps) Move steps back in history. If you can only return x steps in the history and steps > x, you will return only x steps. Return the current url after moving back in history at most steps.
 string forward(int steps) Move steps forward in history. If you can only forward x steps in the history and steps > x, you will forward only x steps. Return the current url after forwarding in history at most steps.
  

 Example:

 Input:
 ["BrowserHistory","visit","visit","visit","back","back","forward","visit","forward","back","back"]
 [["leetcode.com"],["google.com"],["facebook.com"],["youtube.com"],[1],[1],[1],["linkedin.com"],[2],[2],[7]]
 Output:
 [null,null,null,null,"facebook.com","google.com","facebook.com",null,"linkedin.com","google.com","leetcode.com"]

 Explanation:
 BrowserHistory browserHistory = new BrowserHistory("leetcode.com");
 browserHistory.visit("google.com");       // You are in "leetcode.com". Visit "google.com"
 browserHistory.visit("facebook.com");     // You are in "google.com". Visit "facebook.com"
 browserHistory.visit("youtube.com");      // You are in "facebook.com". Visit "youtube.com"
 browserHistory.back(1);                   // You are in "youtube.com", move back to "facebook.com" return "facebook.com"
 browserHistory.back(1);                   // You are in "facebook.com", move back to "google.com" return "google.com"
 browserHistory.forward(1);                // You are in "google.com", move forward to "facebook.com" return "facebook.com"
 browserHistory.visit("linkedin.com");     // You are in "facebook.com". Visit "linkedin.com"
 browserHistory.forward(2);                // You are in "linkedin.com", you cannot move forward any steps.
 browserHistory.back(2);                   // You are in "linkedin.com", move back two steps to "facebook.com" then to "google.com". return "google.com"
 browserHistory.back(7);                   // You are in "google.com", you can move back only one step to "leetcode.com". return "leetcode.com"
  

 Constraints:

 1 <= homepage.length <= 20
 1 <= url.length <= 20
 1 <= steps <= 100
 homepage and url consist of  '.' or lower case English letters.
 At most 5000 calls will be made to visit, back, and forward.
 */

class BrowserHistory {
    private var _history: [String] = []
    private var _index : Int = 0

    init(_ homepage: String) {
        _history.append(homepage)
        _index = 0
    }
    
    func visit(_ url: String) {
        _index += 1
        if _history.count >= _index + 1 {
            _history.removeLast(_history.count - _index)
        }
        _history.append(url)
    }
    
    func back(_ steps: Int) -> String {
        _index = max(0, _index - steps)
        return _history[_index]
    }
    
    func forward(_ steps: Int) -> String {
        _index = min(_index + steps, _history.count - 1)
        return _history[_index]
    }
}

var browserHistory = BrowserHistory("leetcode.com");
browserHistory.visit("google.com");       // You are in "leetcode.com". Visit "google.com"
browserHistory.visit("facebook.com");     // You are in "google.com". Visit "facebook.com"
browserHistory.visit("youtube.com");      // You are in "facebook.com". Visit "youtube.com"
browserHistory.back(1);                   // You are in "youtube.com", move back to "facebook.com" return "facebook.com"
browserHistory.back(1);                   // You are in "facebook.com", move back to "google.com" return "google.com"
browserHistory.forward(1);                // You are in "google.com", move forward to "facebook.com" return "facebook.com"
browserHistory.visit("linkedin.com");     // You are in "facebook.com". Visit "linkedin.com"
browserHistory.forward(2);                // You are in "linkedin.com", you cannot move forward any steps.
browserHistory.back(2);                   // You are in "linkedin.com", move back two steps to "facebook.com" then to "google.com". return "google.com"
browserHistory.back(7);                   // You are in "google.com", you can move back only one step to "leetcode.com". return "leetcode.com"

/*
 79. Word Search
 Medium

 Given an m x n grid of characters board and a string word, return true if word exists in the grid.

 The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

  

 Example 1:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
 Output: true
 Example 2:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
 Output: true
 Example 3:


 Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
 Output: false
  

 Constraints:

 m == board.length
 n = board[i].length
 1 <= m, n <= 6
 1 <= word.length <= 15
 board and word consists of only lowercase and uppercase English letters.
  

 Follow up: Could you use search pruning to make your solution faster with a larger board?
 */
func exist(_ board: [[Character]], _ word: String) -> Bool {
    let m : Int = board.count
    let n : Int = board[0].count
    let array = Array(word)
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    
    for i in 0 ..< m {
        for j in 0 ..< n {
            if board[i][j] == array[0] {
                if dfs(m, n, i, j, &visited, 0, array, board) {
                    return true
                }
            }
        }
    }
    return false
}

func dfs(_ m: Int, _ n: Int, _ x: Int, _ y: Int, _ visited: inout [[Bool]], _ index: Int, _ array: [Character], _ board: [[Character]]) -> Bool {
    guard x < m, y < n, x >= 0, y >= 0 else { return false }
    
    if visited[x][y] {
        return false
    }
    
    if board[x][y] != array[index] {
        return false
    }
    
    if index == array.count - 1 {
        return true
    }
    
    visited[x][y] = true
    if dfs(m, n, x + 1, y, &visited, index + 1, array, board)
    || dfs(m, n, x - 1, y, &visited, index + 1, array, board)
    || dfs(m, n, x, y + 1, &visited, index + 1, array, board)
    || dfs(m, n, x, y - 1, &visited, index + 1, array, board) {
        return true
    }
    visited[x][y] = false
    return false
}

exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED")
exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE")
exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB")

/*
 729. My Calendar I
 Medium
 
 You are implementing a program to use as your calendar. We can add a new event if adding the event will not cause a double booking.

 A double booking happens when two events have some non-empty intersection (i.e., some moment is common to both events.).

 The event can be represented as a pair of integers start and end that represents a booking on the half-open interval [start, end), the range of real numbers x such that start <= x < end.

 Implement the MyCalendar class:

 MyCalendar() Initializes the calendar object.
 boolean book(int start, int end) Returns true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.
  

 Example 1:

 Input
 ["MyCalendar", "book", "book", "book"]
 [[], [10, 20], [15, 25], [20, 30]]
 Output
 [null, true, false, true]

 Explanation
 MyCalendar myCalendar = new MyCalendar();
 myCalendar.book(10, 20); // return True
 myCalendar.book(15, 25); // return False, It can not be booked because time 15 is already booked by another event.
 myCalendar.book(20, 30); // return True, The event can be booked, as the first event takes every time less than 20, but not including 20.
  

 Constraints:

 0 <= start < end <= 109
 At most 1000 calls will be made to book.
 */

class MyCalendar {
    struct Event {
        let start : Int
        let end : Int
        
        func check(with event: Event) -> Bool {
            if event.end <= self.start || event.start >= self.end { return false }
            return true
        }
    }
    
    private var _events : [Event]
    
    init() {
        _events = []
    }
    
    func book(_ start: Int, _ end: Int) -> Bool {
        let newEvent : Event = .init(start: start, end: end)
        
        for event in _events {
            if event.check(with: newEvent) == true {
                return false
            }
        }
        _events.append(newEvent)
        
        return true
    }
}

let myCalendar : MyCalendar = .init()
myCalendar.book(10, 20); // return True
myCalendar.book(15, 25); // return False, It can not be booked because time 15 is already booked by another event.
myCalendar.book(20, 30); // return True, The event can be booked, as the first event takes every time less than 20, but not including 20.

/*
 412. Fizz Buzz
 Easy

 718

 118

 Add to List

 Share
 Given an integer n, return a string array answer (1-indexed) where:

 answer[i] == "FizzBuzz" if i is divisible by 3 and 5.
 answer[i] == "Fizz" if i is divisible by 3.
 answer[i] == "Buzz" if i is divisible by 5.
 answer[i] == i (as a string) if none of the above conditions are true.
  

 Example 1:

 Input: n = 3
 Output: ["1","2","Fizz"]
 Example 2:

 Input: n = 5
 Output: ["1","2","Fizz","4","Buzz"]
 Example 3:

 Input: n = 15
 Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]
  

 Constraints:

 1 <= n <= 104
 Accepted
 694,722
 Submissions

 */

func fizzBuzz(_ n: Int) -> [String] {
    var result : [String] = []
    for i in 1 ... n {
        if i % 15 == 0 { result.append("FizzBuzz") }
        else if i % 5 == 0 { result.append("Buzz") }
        else if i % 3 == 0 { result.append("Fizz") }
        else { result.append("\(i)") }
    }
    return result
}

fizzBuzz(3)
fizzBuzz(5)
fizzBuzz(15)

/*
 94. Binary Tree Inorder Traversal
 
 Given the root of a binary tree, return the inorder traversal of its nodes' values.

  

 Example 1:


 Input: root = [1,null,2,3]
 Output: [1,3,2]
 Example 2:

 Input: root = []
 Output: []
 Example 3:

 Input: root = [1]
 Output: [1]
  

 Constraints:

 The number of nodes in the tree is in the range [0, 100].
 -100 <= Node.val <= 100
  

 Follow up: Recursive solution is trivial, could you do it iteratively?
 */

/*
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

func inorderTraversal(_ root: TreeNode?) -> [Int] {
    guard let root = root else {return []}
       var result = [Int]()
       helper(root, &result)
       return result
   }

func helper(_ root :TreeNode?, _ result :inout [Int]) {
   guard let root = root else {return}
   
   helper(root.left, &result)
   result.append(root.val)
   helper(root.right, &result)
}

/*
 96. Unique Binary Search Trees
 Medium

 Given an integer n, return the number of structurally unique BST's (binary search trees) which has exactly n nodes of unique values from 1 to n.

  

 Example 1:


 Input: n = 3
 Output: 5
 Example 2:

 Input: n = 1
 Output: 1
  

 Constraints:

 1 <= n <= 19
 */

func numTrees(_ n: Int) -> Int {
    var result = 1
    if n > 0 {
        for i in 1...n {
            result = result * 2 * (2 * i - 1) / (i + 1)
        }
    }
    return result
}

/*
 1220. Count Vowels Permutation
 Hard

 Given an integer n, your task is to count how many strings of length n can be formed under the following rules:

 Each character is a lower case vowel ('a', 'e', 'i', 'o', 'u')
 Each vowel 'a' may only be followed by an 'e'.
 Each vowel 'e' may only be followed by an 'a' or an 'i'.
 Each vowel 'i' may not be followed by another 'i'.
 Each vowel 'o' may only be followed by an 'i' or a 'u'.
 Each vowel 'u' may only be followed by an 'a'.
 Since the answer may be too large, return it modulo 10^9 + 7.

  

 Example 1:

 Input: n = 1
 Output: 5
 Explanation: All possible strings are: "a", "e", "i" , "o" and "u".
 Example 2:

 Input: n = 2
 Output: 10
 Explanation: All possible strings are: "ae", "ea", "ei", "ia", "ie", "io", "iu", "oi", "ou" and "ua".
 Example 3:

 Input: n = 5
 Output: 68
  

 Constraints:

 1 <= n <= 2 * 10^4
 */

func countVowelPermutation(_ n: Int) -> Int {
    var dp = (0..<n).map{_ in (0..<5).map{_ in 0 } }
    let mod = Int(1E9+7)
    for i in 0..<5 {
        dp[0][i] = 1
    }
    for i in 1..<n {
        dp[i][0] = (dp[i-1][1] + dp[i-1][2] + dp[i-1][4])// % mod
        dp[i][1] = (dp[i-1][0] + dp[i-1][2]) //% mod
        dp[i][2] = (dp[i-1][1] + dp[i-1][3]) //% mod
        dp[i][3] = dp[i-1][2]
        dp[i][4] = (dp[i-1][2] + dp[i-1][3]) //% mod
    }
    var res = 0
    for i in 0..<5 {
        res += dp[n-1][i]
    }
    return res //% mod
}

countVowelPermutation(1) // 5 "a", "e", "i" , "o" and "u".
countVowelPermutation(2) // 10 "ae", "ea", "ei", "ia", "ie", "io", "iu", "oi", "ou" and "ua".
countVowelPermutation(5) // 68

/*
 9. Palindrome Number
 Easy

 6657

 2243

 Add to List

 Share
 Given an integer x, return true if x is palindrome integer.

 An integer is a palindrome when it reads the same backward as forward.

 For example, 121 is a palindrome while 123 is not.
  

 Example 1:

 Input: x = 121
 Output: true
 Explanation: 121 reads as 121 from left to right and from right to left.
 Example 2:

 Input: x = -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 Example 3:

 Input: x = 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
  

 Constraints:

 -231 <= x <= 231 - 1
 */

func isPalindrome(_ x: Int) -> Bool {
    let string = String(x)
    let reverseString : [Character] = String(x).reversed()
    
    for (index, char) in string.enumerated() {
        if reverseString[index] != char { return false }
    }
    
    return true
}

isPalindrome(121)
isPalindrome(-121)
isPalindrome(10)

/*
 211. Design Add and Search Words Data Structure
 Medium
 
 Design a data structure that supports adding new words and finding if a string matches any previously added string.

 Implement the WordDictionary class:

 WordDictionary() Initializes the object.
 void addWord(word) Adds word to the data structure, it can be matched later.
 bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.
  

 Example:

 Input
 ["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
 [[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
 Output
 [null,null,null,null,false,true,true,true]

 Explanation
 WordDictionary wordDictionary = new WordDictionary();
 wordDictionary.addWord("bad");
 wordDictionary.addWord("dad");
 wordDictionary.addWord("mad");
 wordDictionary.search("pad"); // return False
 wordDictionary.search("bad"); // return True
 wordDictionary.search(".ad"); // return True
 wordDictionary.search("b.."); // return True
  

 Constraints:

 1 <= word.length <= 25
 word in addWord consists of lowercase English letters.
 word in search consist of '.' or lowercase English letters.
 There will be at most 3 dots in word for search queries.
 At most 104 calls will be made to addWord and search.
 */

class WordDictionary {
    private var _dicts: [Int: Set<String>]
    
    init() {
        _dicts = [:]
    }
    
    func addWord(_ word: String) {
        _dicts[word.count, default: []].insert(word)
    }
    
    func search(_ query: String) -> Bool {
        
        func equalString(_ str1: String, _ str2: String) -> Bool {
            func equalCharacter(_ char1: Character, _ char2: Character) -> Bool {
                guard char1 != ".", char2 != "." else {
                    return true
                }
                
                return char1 == char2
            }
            guard str1.count == str2.count else { return false }
            let array1 = Array(str1)
            let array2 = Array(str2)
            
            for i in 0..<array1.count {
                guard equalCharacter(array1[i], array2[i]) else {
                    return false
                }
            }
            
            return true
        }
        
        guard let set = _dicts[query.count] else { return false }
        if query.contains(".") == false { return set.contains(query) }
        
        for word in set {
            guard equalString(word, query) else {
                continue
            }
            return true
        }
        
        return false
        
        
    }
}


var wordDictionary : WordDictionary = .init()
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True

/*
 300. Longest Increasing Subsequence
 Medium

 Given an integer array nums, return the length of the longest strictly increasing subsequence.

 A subsequence is a sequence that can be derived from an array by deleting some or no elements without changing the order of the remaining elements. For example, [3,6,2,7] is a subsequence of the array [0,3,1,6,2,2,7].

  

 Example 1:

 Input: nums = [10,9,2,5,3,7,101,18]
 Output: 4
 Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
 Example 2:

 Input: nums = [0,1,0,3,2,3]
 Output: 4
 Example 3:

 Input: nums = [7,7,7,7,7,7,7]
 Output: 1
  

 Constraints:

 1 <= nums.length <= 2500
 -104 <= nums[i] <= 104
  

 Follow up: Can you come up with an algorithm that runs in O(n log(n)) time complexity
 */

func lengthOfLIS(_ nums: [Int]) -> Int {
    var result = [Int](repeating: 1, count: nums.count)
            
    for i in 1..<nums.count {
        for j in 0..<i {
            if nums[i] > nums[j] {
                result[i] = max(result[i], result[j] + 1)
            }
        }
    }
    print(result)
    return result.max()!
}

lengthOfLIS([10,9,2,5,3,7,101,18]) //4
lengthOfLIS([0,1,0,3,2,3]) //4
lengthOfLIS([7,7,7,7,7,7,7,7]) //1

/*
 823. Binary Trees With Factors
 Medium

 890

 108

 Add to List

 Share
 Given an array of unique integers, arr, where each integer arr[i] is strictly greater than 1.

 We make a binary tree using these integers, and each number may be used for any number of times. Each non-leaf node's value should be equal to the product of the values of its children.

 Return the number of binary trees we can make. The answer may be too large so return the answer modulo 109 + 7.

  

 Example 1:

 Input: arr = [2,4]
 Output: 3
 Explanation: We can make these trees: [2], [4], [4, 2, 2]
 Example 2:

 Input: arr = [2,4,5,10]
 Output: 7
 Explanation: We can make these trees: [2], [4], [5], [10], [4, 2, 2], [10, 2, 5], [10, 5, 2].
  

 Constraints:

 1 <= arr.length <= 1000
 2 <= arr[i] <= 109
 All the values of arr are unique.
 */

func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
    let mod : Int = 1_000_000_007
    let n = arr.count
    var newArr = arr.sorted()
    var dp : [Int] = [Int].init(repeating: 1, count: n)
    
    var index : [Int: Int] = [:]
    
    for i in 0 ..< n {
        index[newArr[i]] = i
    }
    
    for i in 0 ..< n {
        for j in 0 ..< i {
            if newArr[i] % newArr[j] == 0 {
                let right = newArr[i] / newArr[j]
                if let rightIndex = index[right] {
                    dp[i] = (dp[i]+dp[j] * dp[rightIndex]) % mod
                }
            }
        }
    }
    
    var ans : Int = 0
    for x in dp {
        ans += x
    }
    return Int(ans % mod)
}

numFactoredBinaryTrees([2,4])

/*
 108. Convert Sorted Array to Binary Search Tree
 
 Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.

 A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.

  

 Example 1:


 Input: nums = [-10,-3,0,5,9]
 Output: [0,-3,9,-10,null,5]
 Explanation: [0,-10,5,null,-3,null,9] is also accepted:

 Example 2:


 Input: nums = [1,3]
 Output: [3,1]
 Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.
  

 Constraints:

 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums is sorted in a strictly increasing order.
 */

func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    func convert(_ left : Int, _ right : Int) -> TreeNode? {
        guard left <= right else { return nil }
        let mid : Int = (left + right) / 2
        var node : TreeNode = TreeNode(nums[mid])
        node.left = convert(left, mid - 1)
        node.right = convert(mid + 1, right)
        return node
    }
    return convert(0, nums.count - 1)
}

func findIsland(_ arr : [[Int]]) -> Int {
    var result : Int = 0
    var _arr = arr
    func checkIsland(_ arr: inout [[Int]], x: Int, y : Int) {
        arr[x][y] = -1
        let left : Int = max(0, x-1)
        let right : Int = min(arr[0].count, x+1)
        let top : Int = max(0, y-1)
        let bottom : Int = max(arr.count, y+1)
        
        for i in top ..< bottom {
            for j in left ..< right {
                if arr[i][j] == 1 { checkIsland(&arr, x: i, y: j) }
            }
        }
    }
    
    let mCount : Int = arr.count
    let nCount : Int = arr[0].count
    
    for x in 0 ..< mCount {
        for y in 0 ..< nCount {
            if _arr[x][y] == 1 {
                checkIsland(&_arr, x: x, y: y)
                result += 1
            }
        }
    }
    
    
    return result
}

findIsland([
    [1,1,0,0,0],
    [1,0,0,0,0],
    [0,1,0,1,0],
    [0,0,0,0,1],
    [0,0,0,1,1]
])

/*
 98. Validate Binary Search Tree
 Medium

 Given the root of a binary tree, determine if it is a valid binary search tree (BST).

 A valid BST is defined as follows:

 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.
  

 Example 1:


 Input: root = [2,1,3]
 Output: true
 Example 2:


 Input: root = [5,1,4,null,null,3,6]
 Output: false
 Explanation: The root node's value is 5 but its right child's value is 4.
  

 Constraints:

 The number of nodes in the tree is in the range [1, 104].
 -231 <= Node.val <= 231 - 1
 */

func isValidBST(_ root: TreeNode?) -> Bool {
    func validate(_ node: TreeNode?, _ low : Int = Int.min, _ high : Int = Int.max) -> Bool {
        guard let node = node else { return true }
        if node.val <= low || node.val >= high { return false }
        return validate(node.right, node.val, high) && validate(node.left, low, node.val)
    }
    
    return validate(root)
}

/*
 35. Lowest Common Ancestor of a Binary Search Tree
 Easy

 Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.

 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

  

 Example 1:


 Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
 Output: 6
 Explanation: The LCA of nodes 2 and 8 is 6.
 Example 2:


 Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
 Output: 2
 Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
 Example 3:

 Input: root = [2,1], p = 2, q = 1
 Output: 2
  

 Constraints:

 The number of nodes in the tree is in the range [2, 105].
 -109 <= Node.val <= 109
 All Node.val are unique.
 p != q
 p and q will exist in the BST.
 */

func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let root = root, let p = p, let q = q else { return nil }
                    
    if root.val < p.val && root.val < q.val {
        return lowestCommonAncestor(root.right, p, q)
    } else if root.val > p.val && root.val > q.val {
        return lowestCommonAncestor(root.left, p, q)
    }
    return root
}

/*
 30. Substring with Concatenation of All Words
 Hard

 You are given a string s and an array of strings words of the same length. Return all starting indices of substring(s) in s that is a concatenation of each word in words exactly once, in any order, and without any intervening characters.

 You can return the answer in any order.

  

 Example 1:

 Input: s = "barfoothefoobarman", words = ["foo","bar"]
 Output: [0,9]
 Explanation: Substrings starting at index 0 and 9 are "barfoo" and "foobar" respectively.
 The output order does not matter, returning [9,0] is fine too.
 Example 2:

 Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]
 Output: []
 Example 3:

 Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]
 Output: [6,9,12]
  

 Constraints:

 1 <= s.length <= 104
 1 <= words.length <= 5000
 1 <= words[i].length <= 30
 s and words[i] consist of lowercase English letters.
 Accepted
 274,204
 Submissions
 950,906
 */

func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    func slidingWindow(_ left : Int, _ s : String, _ answer : inout [Int]) {
        var wordsFound : [String: Int] = [:]
        var wordsUsed : Int = 0
        var excessWord : Bool = false
        
        
    }
    
    let n : Int = s.count
    let k : Int = words.count
    let wordLength : Int = words[0].count
    let substringSize : Int = wordLength * k
    
    var wordCount : [String : Int] = [:]
    
    for word in words {
        if var count = wordCount[word] {
            wordCount[word] = count + 1
        } else {
            wordCount[word] = 0
        }
    }
    
    var answer : [Int] = []
    for i in 0 ..< wordLength {
        slidingWindow(i, s, &answer)
    }
    return answer
}

findSubstring("barfoothefoobarman", ["foo","bar"]) // [0,9]

/*
 126. Word Ladder II
 Hard
 
 A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

 Every adjacent pair of words differs by a single letter.
 Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
 sk == endWord
 Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].

  

 Example 1:

 Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
 Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
 Explanation: There are 2 shortest transformation sequences:
 "hit" -> "hot" -> "dot" -> "dog" -> "cog"
 "hit" -> "hot" -> "lot" -> "log" -> "cog"
 Example 2:

 Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
 Output: []
 Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.
  

 Constraints:

 1 <= beginWord.length <= 5
 endWord.length == beginWord.length
 1 <= wordList.length <= 500
 wordList[i].length == beginWord.length
 beginWord, endWord, and wordList[i] consist of lowercase English letters.
 beginWord != endWord
 All the words in wordList are unique.
 */

func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
    let wordSet = Set(wordList)
    if wordSet.contains(endWord) == false {
        return []
    }
    var res = [[String]]()
    var queue: [[String]] = [[beginWord]]
    var found = false
    var tempSeen = Set<String>()
    var visited = Set<String>()
    
    while queue.isEmpty == false && found == false {
        let temp = queue
        queue.removeAll()
        visited.formUnion(tempSeen)
        tempSeen.removeAll()
        
        for path in temp {
            let lastWord = Array(path.last!)
            if path.last! == endWord {
                found = true
                res.append(path)
            }

            for i in 0..<lastWord.endIndex {
                for char in "abcdefghijklmnopqrstuvwxyz" {
                    let newWord = String(lastWord[0..<i] + [char] + lastWord[i+1..<lastWord.endIndex])
                    if wordSet.contains(newWord) && visited.contains(newWord) == false {
                        tempSeen.insert(newWord)
                        queue.append(path+[newWord])
                    }
                }
            }
        }
    }
    return res
}
findLadders("hit", "cog", ["hot","dot","dog","lot","log","cog"]) //[["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]

/*
 3. Longest Substring Without Repeating Characters
 Medium

 Given a string s, find the length of the longest substring without repeating characters.

  

 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
  

 Constraints:

 0 <= s.length <= 5 * 104
 s consists of English letters, digits, symbols and spaces.
 Accepted
 3,689,749
 Submissions
 10,980,435
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    let chars : [Character] = s.map { $0 }
    
    var maximum : Int = 0
    var answer : [Character] = []
    for i in 0 ..< chars.count {
        answer = []
        for j in i ..< chars.count {
            if answer.contains(chars[j]) == false {
                answer.append(chars[j])
                maximum = max(answer.count, maximum)
            } else {
                maximum = max(answer.count, maximum)
                break
            }
        }
    }
    return maximum
}

lengthOfLongestSubstring("abcabcbb") // 3. abc
lengthOfLongestSubstring("bbbbb") // 1. b
lengthOfLongestSubstring("pwwkew") // 3. wke

/*
 387. First Unique Character in a String
 Easy

 Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

  

 Example 1:

 Input: s = "leetcode"
 Output: 0
 Example 2:

 Input: s = "loveleetcode"
 Output: 2
 Example 3:

 Input: s = "aabb"
 Output: -1
  

 Constraints:

 1 <= s.length <= 105
 s consists of only lowercase English letters.
 */

func firstUniqChar(_ s: String) -> Int {
//    for (index, char) in s.enumerated() {
//        if s.filter({ $0 == char }).count == 1 { return index }
//    }
//    return -1
    var charTable : [Character : Int] = [:]
    
    for char in s {
        charTable[char, default: 0] += 1
    }
    
    for (index, char) in s.enumerated() {
        if let count = charTable[char], count == 1 { return index }
    }
    
    return -1
}

firstUniqChar("leetcode") // 0
firstUniqChar("loveleetcode") // 2
firstUniqChar("aabb") // -1
/*
 804. Unique Morse Code Words
 Easy

 1341

 1106

 Add to List

 Share
 International Morse Code defines a standard encoding where each letter is mapped to a series of dots and dashes, as follows:

 'a' maps to ".-",
 'b' maps to "-...",
 'c' maps to "-.-.", and so on.
 For convenience, the full table for the 26 letters of the English alphabet is given below:

 [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
 Given an array of strings words where each word can be written as a concatenation of the Morse code of each letter.

 For example, "cab" can be written as "-.-..--...", which is the concatenation of "-.-.", ".-", and "-...". We will call such a concatenation the transformation of a word.
 Return the number of different transformations among all words we have.

  

 Example 1:

 Input: words = ["gin","zen","gig","msg"]
 Output: 2
 Explanation: The transformation of each word is:
 "gin" -> "--...-."
 "zen" -> "--...-."
 "gig" -> "--...--."
 "msg" -> "--...--."
 There are 2 different transformations: "--...-." and "--...--.".
 Example 2:

 Input: words = ["a"]
 Output: 1
  

 Constraints:

 1 <= words.length <= 100
 1 <= words[i].length <= 12
 words[i] consists of lowercase English letters.
 */

func uniqueMorseRepresentations(_ words: [String]) -> Int {
    let morseTable : [Character : String] = [
        "a" : ".-",
        "b" : "-...",
        "c" : "-.-.",
        "d" : "-..",
        "e" : ".",
        "f" : "..-.",
        "g" : "--.",
        "h" : "....",
        "i" : "..",
        "j" : ".---",
        "k" : "-.-",
        "l" : ".-..",
        "m" : "--",
        "n" : "-.",
        "o" : "---",
        "p" : ".--.",
        "q" : "--.-",
        "r" : ".-.",
        "s" : "...",
        "t" : "-",
        "u" : "..-",
        "v" : "...-",
        "w" : ".--",
        "x" : "-..-",
        "y" : "-.--",
        "z" : "--.."
    ]
    
    var answer : Set<String> = Set<String>()
    
    for word in words {
        var morsed : String = ""
        for char in word {
            morsed.append(morseTable[char]!)
        }
        answer.insert(morsed)
    }
    
    return answer.count
}

/*
 1338. Reduce Array Size to The Half
 Medium

 You are given an integer array arr. You can choose a set of integers and remove all the occurrences of these integers in the array.

 Return the minimum size of the set so that at least half of the integers of the array are removed.

  

 Example 1:

 Input: arr = [3,3,3,3,5,5,5,2,2,7]
 Output: 2
 Explanation: Choosing {3,7} will make the new array [5,5,5,2,2] which has size 5 (i.e equal to half of the size of the old array).
 Possible sets of size 2 are {3,5},{3,2},{5,2}.
 Choosing set {2,7} is not possible as it will make the new array [3,3,3,3,5,5,5] which has a size greater than half of the size of the old array.
 Example 2:

 Input: arr = [7,7,7,7,7,7]
 Output: 1
 Explanation: The only possible set you can choose is {7}. This will make the new array empty.
  

 Constraints:

 2 <= arr.length <= 105
 arr.length is even.
 1 <= arr[i] <= 105
 */

func minSetSize(_ arr: [Int]) -> Int {
    var dict = [Int: Int]()
    for i in arr {
        dict[i, default: 0] += 1
    }

    var sort = dict.sorted { $0.value > $1.value }
    let half = arr.count / 2
    var sum = 0

    for i in 0..<sort.count {
        sum += sort[i].value
        if sum >= half {
            return i + 1
        }
    }

    return 0
}

minSetSize([3,3,3,3,5,5,5,2,2,7]) // 2
minSetSize([7,7,7,7,7,7]) // 1

/*
 659. Split Array into Consecutive Subsequences
 Medium

 You are given an integer array nums that is sorted in non-decreasing order.

 Determine if it is possible to split nums into one or more subsequences such that both of the following conditions are true:

 Each subsequence is a consecutive increasing sequence (i.e. each integer is exactly one more than the previous integer).
 All subsequences have a length of 3 or more.
 Return true if you can split nums according to the above conditions, or false otherwise.

 A subsequence of an array is a new array that is formed from the original array by deleting some (can be none) of the elements without disturbing the relative positions of the remaining elements. (i.e., [1,3,5] is a subsequence of [1,2,3,4,5] while [1,3,2] is not).

  

 Example 1:

 Input: nums = [1,2,3,3,4,5]
 Output: true
 Explanation: nums can be split into the following subsequences:
 [1,2,3,3,4,5] --> 1, 2, 3
 [1,2,3,3,4,5] --> 3, 4, 5
 Example 2:

 Input: nums = [1,2,3,3,4,4,5,5]
 Output: true
 Explanation: nums can be split into the following subsequences:
 [1,2,3,3,4,4,5,5] --> 1, 2, 3, 4, 5
 [1,2,3,3,4,4,5,5] --> 3, 4, 5
 Example 3:

 Input: nums = [1,2,3,4,4,5]
 Output: false
 Explanation: It is impossible to split nums into consecutive increasing subsequences of length 3 or more.
  

 Constraints:

 1 <= nums.length <= 104
 -1000 <= nums[i] <= 1000
 nums is sorted in non-decreasing order.
 */

func isPossible(_ nums: [Int]) -> Bool {
    guard nums.count >= 3 else { return false }
            
    var freqMap = [Int: Int]() // [num: freq]
    for num in nums { freqMap[num, default: 0] += 1 }
    
    var subseqMap = [Int: Int]() // [a_subseq_last_num: freq]
    
    for (_, num) in nums.enumerated() {
        if freqMap[num]! == 0 { continue }
        
        // update existing subsequence
        if subseqMap[num - 1, default: 0] > 0 {
            subseqMap[num - 1]! -= 1
            subseqMap[num, default: 0] += 1
        }
        // can create a new subsequence
        else if freqMap[num + 1, default: 0] > 0
             && freqMap[num + 2, default: 0] > 0 {
            subseqMap[num + 2, default: 0] += 1
            
            freqMap[num + 1]! -= 1
            freqMap[num + 2]! -= 1
        } else {
            return false
        }
        
        freqMap[num]! -= 1
    }
    
    return true
}

isPossible([1,2,3,3,4,5])
isPossible([1,2,3,3,4,4,5,5])
isPossible([1,2,3,4,4,5])

/*
 5. Longest Palindromic Substring
 Medium

 Given a string s, return the longest palindromic substring in s.

  

 Example 1:

 Input: s = "babad"
 Output: "bab"
 Explanation: "aba" is also a valid answer.
 Example 2:

 Input: s = "cbbd"
 Output: "bb"
  

 Constraints:

 1 <= s.length <= 1000
 s consist of only digits and English letters.
 */

func longestPalindrome(_ s: String) -> String {
    var res = ""
    var resLength = 0
    let sArr = Array(s)
    for i in 0..<sArr.count {
        // odd length
        var leftIdx = i
        var rightIdx = i
        while leftIdx >= 0 && rightIdx < sArr.count && sArr[leftIdx] == sArr[rightIdx] {
            if (rightIdx - leftIdx + 1) > resLength {
                res = String(sArr[leftIdx..<rightIdx + 1])
                resLength = rightIdx - leftIdx + 1
            }
            leftIdx -= 1
            rightIdx += 1
        }

        // even length
        leftIdx = i
        rightIdx = i + 1
        while leftIdx >= 0 && rightIdx < sArr.count && sArr[leftIdx] == sArr[rightIdx] {
            if (rightIdx - leftIdx + 1) > resLength {
                res = String(sArr[leftIdx..<rightIdx + 1])
                resLength = rightIdx - leftIdx + 1
            }
            leftIdx -= 1
            rightIdx += 1
        }
    }
    return res
}

longestPalindrome("babad")
longestPalindrome("cbbd")

/*
 342. Power of Four
 Easy

 Given an integer n, return true if it is a power of four. Otherwise, return false.

 An integer n is a power of four, if there exists an integer x such that n == 4x.

  

 Example 1:

 Input: n = 16
 Output: true
 Example 2:

 Input: n = 5
 Output: false
 Example 3:

 Input: n = 1
 Output: true
  

 Constraints:

 -231 <= n <= 231 - 1
  

 Follow up: Could you solve it without loops/recursion?
 */

func isPowerOfFour(_ n: Int) -> Bool {
    return n > 0 && (n & (n - 1)) == 0 && (n - 1) % 3 == 0
}

isPowerOfFour(16)
isPowerOfFour(5)
isPowerOfFour(1)

/*
 234. Palindrome Linked List
 Easy

 Given the head of a singly linked list, return true if it is a palindrome.

  

 Example 1:


 Input: head = [1,2,2,1]
 Output: true
 Example 2:


 Input: head = [1,2]
 Output: false
  

 Constraints:

 The number of nodes in the list is in the range [1, 105].
 0 <= Node.val <= 9
  

 Follow up: Could you do it in O(n) time and O(1) space?
 */

func isPalindrome(_ head: ListNode?) -> Bool {
    var fast: ListNode? = head
    var slow: ListNode? = head
    
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
    }
    if fast != nil {
        slow = slow?.next
    }
    slow = reverse(slow)
    fast = head
    while slow != nil {
        if fast?.val != slow?.val {
            return false
        }
        fast = fast?.next
        slow = slow?.next
    }
    
    return true
}

func reverse(_ head: ListNode?) -> ListNode? {
    var head = head
    var pre: ListNode? = nil

    while head != nil {
        let next = head?.next
        head?.next = pre
        pre = head
        head = next
    }
    
    return pre
}

/*
 326. Power of Three
 Easy

 1640

 161

 Add to List

 Share
 Given an integer n, return true if it is a power of three. Otherwise, return false.

 An integer n is a power of three, if there exists an integer x such that n == 3x.

  

 Example 1:

 Input: n = 27
 Output: true
 Example 2:

 Input: n = 0
 Output: false
 Example 3:

 Input: n = 9
 Output: true
  

 Constraints:

 -231 <= n <= 231 - 1
 */

func isPowerOfThree(_ n: Int) -> Bool {
    // solution 1
    /*
    guard n > 0 else { return false }
    var num : Int = n
    while (num % 3 == 0) {
        num /= 3
    }

    return num == 1
     */
    
    // soultion 3
    //return Int((log10(Double(n)) / log10(Double(3)))) % 1 == 0
    // solution 4
    return n > 0 && 1162261467 % n == 0
}

isPowerOfThree(27) // true
isPowerOfThree(0) // false
isPowerOfThree(9) // true

/*
 383. Ransom Note
 Easy

 2520

 352

 Add to List

 Share
 Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.

 Each letter in magazine can only be used once in ransomNote.

  

 Example 1:

 Input: ransomNote = "a", magazine = "b"
 Output: false
 Example 2:

 Input: ransomNote = "aa", magazine = "ab"
 Output: false
 Example 3:

 Input: ransomNote = "aa", magazine = "aab"
 Output: true
  

 Constraints:

 1 <= ransomNote.length, magazine.length <= 105
 ransomNote and magazine consist of lowercase English letters.
 Accepted
 509,692
 Submissions
 894,386
 */
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var ransomTable : [Character : Int] = [:]
    for char in ransomNote {
        ransomTable[char, default: 0] += 1
    }
    
    var magazineTable : [Character : Int] = [:]
    for char in magazine {
        magazineTable[char, default: 0] += 1
    }
    
    for key in magazineTable.keys {
        if ransomTable[key] != nil {
            ransomTable[key]! -= magazineTable[key]!
        }
    }
    
    for key in ransomTable.keys {
        if ransomTable[key]! > 0 {
            return false
        }
    }
    return true
}

canConstruct("a", "b")
canConstruct("aa", "ab")
canConstruct("aa", "aab")

/*
 869. Reordered Power of 2
 Medium

 1015

 260

 Add to List

 Share
 You are given an integer n. We reorder the digits in any order (including the original order) such that the leading digit is not zero.

 Return true if and only if we can do this so that the resulting number is a power of two.

  

 Example 1:

 Input: n = 1
 Output: true
 Example 2:

 Input: n = 10
 Output: false
  

 Constraints:

 1 <= n <= 109
 */

func reorderedPowerOf2(_ n: Int) -> Bool {
    let answer : [Int] = count(n)
    
    for i in 0 ..< 32 {
        if  answer == count(1 << i) {
            return true
        }
    }
    
    return false
}

func count(_ n: Int) -> [Int] {
    var number : Int = n
    var answer : [Int] = [Int].init(repeating: 0, count: 10)
    while(number > 0) {
        answer[number % 10] += 1
        number /= 10
    }
    return answer
}

reorderedPowerOf2(1)
reorderedPowerOf2(24)

/*
 363. Max Sum of Rectangle No Larger Than K
 Hard

 
 Given an m x n matrix matrix and an integer k, return the max sum of a rectangle in the matrix such that its sum is no larger than k.

 It is guaranteed that there will be a rectangle with a sum no larger than k.

  

 Example 1:


 Input: matrix = [[1,0,1],[0,-2,3]], k = 2
 Output: 2
 Explanation: Because the sum of the blue rectangle [[0, 1], [-2, 3]] is 2, and 2 is the max number no larger than k (k = 2).
 Example 2:

 Input: matrix = [[2,2,-1]], k = 3
 Output: 3
  

 Constraints:

 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -100 <= matrix[i][j] <= 100
 -105 <= k <= 105
  

 Follow up: What if the number of rows is much larger than the number of columns?
 */

func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
    var res = Int.min
    let m = matrix.count
    let n = matrix[0].count
    
    
    for left in 0..<n {
        var rowsSum = [Int](repeating: 0, count: m)
        for right in left..<n {
            
            for row in 0..<m {
                rowsSum[row] += matrix[row][right]
            }
            res = max(countSubarraysSmallerThenK(rowsSum, k), res)
        }
    }
    
    return res
}

func countSubarraysSmallerThenK(_ arr: [Int], _ k: Int) -> Int {
    var res = Int.min
    
    for i in 0..<arr.count {
        var sum = 0
        for j in i..<arr.count {
            sum += arr[j]
            if sum > res && sum <= k {
                res = sum
            }
        }
    }
    
    return res
}

/*
 6. Zigzag Conversion
 Medium

 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

 P   A   H   N
 A P L S I I G
 Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"

 Write the code that will take a string and make this conversion given a number of rows:

 string convert(string s, int numRows);
  

 Example 1:

 Input: s = "PAYPALISHIRING", numRows = 3
 Output: "PAHNAPLSIIGYIR"
 Example 2:

 Input: s = "PAYPALISHIRING", numRows = 4
 Output: "PINALSIGYAHRPI"
 Explanation:
 P     I    N
 A   L S  I G
 Y A   H R
 P     I
 Example 3:

 Input: s = "A", numRows = 1
 Output: "A"
  

 Constraints:

 1 <= s.length <= 1000
 s consists of English letters (lower-case and upper-case), ',' and '.'.
 1 <= numRows <= 1000
 */

func convert(_ s: String, _ numRows: Int) -> String {
    guard numRows != 1 else { return s }
       
    var zigzagArr : [[Character]] = Array(repeating: Array(repeating: "$", count: 0 ), count: numRows)
    var isTop = true;
    var isBottom = false;
    var i = 0;
  

    for item in s {
        if isTop {
            zigzagArr[i].append(item);
            i += 1 ;
            if i == numRows {
                i = (numRows - 2);
                isTop = false;
                isBottom =  true;
            }
        } else if isBottom {
            zigzagArr[i].append(item)
            i -= 1;
            if i == -1 {
                i = 1;
                isTop = true;
                isBottom = false;
            }
        }
    }
    var str : String = ""
    for item2 in zigzagArr {

        str = str + String(item2)
    }
    return str;
}

convert("PAYPALISHIRING", 3)  // PAHNAPLSIIGYIR
convert("PAYPALISHIRING", 4)  // PINALSIGYAHRPI

/*
 48. Rotate Image
 Medium

 You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

 You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

  

 Example 1:


 Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
 Output: [[7,4,1],[8,5,2],[9,6,3]]
 Example 2:


 Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
 Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
  

 Constraints:

 n == matrix.length == matrix[i].length
 1 <= n <= 20
 -1000 <= matrix[i][j] <= 1000
 */

func rotate(_ matrix: inout [[Int]]) {
    let n = matrix.count
    // transpose
    for i in 0 ..< n {
        for j in i + 1 ..< n {
            let temp = matrix[j][i]
            matrix[j][i] = matrix[i][j]
            matrix[i][j] = temp
        }
    }
    
    // reflect
    for i in 0 ..< n {
        for j in 0 ..< n / 2 {
            let temp = matrix[i][j]
            matrix[i][j] = matrix[i][n - j - 1]
            matrix[i][n - j - 1] = temp
         }
    }
}

var rotateMatrix : [[Int]] = [[1,2,3],[4,5,6],[7,8,9]]
rotate(&rotateMatrix)
print(rotateMatrix) // [[7,4,1],[8,5,2],[9,6,3]]

/*
 417. Pacific Atlantic Water Flow
 Medium

 There is an m x n rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

 The island is partitioned into a grid of square cells. You are given an m x n integer matrix heights where heights[r][c] represents the height above sea level of the cell at coordinate (r, c).

 The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

 Return a 2D list of grid coordinates result where result[i] = [ri, ci] denotes that rain water can flow from cell (ri, ci) to both the Pacific and Atlantic oceans.

  

 Example 1:


 Input: heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]
 Output: [[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]
 Explanation: The following cells can flow to the Pacific and Atlantic oceans, as shown below:
 [0,4]: [0,4] -> Pacific Ocean
        [0,4] -> Atlantic Ocean
 [1,3]: [1,3] -> [0,3] -> Pacific Ocean
        [1,3] -> [1,4] -> Atlantic Ocean
 [1,4]: [1,4] -> [1,3] -> [0,3] -> Pacific Ocean
        [1,4] -> Atlantic Ocean
 [2,2]: [2,2] -> [1,2] -> [0,2] -> Pacific Ocean
        [2,2] -> [2,3] -> [2,4] -> Atlantic Ocean
 [3,0]: [3,0] -> Pacific Ocean
        [3,0] -> [4,0] -> Atlantic Ocean
 [3,1]: [3,1] -> [3,0] -> Pacific Ocean
        [3,1] -> [4,1] -> Atlantic Ocean
 [4,0]: [4,0] -> Pacific Ocean
        [4,0] -> Atlantic Ocean
 Note that there are other possible paths for these cells to flow to the Pacific and Atlantic oceans.
 Example 2:

 Input: heights = [[1]]
 Output: [[0,0]]
 Explanation: The water can flow from the only cell to the Pacific and Atlantic oceans.
  

 Constraints:

 m == heights.length
 n == heights[r].length
 1 <= m, n <= 200
 0 <= heights[r][c] <= 105
 */

struct IslandLocation: Hashable {
    let row: Int
    let col: Int
    
    static func ==(lhs: IslandLocation, rhs: IslandLocation) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}

func pacificAtlantic(_ heights: [[Int]]) -> [[Int]] {
    
    guard heights.count > 0 else { return [[Int]]() }
    
    var paths = [[Int]]()
    
    for row in 0..<heights.count {
        for col in 0..<heights[row].count {
            let startLocation = IslandLocation(row: row, col: col)
            if pathFound(in: heights, startLocation: startLocation) {
                paths.append([row,col])
            }
        }
    }
    
    return paths
}

func atlanticFoundIn(_ grid: [[Int]], at location: IslandLocation) -> Bool {
    return location.row == grid.count - 1 || location.col == grid[location.row].count - 1 ? true : false
}

func pacificFoundIn(_ grid: [[Int]], at location: IslandLocation) -> Bool {
    return location.row == 0 || location.col == 0 ? true : false
}

func pathFound(in grid: [[Int]], startLocation: IslandLocation) -> Bool {
    
    var pacificFound = false
    var atlanticFound = false
    
    var island = [IslandLocation]()
    island.append(startLocation)
    
    var explored = Set<IslandLocation>()
    explored.insert(startLocation)
    
    while !island.isEmpty {
        
        let currentLocation = island.removeLast()
        let currentValue = grid[currentLocation.row][currentLocation.col]
        
        if pacificFoundIn(grid, at: currentLocation) {
            pacificFound = true
        }
        
        if atlanticFoundIn(grid, at: currentLocation) {
            atlanticFound = true
        }
        
        if pacificFound && atlanticFound {
            return true
        }
        
        for child in successors(for: grid, location: currentLocation) where !explored.contains(child) {
            explored.insert(child)
            island.append(child)
        }

    }
    
    return false
}

func successors(for grid: [[Int]], location: IslandLocation) -> [IslandLocation] {
    var successors = [IslandLocation]()
    
    let currentLocationValue = grid[location.row][location.col]
    
    // North
    if location.row - 1 >= 0 && currentLocationValue >= grid[location.row - 1][location.col] {
        successors.append(IslandLocation(row: location.row - 1, col: location.col))
    }
    // South
    if location.row + 1 < grid.count && currentLocationValue >= grid[location.row + 1][location.col] {
        successors.append(IslandLocation(row: location.row + 1, col: location.col))
    }
    // East
    if location.col + 1 < grid[location.row].count && currentLocationValue >= grid[location.row][location.col + 1] {
        successors.append(IslandLocation(row: location.row, col: location.col + 1))
    }
    // West
    if location.col - 1 >= 0 && currentLocationValue >= grid[location.row][location.col - 1] {
        successors.append(IslandLocation(row: location.row, col: location.col - 1))
    }
    
    return successors
}

/*
 1448. Count Good Nodes in Binary Tree
 Medium

 Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.

 Return the number of good nodes in the binary tree.

  

 Example 1:



 Input: root = [3,1,4,3,null,1,5]
 Output: 4
 Explanation: Nodes in blue are good.
 Root Node (3) is always a good node.
 Node 4 -> (3,4) is the maximum value in the path starting from the root.
 Node 5 -> (3,4,5) is the maximum value in the path
 Node 3 -> (3,1,3) is the maximum value in the path.
 Example 2:



 Input: root = [3,3,null,4,2]
 Output: 3
 Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.
 Example 3:

 Input: root = [1]
 Output: 1
 Explanation: Root is considered as good.
  

 Constraints:

 The number of nodes in the binary tree is in the range [1, 10^5].
 Each node's value is between [-10^4, 10^4].
 Accepted
 218,415
 Submissions
 296,728
 */


// simple solution
var result = 0

func goodNodes(_ root: TreeNode?) -> Int {
    check(node: root!, maxVal: Int.min)
    return result
}

func check(node: TreeNode, maxVal: Int) {
    if node.val >= maxVal {
        result += 1
    }
    let newMaxVal = max(maxVal, node.val)
    if let left = node.left {
        check(node: left, maxVal: newMaxVal)
    }
    if let right = node.right {
        check(node: right, maxVal: newMaxVal)
    }
}

// dfs

func goodNodesDfs(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return dfs(root, root.val)
}

private func dfs(_ root: TreeNode?, _ parentsMax: Int)->Int{
    guard let root = root else{ return 0 }
    
    let currentMax = max(root.val, parentsMax)
    return (root.val >= parentsMax ? 1 : 0) + dfs(root.left, currentMax) + dfs(root.right, currentMax)
}

/*
 637. Average of Levels in Binary Tree
 Easy

 Given the root of a binary tree, return the average value of the nodes on each level in the form of an array. Answers within 10-5 of the actual answer will be accepted.
  

 Example 1:


 Input: root = [3,9,20,null,null,15,7]
 Output: [3.00000,14.50000,11.00000]
 Explanation: The average value of nodes on level 0 is 3, on level 1 is 14.5, and on level 2 is 11.
 Hence return [3, 14.5, 11].
 Example 2:


 Input: root = [3,9,20,15,7]
 Output: [3.00000,14.50000,11.00000]
  

 Constraints:

 The number of nodes in the tree is in the range [1, 104].
 -231 <= Node.val <= 231 - 1
 */

func averageOfLevels(_ root: TreeNode?) -> [Double] {
    var count : [Int] = []
    var res : [Double] = []
    
    average(root, 0, &res, &count)
    for i in 0 ..< res.count {
        res[i] = res[i] / Double(count[i])
    }
    
    return res
}
 
func average(_ t: TreeNode? , _ i : Int, _ sum : inout [Double], _ count : inout [Int]) {
    guard let t = t else { return }

    if i < sum.count {
        sum[i] = sum[i] + Double(t.val)
        count[i] = count[i] + 1
    } else {
        sum.append(Double(t.val))
        count.append(1)
    }
    average(t.left, i+1, &sum, &count)
    average(t.right, i+1, &sum, &count)
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

func averageOfLevelsBFS(_ root: TreeNode?) -> [Double] {
    guard let root = root else { return [] }
    var res : [Double] = []
    var queue : Queue<TreeNode> = .init()
    queue.enqueue(x: root)
    
    while queue.size() != 0 {
        var sum = 0
        var count = 0
        let temp : Queue<TreeNode> = .init()
        while queue.size() != 0 {
            if let n : TreeNode = queue.dequeue() {
                sum += n.val
                count += 1
                if let left = n.left {
                    temp.enqueue(x: left)
                }
                if let right = n.right {
                    temp.enqueue(x: right)
                }
            }
        }
        queue = temp
        res.append(Double(sum) / Double(count))
    }
    
    return res
}

/*
 1996. The Number of Weak Characters in the Game
 Medium

 1185

 43

 Add to List

 Share
 You are playing a game that contains multiple characters, and each of the characters has two main properties: attack and defense. You are given a 2D integer array properties where properties[i] = [attacki, defensei] represents the properties of the ith character in the game.

 A character is said to be weak if any other character has both attack and defense levels strictly greater than this character's attack and defense levels. More formally, a character i is said to be weak if there exists another character j where attackj > attacki and defensej > defensei.

 Return the number of weak characters.

  

 Example 1:

 Input: properties = [[5,5],[6,3],[3,6]]
 Output: 0
 Explanation: No character has strictly greater attack and defense than the other.
 Example 2:

 Input: properties = [[2,2],[3,3]]
 Output: 1
 Explanation: The first character is weak because the second character has a strictly greater attack and defense.
 Example 3:

 Input: properties = [[1,5],[10,4],[4,3]]
 Output: 1
 Explanation: The third character is weak because the second character has a strictly greater attack and defense.
  

 Constraints:

 2 <= properties.length <= 105
 properties[i].length == 2
 1 <= attacki, defensei <= 105
 */

func numberOfWeakCharacters(_ properties: [[Int]]) -> Int {
    return Int.min
}

numberOfWeakCharacters([[5,5],[6,3],[3,6]]) // 0. No character has strictly greater attack and defense than the other.
