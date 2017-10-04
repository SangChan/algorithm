//: [Previous](@previous)

import Foundation

class HashNode {
    var firstName : String!
    var lastName : String!
    var next : HashNode!
}

class HashTable {
    private var buckets : Array<HashNode>!
    
    init() {
        
    }
    
    convenience init(capacity : Int) {
        self.init()
        self.buckets = Array<HashNode!>(repeating:nil, count: capacity)
    }
    
    func addWord(firstName : String, lastName : String) {
        var fullName : String = firstName + lastName
        var hashIndex : Int = self.createHash(fullName)
        
        var childToUse : HashNode = HashNode()
        var head : HashNode!
        
        childToUse.firstName = firstName
        childToUse.lastName = lastName
        
        if buckets[hashIndex] == nil {
            buckets[hashIndex] = childToUse
        } else {
            head = buckets[hashIndex]
            
            childToUse.next = head
            head = childToUse
            
            buckets[hashIndex] = head
        }
    }
    
    func createHash(_ fullName : String) -> Int {
        var remainder : Int = 0
        var divisor : Int = 0
        
        for key in fullName.unicodeScalars {
            divisor += Int(key.value)
        }
        
        remainder = divisor % buckets.count
        return remainder
    }
}
