import UIKit

struct Pessenger {
    let id : Int
    let floor : Int
    let weight : Int
}

class Stack {
    fileprivate var array : [Pessenger] = [Pessenger]()
    
    public func size() -> Int {
        return array.count
    }
    
    public func totalWeight() -> Int {
        var total = 0
        for pessenger in array {
            total += pessenger.weight
        }
        return total
    }
    
    public func push(x : Pessenger) {
        array.append(x)
    }
    
    public func pop() -> Pessenger? {
        return array.popLast()
    }
    
    public func isEmpty() -> Bool {
        return (array.count == 0) ? true : false
    }
}

public func solution(_ A : inout [Int], _ B : inout [Int], _ M : Int, _ X : Int, _ Y : Int) -> Int {
    var stops = 0
    var stack = Stack()
    
    func popUntilDone() -> Int {
        var setForFloor = Set<Int>()
        while stack.totalWeight() > 0 {
            if let pessengerInfo = stack.pop() {
                print("pop: \(pessengerInfo)")
                setForFloor.insert(pessengerInfo.floor)
            }
        }
        setForFloor.insert(1)
        return setForFloor.count
    }
    
    for index in 0 ..< A.count {
        let pessenger = Pessenger(id: index, floor: B[index], weight: A[index])
        if stack.size() + 1 > X  || stack.totalWeight() + pessenger.weight > Y {
            stops += popUntilDone()
        }
        print("push : \(pessenger)")
        stack.push(x:pessenger)
    }
    
    stops += popUntilDone()
    
    
    
    return stops
}

var groupWeight = [60,80,40]//[40,40,100,80,20]
var groupFloor = [2,3,5]//[3,3,2,2,3]
print(solution(&groupWeight, &groupFloor, 5, 2, 200))
