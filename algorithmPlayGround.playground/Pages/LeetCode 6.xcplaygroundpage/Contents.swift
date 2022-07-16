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
    1 : "I",
    5 : "V",
    10 : "X",
    50 : "L",
    100 : "C",
    500 : "D",
    1000 : "M",
]

func intToRoman(_ num: Int) -> String {
    guard num > 0 && num < 4000 else { return "" }
    
    func processWith(_ input: Int, roman: String, num: Int) -> (Int, String) {
        guard
            input > 0,
            Int(input / num) > 0
        else {
            if num > 1 && input == num - 1 {
                let prevString : String = "I"+roman
                return (input, prevString)
            }
            return (0, "")
        }
        var count : Int = Int(input / num)
        
        var resultOutput : Int = 0
        var resultRoman : String  = ""
        
        resultOutput = (count * num)
        for _ in 0 ..< count {
            resultRoman.append(roman)
        }
        
        return (resultOutput, resultRoman)
    }
    
    var roman : String = ""
    var cNum = num
    var (processedNum, newRoman) : (Int, String) = (0, "")
    
    romanTable.keys.sorted{ $0 > $1 }.forEach { key in
        if let romanValue = romanTable[key] {
            (processedNum, newRoman) = processWith(cNum, roman: romanValue, num: key)
            cNum -= processedNum
            roman.append(newRoman)
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
intToRoman(58)
intToRoman(1994)
