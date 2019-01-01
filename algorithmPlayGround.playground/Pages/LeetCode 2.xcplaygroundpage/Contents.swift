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
    if numRows <= 1 {
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
            goingDown = !goingDown
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
zigzagConvert("PAYPALISHIRING", 2)
zigzagConvert("PAYPALISHIRING", 3)
zigzagConvert("PAYPALISHIRING", 4)

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
    //let trimmedS = s.replacingOccurrences(of: " ", with: "")
    
    var pointSeen = false;
    var eSeen = false;
    var numberSeen = false;
    var numberAfterE = true;
    
    var prevChar : Character = Character(" ")
    
    for (index, char) in s.enumerated() {
        if(char == "0" || char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9") {
            numberSeen = true
            numberAfterE = true
        } else if(char == ".") {
            if(eSeen || pointSeen) {
                return false
            }
            pointSeen = true
        } else if(char == "e") {
            if(eSeen || !numberSeen) {
                return false
            }
            numberAfterE = false
            eSeen = true;
        } else if(char == "-" || char == "+") {
            if(index != 0 && prevChar != "e") {
                return false
            }
        } else {
            return false
        }
        prevChar = char
    }
    
    return numberSeen && numberAfterE
}

isNumber("0")// => true
isNumber("1 ")// => false
isNumber(" 0.1 ")// => true
isNumber("abc")// => false
isNumber("1 a")// => false
isNumber("2e10")// => true
isNumber(" -90e3   ")// => true
isNumber(" 1e")// => false
isNumber("e3")// => false
isNumber(" 6e-1")// => true
isNumber(" 99e2.5 ")// => false
isNumber("53.5e93")// => true
isNumber(" --6 ")// => false
isNumber("-+3")// => false
isNumber("95a54e53")// => false

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
        var numAndMaxCount : (Int, Int) = (0,0)
        for (num, count) in freqDic {
            if numAndMaxCount.1 < count {
                numAndMaxCount = (num, count)
            }
        }
        
        if numAndMaxCount.0 > 0 && numAndMaxCount.1 > 0 {
            if let index = stack.firstIndex(of: numAndMaxCount.0) {
                stack.remove(at: index)
                return numAndMaxCount.0
            }
        }
        
        return stack.popLast()
    }
}

var fStack = FreqStack()
fStack.push(5)
fStack.push(7)
fStack.push(5)
fStack.push(7)
fStack.push(4)
fStack.push(5)
fStack.pop()
fStack.pop()
fStack.pop()
fStack.pop()


class Stack {
    fileprivate var array : [Int] = [Int]()
    
    func size() -> Int {
        return array.count
    }
    
    func push(_ x : Int) {
        array.append(x)
    }
    
    func pop() -> Int? {
        return array.popLast()
    }
}

func calculator(_ x : String) -> Int {
    let array = x.split(separator: " ")
    let stack = Stack()
    for s in array {
        if let num = Int(s) {
            stack.push(num)
        } else {
            guard let firstNum = stack.pop(), let secondNum = stack.pop() else { return Int.min }
            if s == "+" {
                stack.push(firstNum + secondNum)
            } else if s == "*" {
                stack.push(firstNum * secondNum)
            }
        }
    }
    
    guard let pop = stack.pop() else { return Int.min }
    return pop
}

calculator("1 3 + 5 *")

func rerange(_ x: String) -> String {
    guard x.count >= 1 && x.count <= 50 else { return x }
    guard let scalarA = UnicodeScalar("a")?.value else { return x }
    var alphabets : [Int] = [Int](repeating: 0, count: 26)
    for c in x {
        if let value = UnicodeScalar("\(c)")?.value {
            let index = Int(value - scalarA)
            alphabets[index] += 1
        }
    }
    
    var answer = ""
    for (index, count) in alphabets.enumerated().reversed() {
        if count > 0 {
            let scalaValue = UInt32(index) + scalarA
            for _ in 0 ..< count {
                if let unicodeScala = UnicodeScalar(scalaValue) {
                    answer.append(Character(unicodeScala))
                }
            }
        }
    }
    
    return answer
}

rerange("interview")

func getSumOfCube(a: Int, b: Int) -> Int {
    guard a >= 1 && a <= 10000 else { return Int.min }
    guard b >= 1 && b <= 10 else { return Int.min}
    let maximumCount : Int = a/b
    var values : [Int] = [Int]()
    for i in 1 ... maximumCount {
        values.append(b*i)
    }
    
    let cubeValues = values.map { (value) -> Int in
        return value*value*value
    }
    
    var sum = 0
    for cubeValue in cubeValues {
        sum += cubeValue
    }
    return sum
}

getSumOfCube(a: 10, b: 3)
getSumOfCube(a: 20, b: 3)

func fibonacci(_ x : Int ) -> Int {
    guard x >= 0 && x <= 50 else { return Int.min }
    if x == 0 || x == 1 { return  x }
    return fibonacci(x-1) + fibonacci(x-2)
}

fibonacci(0)
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(6)
fibonacci(7)
fibonacci(8)
fibonacci(9)
fibonacci(10)
fibonacci(11)

// 50. Pow(x, n)

/*
 Implement pow(x, n), which calculates x raised to the power n (xn).
 
 Example 1:
 
 Input: 2.00000, 10
 Output: 1024.00000
 Example 2:
 
 Input: 2.10000, 3
 Output: 9.26100
 Example 3:
 
 Input: 2.00000, -2
 Output: 0.25000
 Explanation: 2-2 = 1/22 = 1/4 = 0.25
 Note:
 
 -100.0 < x < 100.0
 n is a 32-bit signed integer, within the range [−2^31, 2^31 − 1]
*/

func myPow(_ x: Double, _ n: Int) -> Double {
    if (n == 0) {
        return 1
    }
    let temp = myPow(x, n/2)
    if (n%2 == 0) {
        return temp * temp
    }
    else {
        if(n > 0) {
            return x * temp * temp
        }
        else {
            return (temp * temp)/x
        }
    }
}

myPow(2.00000, 10)
myPow(2.10000, 3)
myPow(2.00000, -2)

/*
 37. Sudoku Solver
 
 Write a program to solve a Sudoku puzzle by filling the empty cells.
 
 A sudoku solution must satisfy all of the following rules:
 
 Each of the digits 1-9 must occur exactly once in each row.
 Each of the digits 1-9 must occur exactly once in each column.
 Each of the the digits 1-9 must occur exactly once in each of the 9 3x3 sub-boxes of the grid.
 Empty cells are indicated by the character '.'.
 
 Note:
 
 The given board contain only digits 1-9 and the character '.'.
 You may assume that the given Sudoku puzzle will have a single unique solution.
 The given board size is always 9x9.
 
 */

func solveSudoku(_ board: inout [[Character]]) -> Bool {
    let numbers : [Character] = ["1","2","3","4","5","6","7","8","9"]
    for j in 0 ..< 9 {
        for i in 0 ..< 9 {
            if board[j][i] == "." {
                for k in 0 ..< 9 {
                    if sudokuValidator(board, x: i, y: j, c: numbers[k]) == true {
                        board[j][i] = numbers[k]
                        if solveSudoku(&board) == true {
                            return true
                        }
                    }
                    board[j][i] = "."
                }
                return false
            }
        }
    }
    return true
}

func sudokuValidator(_ board: [[Character]], x : Int, y : Int, c : Character) -> Bool? {
    guard c != "." else { return nil }
    
    for i in 0 ..< 9 {
        if board[y][i] == c { return false }
    }
    
    for j in 0 ..< 9 {
        if board[j][x] == c { return false }
    }
    
    let xIndex = Int(x / 3)
    let yIndex = Int(y / 3)
    
    for j in 0 ..< 3 {
        for i in 0 ..< 3 {
            if board[(yIndex*3)+j][(xIndex*3)+i] == c { return false }
        }
    }
    return true
}

var board : [[Character]] = [
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

//solveSudoku(&board)

//36. Valid Sudoku
/*
 Determine if a 9x9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
 
 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the 9 3x3 sub-boxes of the grid must contain the digits 1-9 without repetition.
 
 A partially filled sudoku which is valid.
 
 The Sudoku board could be partially filled, where empty cells are filled with the character '.'.
 
 Example 1:
 
 Input:
 [
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
 Output: true
 Example 2:
 
 Input:
 [
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
 Output: false
 Explanation: Same as Example 1, except with the 5 in the top left corner being
 modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
 Note:
 
 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 The given board contain only digits 1-9 and the character '.'.
 The given board size is always 9x9.
 */

func isValidSudoku(_ board: [[Character]]) -> Bool {
    for rowIndex in 0 ..< 9 {
        //check row
        for x in 0 ..< 9 {
            print("rowIndx : \(rowIndex), x : \(x), value :\(board[rowIndex][x])")
        }
    }
    
    for columnIndex in 0 ..< 9 {
        //check column
        for y in 0 ..< 9 {
            print("columnIndex : \(columnIndex), y : \(y) , value :\(board[y][columnIndex])")
        }
    }
    
    for subBoxRowIndex in 0 ..< 3 {
        for subBoxColumnIndex in 0 ..< 3 {
            print("row : \(subBoxRowIndex), column : \(subBoxColumnIndex)")
        }
    }
    return true
    
    
}

//isValidSudoku(board)


/*
 69. Sqrt(x)
 
 Implement int sqrt(int x).
 
 Compute and return the square root of x, where x is guaranteed to be a non-negative integer.
 
 Since the return type is an integer, the decimal digits are truncated and only the integer part of the result is returned.
 
 Example 1:
 
 Input: 4
 Output: 2
 Example 2:
 
 Input: 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since
 the decimal part is truncated, 2 is returned.
 */

func mySqrt(_ x: Int) -> Int {
    return Int(sqrt(Double(x)))
}

mySqrt(4)
mySqrt(8)

// comes from https://www.codeproject.com/Articles/570700/SquareplusRootplusalgorithmplusforplusC
func powerOfTen(_ num : Int) -> Double {
    var rst : Double = 1.0
    if num >= 0 {
        for _ in 0 ..< num {
            rst *= 10.0
        }
    } else {
        for _ in 0 ..< (0 - num) {
            rst *= 0.1
        }
    }
    return rst
}

powerOfTen(10)
powerOfTen(-10)

func squareRoot(_ a : Double) -> Double {
    var z : Double = a
    var rst : Double = 0.0
    let max : Int = 8
    var j : Double = 1.0
    
    for i in (1 ..< max+1).reversed() {
        if z - ((2*rst) + (j*powerOfTen(i)))*(j*powerOfTen(i)) >= 0 {
            while z - (( 2 * rst ) + ( j * powerOfTen(i)))*( j * powerOfTen(i)) >= 0 {
                j += 1
                if j >= 10 {
                    break
                }
            }
            j -= 1
            z -= (( 2 * rst ) + ( j * powerOfTen(i)))*( j * powerOfTen(i))
            j = 1.0
        }
        
    }
    
    for i in (0 ..< 0-max).reversed() {
        if z - (( 2 * rst ) + ( j * powerOfTen(i)))*( j * powerOfTen(i)) >= 0 {
            while z - (( 2 * rst ) + ( j * powerOfTen(i)))*( j * powerOfTen(i)) >= 0 {
                j += 1
            }
            j -= 1
            z -= (( 2 * rst ) + ( j * powerOfTen(i)))*( j * powerOfTen(i))
            
            rst += j * powerOfTen(i);     // find sum of a
            j = 1.0
        }
    }
    
    return rst
}

squareRoot(4) //overflow
