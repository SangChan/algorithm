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

//solution("pPoooyY")
//solution("Pyy")

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

//solution1(118372)

func solution2(_ n: Int64) -> Int64 {
    let stringN = String(n)
    return Int64(String(stringN.sorted { (c1, c2) -> Bool in
        c1 > c2
    }))!
}

//solution2(118372)
//
//print("10의 0승은 = \(pow(10, 0))")
//print("10의 1승은 = \(pow(10, 1))")
//print("10의 2승은 = \(pow(10, 2))")
//print("10의 3승은 = \(pow(10, 3))")

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


//primeNumber(0)
//primeNumber(1)
//primeNumber(2)
//primeNumber(3)
//primeNumber(4)
//primeNumber(5)
//primeNumber(6)
//primeNumber(7)
//primeNumber(8)
//primeNumber(9)


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

//print(subak(3))
//print(subak(4))

func solution3(_ arr:[Int], _ divisor:Int) -> [Int] {
    var newArr : [Int] = []
    
    arr.forEach { (num) in
        if (num % divisor == 0) { newArr.append(num) }
    }
    
    return newArr.count == 0 ? [-1] : newArr.sorted()
}

//solution3([5,9,7,10], 5)
//solution3([2,36,1,3], 1)
//solution3([3,2,6], 10)

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

//jadenCase("3people unFollowed me")
//jadenCase("for the last week")
//jadenCase("f or    the last week ")
//jadenCase("asgvb   aaaa    aaa")

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

//jadenCase2("3people unFollowed me")
//jadenCase2("for the last week")
//jadenCase2("f or    the last week ")
//jadenCase2("asgvb   aaaa    aaa")

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

//solutionKakao(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"])

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

//greedy(5, [2,4], [1,3,5])
//greedy(5, [2,4], [3])
//greedy(3, [3], [1])
//greedy(3, [3], [1,3])
//greedy(10, [5, 7, 9], [1, 2, 3, 4, 5, 8])

func kthNum(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    return commands.map { (arr) -> Int in
        let startPoint = arr[0]
        let endPoint = arr[1]
        let position = arr[2]
        
        var newArr : [Int] = []
        for i in startPoint ... endPoint {
            newArr.append(array[i-1])
        }
        print(newArr)
        
        return newArr.sorted()[position - 1]
    }
}

//kthNum([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]])

func sumBetween(_ a:Int, _ b:Int) -> Int64 {
    guard a != b else { return Int64(a) }
    let start : Int64 = Int64(min(a,b))
    let end : Int64 = Int64(max(a,b))
    
    var sum : Int64 = 0
    for i in start ... end {
        sum += i
    }
    
    return sum
}

//sumBetween(3, 5)
//sumBetween(3, 3)
//sumBetween(5, 3)
//sumBetween(1, 65535)

func collatz(_ num:Int) -> Int {
    var newNum = num
    var idx = 0
    while newNum != 1 {
        if idx == 500 {
            return -1
        }
        
        if newNum % 2 == 0 {
            newNum = newNum / 2
        } else {
            newNum = (newNum * 3) + 1
        }
        idx += 1
    }
    
    return idx
}

//collatz(6)
//collatz(16)
//collatz(626331)

func innerProduct(_ a:[Int], _ b:[Int]) -> Int {
    var sum : Int = 0
    for i in 0 ..< a.count {
        sum += a[i] * b[i]
    }
    return sum
}

//innerProduct([1,2,3,4], [-3,-1,0,2])
//innerProduct([-1,0,1], [1,0,-1])

func subBeauty(_ sub: String) -> Int64 {
    let chars : [Character] = sub.map { $0 }
    
    var maxValue : Int64 = 0
    for i in 0 ..< sub.count {
        for j in i ..< sub.count {
            if chars[i] != chars[j] { maxValue = max(Int64(abs(j-i)), maxValue) }
        }
    }
    
    return maxValue
}

func beauty(_ s:String) -> Int64 {
    var result: Int64 = 0
    
    for i in 0 ..< s.count {
        for j in i ..< s.count {
            let start = s.index(s.startIndex, offsetBy: i)
            let end = s.index(s.startIndex, offsetBy: j)
            //result += subBeauty(String(s[start ... end]))
            //print(String(s[start ... end]))
        }
    }
    
    //var prefix : [String] = []
    //var suffix : [String] = []
    
    var set : Set<String> = []
    for i in 0 ... s.count {
        set.insert(String(s.prefix(i)))
        set.insert(String(s.suffix(i)))
    }
    print(set)
    
    
    return result
}

//beauty("baby")
//beauty("oo")
//subBeauty("b")
//subBeauty("ba")
//subBeauty("bab")
//subBeauty("baby")
//subBeauty("a")
//subBeauty("ab")
//subBeauty("aby")
//subBeauty("by")
//subBeauty("y")

func rectrect(_ board:[[Int]]) -> Int
{
    var newBoard : [[Int]] = board
    
    var vSum : [Int] = []
    var hSum : [Int] = []
    var vMin : Int = Int.max
    var hMin : Int = Int.max
    
    repeat {
        for i in 0 ..< newBoard.count {
            print(i)
            if vSum.count < newBoard.count {
                vSum.append(0)
            }
            var j = 0
            newBoard[i].forEach { (num) in
                if hSum.count < newBoard[i].count {
                    hSum.append(0)
                }
                vSum[i] += num
                hSum[j] += num
                j += 1
            }
        }
        
        print(vSum)
        print(hSum)
        
        vMin = Int.max
        vSum.forEach { (num) in
            if vMin >= num { vMin = num }
        }
        
        hMin = Int.max
        hSum.forEach { (num) in
            if hMin >= num { hMin = num }
        }
        
        print("\(vMin) , \(hMin)")
        
        if vMin < hMin {
            if let index = vSum.firstIndex(of: vMin) {
                newBoard.remove(at: index)
            }
        } else {
            if let index = hSum.firstIndex(of: hMin) {
                newBoard = newBoard.map { (arr) -> [Int] in
                    var newArr = arr
                    newArr.remove(at: index)
                    return newArr
                }
            }
        }
        
        //print(newBoard)
        
        vSum.removeAll()
        hSum.removeAll()
    } while vMin != hMin
    
    return vMin * hMin
}

//rectrect([[0,1,1,1],[1,1,1,1],[1,1,1,1],[0,0,1,0]]) // 9
//rectrect([[0,0,1,1],[1,1,1,1]]) // 4


var a1 = [1,2,3,4,5]

let reduced = a1.reduce(0) { (r, num) -> Int in
    r+num
}

print(reduced)

func demo(_ v: [[Int]]) -> [Int]
{
    var ans = [Int]()
    
    var xDic : [Int: Int] = [:]
    var yDic : [Int: Int] = [:]
    
    v.forEach { (position) in
        let x = position[0]
        let y = position[1]
        
        if let xValue = xDic[x] {
            xDic[x] = xValue + 1
        } else {
            xDic[x] = 1
        }
        
        if let yvalue = yDic[y] {
            yDic[y] = yvalue + 1
        } else {
            yDic[y] = 1
        }
    }
    
    xDic.keys.forEach { (key) in
        if let value = xDic[key], value < 2 {
            ans.append(key)
        }
    }
    
    yDic.keys.forEach { (key) in
        if let value = yDic[key], value < 2 {
            ans.append(key)
        }
    }
    
    return ans
}

//demo([[1, 4], [3, 4], [3, 10]])
//demo([[1, 1], [2, 2], [1, 2]])


func streak(_ win_lose:[Int]) -> Int{
    var streaks : [Int] = []
    var streakCount = 0
    
    for i in 0 ..< win_lose.count {
        if win_lose[i] == 1 {
            streakCount += 1
        } else {
            streaks.append(streakCount)
            streakCount = 0
        }
        
        if i == win_lose.count - 1 {
            streaks.append(streakCount)
            streakCount = 0
        }
        
    }
    
    var maximum : Int = 0
    streaks.forEach { (streak) in
        if streak > maximum { maximum = streak }
    }
    
    print(streaks)
    return maximum
}

//streak([1, 0, 1, 0]) // 1
//streak([0, 1, 0, 1, 1, 1, 0, 1, 1]) // 3
//streak([0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1]) // 3

func stringify(_ s:String) -> String{
    let lowerCasedS : String = s.lowercased()
    
    var dic: [Character: Int] = [:]
    
    lowerCasedS.forEach { (char) in
        if let value = dic[char] {
            dic[char] = value + 1
        } else {
            dic[char] = 1
        }
    }
    
    var maximum : Int = 0
    dic.keys.forEach { (key) in
        if let value = dic[key], value >= maximum {
            maximum = value
        }
    }
    
    let answer : [String] = dic.filter { (dic) -> Bool in
        dic.value == maximum
    }.map { (character, _) -> String in
        return String(character)
    }.sorted()
    
    return answer.joined()
}

//stringify("aAb") // a
//stringify("BA")  // ab
//stringify("BbA") // b

func redrawFence(_ fence:[Int]) -> Int {
    
    var startWithWhite = 0
    var startWithBlack = 0
    var i = 0
    fence.forEach { (tile) in
        if tile == i % 2 {
            startWithWhite += 1
        } else {
            startWithBlack += 1
        }
        i += 1
    }
    
    return min(startWithWhite, startWithBlack)
}

//redrawFence([0,1,1,0,0])
//redrawFence([1,1])


struct MagicMissile {
    let power : Int
    let radius : Int
    
    var fullRect : [[Int]] {
        var rect : [[Int]] = []
        for _ in 0 ..< radius {
            rect.append([Int].init(repeating: power, count: radius))
        }
        
        for i in 0 ..< radius {
            for j in 0 ..< radius {
                let positionZero = radius / 2
                let x = (j >= positionZero) ? (j - positionZero) + 1 : j - positionZero
                let y = (i >= positionZero) ? (i - positionZero) + 1 : i - positionZero
                let distance = abs(x) + abs(y)
                if distance >  positionZero + 1 { rect[j][i] = 0 }
                else if distance == positionZero + 1 { rect[j][i] /= 2 }
            }
        }
        
        return rect
    }
}

func magic(_ maps:[[Int]], _ p:Int, _ r:Int) -> Int {
    let magicMissile : MagicMissile = MagicMissile(
        power: p,
        radius: r
    )
    
    let missileRect = magicMissile.fullRect

    func process(_ x: Int, _ y: Int) -> Int {
        var killingCount = 0
        for i in 0 ..< missileRect.count {
            for j in 0 ..< missileRect.count {
                if x + j >= 0 && y + i >= 0 && x + j < maps.count && y + i < maps.count {
                    if maps[y+i][x+j] <= missileRect[j][i] {
                        killingCount += 1
                    }
                }
            }
        }
        
        return killingCount
    }
    
    var maximum : Int = 0
    for i in -r ..< maps.count + r {
        for j in -r ..< maps.count + r {
            let processdKillingCount = process(j, i)
            print(processdKillingCount)
            if processdKillingCount >= maximum {
                maximum = processdKillingCount
            }
        }
    }

    return maximum
}

//let missile = MagicMissile(power: 19, radius: 6)
//print(missile.fullRect)

magic([[1, 28, 41, 22, 25, 79, 4], [39, 20, 10, 17, 19, 18, 8], [21, 4, 13, 12, 9, 29, 19], [58, 1, 20, 5, 8, 16, 9], [5, 6, 15, 2, 39, 8, 29],[39, 7, 17, 5, 4, 49, 5], [74, 46, 8, 11, 25, 2, 11]], 19, 6) // 17

magic([[47, 8, 99, 9, 85, 3, 8], [90, 93, 8, 25, 98, 15, 97], [9, 95, 91, 87, 8, 81, 9], [98, 88, 82, 89, 79, 81, 97], [97, 35, 31, 97, 81, 2, 92], [32, 16, 49, 9, 91, 89, 17], [53, 6, 35, 12, 13, 98, 5]], 78, 6) // 11
magic([[9, 8, 17, 55, 19, 7], [1, 25, 5, 39, 28, 8], [88, 19, 28, 3, 2, 9], [76, 73, 7, 18, 16, 14], [99, 8, 8, 7, 11, 9], [1, 18, 4, 10, 3, 6]], 16, 4)
magic([[6, 3, 2, 7, 3], [7, 2, 1, 6, 8], [8, 9, 8, 4, 9], [7, 9, 2, 7, 1], [6, 3, 6, 8, 4]], 5, 2)
