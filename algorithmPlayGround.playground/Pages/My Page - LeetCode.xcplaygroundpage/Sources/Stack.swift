import Foundation

class Stack<T> {
    fileprivate var array : [T] = [T]()
    
    public func size() -> Int {
        return array.count
    }
    
    public func push(x : T) {
        array.append(x)
    }
    
    public func pop() -> T? {
        return array.popLast()
    }
    
    public func isEmpty() -> Bool {
        return (array.count == 0) ? true : false
    }
}
