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
