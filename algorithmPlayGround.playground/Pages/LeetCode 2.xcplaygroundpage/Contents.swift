//: [Previous](@previous)

import Foundation

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
    func createPattern(_ base: String) -> [Int] {
        var pattern : [Int] = []
        var charDic : [Character : Int] = [Character : Int]()
        var hashNum = 0
        for char in base {
            if let hashVal = charDic[char] {
                pattern.append(hashVal)
            } else {
                hashNum += 1
                charDic[char] = hashNum
                pattern.append(hashNum)
            }
        }
        return pattern
    }
    
    let patternFromParam = createPattern(pattern)
    var samePatterns : [String] = []
    for word in words {
        let patternFromWord = createPattern(word)
        if patternFromParam == patternFromWord {
            samePatterns.append(word)
        }
        
    }
    
    return samePatterns
}

let words =  ["abc","deq","mee","aqq","dkd","ccc"]
let pattern = "abb"

findAndReplacePattern(words, pattern) // return ["mee", "aqq"]

/*
 6. ZigZag Conversion
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
 */

func zigzagConvert(_ s: String, _ numRows: Int) -> String {
    if numRows == 1 {
        return s
    }
    var rows : [String] = [String]()
    for _ in 0 ..< min(numRows, s.count) {
        rows.append("")
    }
    
    var curRow = 0
    var goingDown = false
    
    for c in s {
        rows[curRow].append(c)
        if curRow == 0 || curRow == numRows - 1 {
            goingDown != goingDown
        }
        if goingDown {
            curRow += 1
        } else {
            curRow -= 1
        }
    }
    
    var ret = ""
    
    for row in rows {
        ret.append(row)
    }
    
    return ret
}

zigzagConvert("PAYPALISHIRING", 1)

/*
 65. Valid Number
 
 alidate if a given string can be interpreted as a decimal number.
 
 Some examples:
 "0" => true
 " 0.1 " => true
 "abc" => false
 "1 a" => false
 "2e10" => true
 " -90e3   " => true
 " 1e" => false
 "e3" => false
 " 6e-1" => true
 " 99e2.5 " => false
 "53.5e93" => true
 " --6 " => false
 "-+3" => false
 "95a54e53" => false
 
 Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one. However, here is a list of characters that can be in a valid decimal number:
 
 Numbers 0-9
 Exponent - "e"
 Positive/negative sign - "+"/"-"
 Decimal point - "."
 Of course, the context of these characters also matters in the input.
 
 Update (2015-02-10):
 The signature of the C++ function had been updated. If you still see your function signature accepts a const char * argument, please click the reload button to reset your code definition.
 */

func isNumber(_ s: String) -> Bool {
    if Int(s) != nil || Double(s) != nil {
        return true
    } else {
        return false
    }
}

/*
 895. Maximum Frequency Stack
 Implement FreqStack, a class which simulates the operation of a stack-like data structure.
 
 FreqStack has two functions:
 
 push(int x), which pushes an integer x onto the stack.
 pop(), which removes and returns the most frequent element in the stack.
 If there is a tie for most frequent element, the element closest to the top of the stack is removed and returned.
 
 Example 1:
 
 Input:
 ["FreqStack","push","push","push","push","push","push","pop","pop","pop","pop"],
 [[],[5],[7],[5],[7],[4],[5],[],[],[],[]]
 Output: [null,null,null,null,null,null,null,5,7,5,4]
 Explanation:
 After making six .push operations, the stack is [5,7,5,7,4,5] from bottom to top.  Then:
 
 pop() -> returns 5, as 5 is the most frequent.
 The stack becomes [5,7,5,7,4].
 
 pop() -> returns 7, as 5 and 7 is the most frequent, but 7 is closest to the top.
 The stack becomes [5,7,5,4].
 
 pop() -> returns 5.
 The stack becomes [5,7,4].
 
 pop() -> returns 4.
 The stack becomes [5,7].

 Note:
 
 Calls to FreqStack.push(int x) will be such that 0 <= x <= 10^9.
 It is guaranteed that FreqStack.pop() won't be called if the stack has zero elements.
 The total number of FreqStack.push calls will not exceed 10000 in a single test case.
 The total number of FreqStack.pop calls will not exceed 10000 in a single test case.
 The total number of FreqStack.push and FreqStack.pop calls will not exceed 150000 across all test cases.
 */

class FreqStack {
    var stack : [Int] = [Int]()
    var freqDic : [Int : Int] = [Int : Int]()
    
    func push(_ x : Int) {
        var freqCount = freqDic[x] ?? 0
        freqCount += 1
        freqDic[x] = freqCount
        stack.append(x)
    }
    
    func pop() -> Int? {
        return stack.popLast()
    }
}
