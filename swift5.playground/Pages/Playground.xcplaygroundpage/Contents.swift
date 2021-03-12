import Foundation

protocol IStack {
    associatedtype T
    var count : Int { get }
    func pop() -> T?
    func push(_ x: T)
}

class IntStack : IStack {
    typealias T = Int
    
    var arr : [T] = []
    var count : Int {
        return arr.count
    }
    
    func pop() -> T? {
        return arr.popLast()
    }
    func push(_ x: T) {
        arr.append(x)
    }
}

var stack = IntStack()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()


func solution(_ s:String) -> Bool
{
    let lowerS : String = s.lowercased()
    return lowerS.filter { $0 == "p"}.count == lowerS.filter { $0 == "y" }.count
}

solution("pPoooyY")
solution("Pyy")
