import Foundation

class Queue<T> {
    fileprivate var array : [T] = [T]()
    
    func size() -> Int {
        return array.count
    }
    
    func enqueue(x : T) {
        array.append(x)
    }
    
    func dequeue() -> T? {
        guard array.isEmpty == false else { return nil }
        return array.removeFirst()
    }
}
