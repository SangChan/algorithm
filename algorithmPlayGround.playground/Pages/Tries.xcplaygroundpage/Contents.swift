//: [Previous](@previous)

import Foundation

class TrieNode {
    var key : String!
    var children : Array<TrieNode>
    var isFinal : Bool
    var level : Int
    
    init() {
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }
}

class Trie {
    private var root : TrieNode!
    
    init() {
        root = TrieNode()
    }
    
    func addWord(keyWord : String) {
        guard keyWord.lengthOfBytes(using: .utf8) != 0 else { return }
        var current : TrieNode = root
        var searchKey : String!
        
        while keyWord.lengthOfBytes(using: .utf8) != current.level {
            var childToUse : TrieNode!
            var searchKey = keyWord.substring(to: keyWord.index(keyWord.startIndex, offsetBy: current.level + 1))
            
            for child in current.children {
                if child.key == searchKey {
                    childToUse = child
                    break
                }
            }
            
            if childToUse == nil {
                childToUse = TrieNode()
                childToUse.key = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
            }
            
            current = childToUse
        }
        
        if keyWord.lengthOfBytes(using: .utf8) == current.level {
            current.isFinal = true
            print("end of word reached!")
            return
        }
    }
    
    func findWord(keyWord: String) -> Array<String>? {
        guard keyWord.lengthOfBytes(using: .utf8) != 0 else { return nil }
        
        var current : TrieNode = root
        var searchKey : String!
        var wordList : Array<String>! = Array<String>()
        
        while keyWord.lengthOfBytes(using: .utf8) != current.level {
            var childToUse : TrieNode!
            var searchKey = keyWord.substring(to: keyWord.index(keyWord.startIndex, offsetBy: current.level + 1))
            for child in current.children {
                if child.key == searchKey {
                    childToUse = child
                    current = childToUse
                    break
                }
            }
            
            if childToUse == nil {
                return nil
            }
        }
        
        if current.key == keyWord && current.isFinal == true {
            wordList.append(current.key)
        }
        
        for child in current.children {
            if child.isFinal == true {
                wordList.append(current.key)
            }
        }
        
        return wordList
    }
}
