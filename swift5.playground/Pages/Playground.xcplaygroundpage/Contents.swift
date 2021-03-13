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

func pow(num: Int64, power: Int) -> Int64 {
    var newNum : Int64 = 1
    for _ in 0 ..< power {
        newNum *= num
    }
    return newNum
}

func solution1(_ n:Int64) -> Int64 {
    func pow(num: Int64, power: Int) -> Int64 {
        var newNum : Int64 = 1
        for _ in 0 ..< power {
            newNum *= num
        }
        return newNum
    }
    
    var n : Int64 = n
    var arr : [Int64] = []
    
    repeat {
        let i : Int64 = n % 10
        arr.append(i)
        n /= 10
    } while n > 10
    arr.append(n)
    
    arr = arr.sorted { (i, j) -> Bool in
        return i < j
    }
    
    print(arr)
    
    var newNum : Int64 = 0
    var loopCount : Int = 0
    
    arr.forEach { (num) in
        let powNum : Int64 = pow(num: 10, power: loopCount)
        print(powNum)
        newNum += Int64(num * powNum)
        loopCount += 1
    }
    
    return newNum
}

solution1(118372)

func solution2(_ n: Int64) -> Int64 {
    let stringN = String(n)
    return Int64(String(stringN.sorted { (c1, c2) -> Bool in
        c1 > c2
    }))!
}

solution2(118372)

print("10의 0승은 = \(pow(10, 0))")
print("10의 1승은 = \(pow(10, 1))")
print("10의 2승은 = \(pow(10, 2))")
print("10의 3승은 = \(pow(10, 3))")

func primeNumber(_ x: Int) -> Bool {
    guard x >= 2 else { return false }
    guard x != 2     else { return true  }
    guard x % 2 == 1 else { return false }
    
    var canDivideCount : Int = 0
    let limit : Int = Int(sqrt(Double(x)))
    for i in 1 ... limit {
        if x % i == 0 { canDivideCount += 1 }
    }
    
    return (canDivideCount == 1)
}

func anotherPrimeNumber(_ n: Int) -> Bool {
    guard n >= 2     else { return false }
    guard n != 2     else { return true  }
    guard n % 2 != 0 else { return false }
    return !stride(from: 3, through: Int(sqrt(Double(n))), by: 2).contains { n % $0 == 0 }
}


primeNumber(0)
primeNumber(1)
primeNumber(2)
primeNumber(3)
primeNumber(4)
primeNumber(5)
primeNumber(6)
primeNumber(7)
primeNumber(8)
primeNumber(9)


var primeNumberCount = 0
for i in 1 ... 10 {
    if primeNumber(i) == true { primeNumberCount += 1 }
}

func subak(_ x: Int) -> String {
    var result : String = ""
    for i in 0 ..< x {
        if i % 2 == 0 {
            result += "수"
        } else {
            result += "박"
        }
    }
    
    return result
}

print(subak(3))
print(subak(4))

func solution3(_ arr:[Int], _ divisor:Int) -> [Int] {
    var newArr : [Int] = []
    
    arr.forEach { (num) in
        if (num % divisor == 0) { newArr.append(num) }
    }
    
    return newArr.count == 0 ? [-1] : newArr.sorted()
}

solution3([5,9,7,10], 5)
solution3([2,36,1,3], 1)
solution3([3,2,6], 10)

//let n = readLine()!.components(separatedBy: [" "]).map { Int($0)! }
//let (a, b) = (n[0], n[1])

//print(a + b)

func drawStars(_ n: Int, _ m: Int) -> String {
    var stars : String = ""
    for _ in 0 ..< m {
        for _ in 0 ..< n {
            stars += "*"
        }
        stars += "\n"
    }
    
    return stars
}

print(drawStars(5, 3))


func jadenCase(_ s:String) -> String {
    var newString = ""
    let splited: [String] = s.split(separator: " ").map { (str) -> String in
        var idx = 0
        var mergedStr : String = ""

        str.forEach { (char) in
            if idx == 0 {
                mergedStr += char.uppercased()
            } else {
                mergedStr += char.lowercased()
            }
            idx += 1
        }
        return mergedStr
    }
    
    var idx = 0
    splited.forEach { (str) in
        newString += str
        if idx < splited.count - 1 {
            newString += " "
        }
        idx += 1
    }
    
    return newString
}

jadenCase("3people unFollowed me")
jadenCase("for the last week")
jadenCase("f or    the last week ")
jadenCase("asgvb   aaaa    aaa")

func jadenCase2(_ s:String) -> String {
    var newString = ""
    var prevChar : Character? = nil
    s.forEach { (char) in
        if let prev = prevChar {
            if prev == " " {
                newString += char.uppercased()
            } else {
                newString += char.lowercased()
            }
        } else {
            newString += char.uppercased()
        }
        
        prevChar = char
    }
    
    return newString
}

jadenCase2("3people unFollowed me")
jadenCase2("for the last week")
jadenCase2("f or    the last week ")
jadenCase2("asgvb   aaaa    aaa")

enum Language {
    case cpp
    case java
    case python
    case all
    
    static func change(_ str: String) -> Language {
        switch str {
        case "cpp": return .cpp
        case "java": return .java
        case "python": return .python
        default : return .all
        }
    }
}

enum Job {
    case backend
    case frontend
    case all
    
    static func change(_ str: String) -> Job {
        switch str {
        case "backend": return .backend
        case "frontend": return .frontend
        default : return .all
        }
    }
}

enum Period {
    case junior
    case senior
    case all
    
    static func change(_ str: String) -> Period {
        switch str {
        case "junior": return .junior
        case "senior": return .senior
        default : return .all
        }
    }
}

enum Soulfood {
    case chicken
    case pizza
    case all
    
    static func change(_ str: String) -> Soulfood {
        switch str {
        case "chicken": return .chicken
        case "pizza": return .pizza
        default : return .all
        }
    }

}

struct User {
    let language : Language
    let job : Job
    let period : Period
    let soulfood : Soulfood
    let score : Int
}

struct UserQuery {
    let language : Language
    let job : Job
    let period : Period
    let soulfood : Soulfood
    let score : Int
}


func solutionKakao(_ info:[String], _ query:[String]) -> [Int] {
    var filterResult : [Int] = []
    var user : [User] = []
    info.forEach { (str) in
        let userInfo: [String] = str.split(separator: " ").map { String($0) }
        user.append(User(language: Language.change(userInfo[0]) , job: Job.change(userInfo[1]), period: Period.change(userInfo[2]), soulfood: Soulfood.change(userInfo[3]), score: Int(userInfo[4])!))
    }

    var userQuery : [UserQuery] = []
    query.forEach { (str) in
        let queryArr: [String] = str.split(separator: " ").map { String($0) }
        userQuery.append(UserQuery(
                            language: Language.change(queryArr[0]),
                            job: Job.change(queryArr[2]),
                            period: Period.change(queryArr[4]),
                            soulfood: Soulfood.change(queryArr[6]),
                            score: Int(queryArr[7])!))
    }

    filterResult = userQuery.map { (userQuery) -> Int in
        return user.filter { (user) -> Bool in
            let newQuery = UserQuery(
                language: userQuery.language == .all ? user.language : userQuery.language,
                job: userQuery.job == .all ? user.job : userQuery.job ,
                period: userQuery.period == .all ? user.period : userQuery.period,
                soulfood: userQuery.soulfood == .all ? user.soulfood : userQuery.soulfood,
                score: userQuery.score
            )
            
            return (user.language == newQuery.language) &&
                (user.job == newQuery.job) &&
                (user.period == newQuery.period) &&
                (user.soulfood == newQuery.soulfood) &&
                (user.score >= newQuery.score)
        }.count
    }
    
    return filterResult
}

solutionKakao(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"])

func findKim(_ seoul: [String]) -> String {
    let idx = seoul.firstIndex { $0 == "Kim" }
    return "김서방은 \(idx!)에 있다"
}

findKim(["Jane", "Kim"])

func greedy(_ n: Int, _ lost: [Int], _ reserve: [Int]) -> Int {
    var rentCount = 0
    var newLost = lost
    var newReserve = reserve
    
    reserve.forEach { (studentNo) in
        if let idx = newLost.firstIndex(where: { $0 == studentNo }) {
            newLost.remove(at: idx)
            if let idx = newReserve.firstIndex(where: { $0 == studentNo }) {
                newReserve.remove(at: idx)
            }
        }
        
    }
    
    newLost.forEach { (studentNo) in
        for i in studentNo - 1 ... studentNo + 1 {
            if let idx = newReserve.firstIndex(where: { $0 == i }) {
                newReserve.remove(at: idx)
                rentCount += 1
                break
            }
        }
    }
    
    return n - newLost.count + rentCount
}

greedy(5, [2,4], [1,3,5])
greedy(5, [2,4], [3])
greedy(3, [3], [1])
greedy(3, [3], [1,3])
greedy(10, [5, 7, 9], [1, 2, 3, 4, 5, 8])
