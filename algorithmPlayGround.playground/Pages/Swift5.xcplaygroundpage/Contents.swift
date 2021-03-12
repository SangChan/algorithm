import Foundation

var str : String = "Hello, playground"

print(str)

str += "!!!"

print(str)

protocol IStack<T> {
    func pop() -> T
    func push(_ x: T)
}

class Stack<Int> {
    var arr : [Int] = []
    
    func pop() -> Int {
        
    }
}
