//: [Previous](@previous)

import Foundation

var list = [1,2,3,5,8,2,3,4,5]

func sum(a: [Int], sum: Int) -> Bool {
    var index = 0
    for i in a {
        for j in index ..< a.count {
            if i + j == sum {
                return true
            }
        }
        index += 1
    }
    return false
}

sum(a: list, sum: 10)

func sum2(a : [Int], sum: Int) -> Bool {
    var dic : [Int : Int] = [:]
    for i in a {
        dic[i] = sum - i
    }
    
    for i in dic.keys {
        if let withA = dic[i], let _ = a.index(of: withA) {
            return true
        }
    }
    return false
}

sum2(a: list, sum: 10)
