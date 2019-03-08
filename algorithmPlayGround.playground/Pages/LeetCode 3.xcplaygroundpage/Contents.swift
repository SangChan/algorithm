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
//print(solution(&groupWeight, &groupFloor, 5, 2, 200))

/*
 배열 A는 N개의 정수값을 가지고 있다.(N>0)
 배열의 숫자들이 연속적인 숫자들로 구성되어 있으면 Permutation이라고 할때
 배열 A가 Permutation이 맞으면 1, 아니면 0를 리턴하세요.
 (단 정렬을 하지 않고 구하세요.)
 
 <예1>
 A[0] = 4, A[1] = 1, A[2] = 3, A[3] = 2 : 1, 2, 3, 4 로 Permutation이 맞으므로 리턴 1
 
 A[0] = 4, A[1] = 1, A[2] = 3 : 1, 3, 4로 Permutaiton이 아니므로 리턴 0
 */

let A = [4,1,3,2]
let B = [4,1,3]
let C = [4,1,1,2]

func checkPermutation(_ list : [Int]) -> Int {
    func findDuplicates(_ list : [Int]) -> [Int] {
        var duplicates = Set<Int>()
        
        for num in list {
            duplicates.insert(num)
        }
        
        return Array(duplicates)
    }
    
    var minValue = list[0]
    var maxValue = list[0]
    for num in list {
        if maxValue <= num {
            maxValue = num
        }
        if minValue >= num {
            minValue = num
        }
    }
    
    let removeDuplcatesList = findDuplicates(list)
    
    if (maxValue - minValue + 1) == list.count && removeDuplcatesList.count == list.count {
        return 1
    }
    
    return 0
}

checkPermutation(A)
checkPermutation(B)
checkPermutation(C)
