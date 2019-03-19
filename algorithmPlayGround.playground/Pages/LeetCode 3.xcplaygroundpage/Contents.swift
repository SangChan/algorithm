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

let maxDouble : Double = Double.greatestFiniteMagnitude
let thirtyDays : TimeInterval = 60 * 60 * 24 * 30

if maxDouble > thirtyDays {
    print("maxDouble : \(maxDouble)")
} else {
    print("thirthyDays : \(thirtyDays)")
}


public func solution(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var headsCount = 0
    var tailsCount = 0
    
    for face in A {
        if face == 0 {
            headsCount += 1
        }
    }
    
    tailsCount = A.count - headsCount
    
    return (headsCount > tailsCount) ? tailsCount : headsCount
}

var coins = [1,0,0,1,0,0]

solution(&coins)


public func solution2(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var index = 0
    var count = 0
    while (index != -1) {
        index = A[index]
        count += 1
    }
    return count
}

var list = [1,4,-1,3,2]
solution2(&list)


public func solution3(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    func normalize(_ A:[Int]) -> [Int] {
        var normalTerrain = [Int]()
        for height in A {
            if let lastValue = normalTerrain.last {
                if lastValue != height {
                    normalTerrain.append(height)
                }
            } else {
                normalTerrain.append(height)
            }
        }
        return normalTerrain
    }
    
    func isHill(_ left : Int, _ medium : Int, _ right : Int) -> Bool {
        if left < medium && right < medium {
            return true
        }
        return false
    }
    
    func isValley(_ left : Int, _ medium : Int, _ right : Int) -> Bool {
        if left > medium && right > medium {
            return true
        }
        return false
    }
    
    var hillsCount = 0
    var valleysCount = 0
    
    let normalTerrain = normalize(A)
    
    for index in 0 ..< normalTerrain.count {
        var hill : Bool = false
        var valley : Bool = false
        
        var leftValueForHill = -1000000000
        var leftValueForValley = 1000000000
        let mediumValue = normalTerrain[index]
        var rightValueForHill = -1000000000
        var rightValueForValley = 1000000000
        
        if index > 0 && index < normalTerrain.count - 1 {
            leftValueForHill = normalTerrain[index-1]
            leftValueForValley = normalTerrain[index-1]
            rightValueForHill = normalTerrain[index+1]
            rightValueForValley = normalTerrain[index+1]
        }
        
        hill = isHill(leftValueForHill,mediumValue,rightValueForHill)
        valley = isValley(leftValueForValley,normalTerrain[index],rightValueForValley)
        
        if hill == true {
            hillsCount += 1
        }
        if valley == true {
            valleysCount += 1
        }
        if hill == true && valley == true {
            hillsCount -= 1
        }
    }
    
    print(normalTerrain)
    
    return hillsCount + valleysCount
}

var terrainEx1 = [2,2,3,4,3,3,2,2,1,1,2,5]
var terrainEx2 = [-3,-3]

solution3(&terrainEx1)

public func solution4(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    func isAdjacent(_ first : Int, _ second : Int, _ list : [Int]) -> Bool {
        let smallOne = (first < second) ? first : second
        let bigOne = (first < second) ? second : first
        
        for num in list {
            if num > smallOne && num < bigOne {
                return false
            }
        }
        return true
    }
    
    var minimumDistance = Int.max
    var adjacentCount = 0
    
    for p in 0 ..< A.count {
        let firstValue = A[p]
        for q in p+1 ..< A.count {
            let secondValue = A[q]
            if isAdjacent(firstValue, secondValue, A) == true {
                adjacentCount += 1
                if minimumDistance > abs(firstValue - secondValue) {
                    minimumDistance = abs(firstValue - secondValue)
                }
            }
        }
    }
    
    if adjacentCount == 0 {
        return -2
    }
    
    return (minimumDistance > 100000000) ? -1 : minimumDistance
}

var stricyList = [0,3,3,7,5,3,11,1]
solution4(&stricyList)
