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
    return ""
    /*
     sort by row
     if (numRows == 1) return s;
     
     List<StringBuilder> rows = new ArrayList<>();
     for (int i = 0; i < Math.min(numRows, s.length()); i++)
     rows.add(new StringBuilder());
     
     int curRow = 0;
     boolean goingDown = false;
     
     for (char c : s.toCharArray()) {
     rows.get(curRow).append(c);
     if (curRow == 0 || curRow == numRows - 1) goingDown = !goingDown;
     curRow += goingDown ? 1 : -1;
     }
     
     StringBuilder ret = new StringBuilder();
     for (StringBuilder row : rows) ret.append(row);
     return ret.toString();
     */
}
