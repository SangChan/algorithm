import Foundation
/*

 435. Non-overlapping Intervals
 Medium
 Given a collection of intervals, find the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

  

 Example 1:

 Input: [[1,2],[2,3],[3,4],[1,3]]
 Output: 1
 Explanation: [1,3] can be removed and the rest of intervals are non-overlapping.
 
 Example 2:

 Input: [[1,2],[1,2],[1,2]]
 Output: 2
 Explanation: You need to remove two [1,2] to make the rest of intervals non-overlapping.
 
 Example 3:

 Input: [[1,2],[2,3]]
 Output: 0
 Explanation: You don't need to remove any of the intervals since they're already non-overlapping.
  

 Note:

 You may assume the interval's end point is always bigger than its start point.
 Intervals like [1,2] and [2,3] have borders "touching" but they don't overlap each other.
 

*/

let ex1_435 = [[1,2],[2,3],[3,4],[1,3]]
let ex2_435 = [[1,2],[1,2],[1,2]]
let ex3_435 = [[1,2],[2,3]]

func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
    var intervalMin = Int.min
    var intervalMax = Int.min
    let (min, max) = intervals.map { (array) -> (Int, Int) in
        let min = array.min() ?? Int.min
        let max = array.max() ?? Int.max
        return (min, max)
    }
    
    return 0
}

eraseOverlapIntervals(ex1_435) // 1
eraseOverlapIntervals(ex2_435) // 2
eraseOverlapIntervals(ex3_435) // 0

/*
 
 456. 132 Pattern
 Medium

 Given a sequence of n integers a1, a2, ..., an, a 132 pattern is a subsequence ai, aj, ak such that i < j < k and ai < ak < aj. Design an algorithm that takes a list of n numbers as input and checks whether there is a 132 pattern in the list.

 Note: n will be less than 15,000.

 Example 1:

 Input: [1, 2, 3, 4]

 Output: False

 Explanation: There is no 132 pattern in the sequence.
 
 Example 2:

 Input: [3, 1, 4, 2]

 Output: True

 Explanation: There is a 132 pattern in the sequence: [1, 4, 2].
 
 Example 3:

 Input: [-1, 3, 2, 0]

 Output: True

 Explanation: There are three 132 patterns in the sequence: [-1, 3, 2], [-1, 3, 0] and [-1, 2, 0].

 
 */

let ex1_456 = [1, 2, 3, 4]
let ex2_456 = [1, 2, 3, 4]
let ex3_456 = [-1, 3, 2, 0]

func find132pattern(_ nums: [Int]) -> Bool {
    return false
}

find132pattern(ex1_456) //false
find132pattern(ex2_456) //true
find132pattern(ex3_456) //true

/*
 
 393. UTF-8 Validation
 Medium

 A character in UTF8 can be from 1 to 4 bytes long, subjected to the following rules:

 For 1-byte character, the first bit is a 0, followed by its unicode code.
 For n-bytes character, the first n-bits are all one's, the n+1 bit is 0, followed by n-1 bytes with most significant 2 bits being 10.
 This is how the UTF-8 encoding would work:

    Char. number range  |        UTF-8 octet sequence
       (hexadecimal)    |              (binary)
    --------------------+---------------------------------------------
    0000 0000-0000 007F | 0xxxxxxx
    0000 0080-0000 07FF | 110xxxxx 10xxxxxx
    0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
    0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
 Given an array of integers representing the data, return whether it is a valid utf-8 encoding.

 Note:
 The input is an array of integers. Only the least significant 8 bits of each integer is used to store the data. This means each integer represents only 1 byte of data.

 Example 1:

 data = [197, 130, 1], which represents the octet sequence: 11000101 10000010 00000001.

 Return true.
 It is a valid utf-8 encoding for a 2-bytes character followed by a 1-byte character.
 
 Example 2:

 data = [235, 140, 4], which represented the octet sequence: 11101011 10001100 00000100.

 Return false.
 The first 3 bits are all one's and the 4th bit is 0 means it is a 3-bytes character.
 The next byte is a continuation byte which starts with 10 and that's correct.
 But the second continuation byte does not start with 10, so it is invalid.
 
 */

let ex1_393 = [197, 130, 1] //true
let ex2_393 = [235, 140, 4] //false

func validUtf8(_ data: [Int]) -> Bool {
    return false
}

validUtf8(ex1_393) //true
validUtf8(ex2_393) //false
