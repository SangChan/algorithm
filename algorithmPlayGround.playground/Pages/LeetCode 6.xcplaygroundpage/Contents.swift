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
