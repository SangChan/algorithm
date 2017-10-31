import Foundation

// 1. Two Sum

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

func sum2(a: [Int], sum: Int) -> Bool {
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

func sum3(a: [Int], sum: Int) -> Bool {
    var index = 0
    for i in a {
        let withA = sum - i
        if let withAIndex = a.index(of: withA), withAIndex != index {
            return true
        }
        index += 1
    }
    return false
}

sum3(a: list, sum: 10)

// 657. Judge Route Circle

var isCircle = "UD" //return true
var isNotCircle = "LL" // return false

enum Moves {
    case up
    case down
    case left
    case right
    case none
}

struct Position {
    var x = 0
    var y = 0
}

struct Robot {
    var postion = Position(x: 0, y: 0)
    
    mutating func add(newPosition : Position) {
        self.postion.x += newPosition.x
        self.postion.y += newPosition.y
    }
}

func moves(fromChar : Character) -> Moves {
    let string = String(fromChar).lowercased()
    switch string {
    case "u":
        return .up
    case "d" :
        return .down
    case "l" :
        return .left
    case "r" :
        return .right
    default :
        return .none
    }
}

func position(fromMoves : Moves) -> Position {
    switch fromMoves {
    case .up:
        return Position(x: 0, y: 1)
    case .down:
        return Position(x: 0, y: -1)
    case .left:
        return Position(x: -1, y: 0)
    case .right:
        return Position(x: 1, y: 0)
    default :
        return Position(x: 0, y: 0)
    }
}

func judgeCircle(_ routes : String) -> Bool{
    var robot = Robot()
    let initialPosition = robot.postion
    for m in routes {
        robot.add(newPosition: position(fromMoves: moves(fromChar: m)))
    }
    if initialPosition.x == robot.postion.x && initialPosition.y == robot.postion.y {
        return true
    }
    return false
}

judgeCircle(isCircle)
judgeCircle(isNotCircle)

// 7. Reverse Integer

var reverseEx1 = 123 //should be 321
var reverseEx2 = -123 // shold be -321

func reverse(x : Int) -> Int {
    let isMinus : Bool = (x < 0) ? true : false
    let strX = String(abs(x))
    var reverseStrX : String = ""
    for i in strX.reversed() {
        reverseStrX.append(i)
    }
    let reverseX : Int = Int(reverseStrX) ?? 0
    return (isMinus) ? reverseX * -1 : reverseX
}

func reverse2(x : Int) -> Int {
    var inputX : Int = x
    var reverseX : Int = 0
    
    while inputX != 0 {
        reverseX *= 10
        reverseX += inputX % 10
        inputX /= 10
    }
    
    if reverseX > Int.max || reverseX < Int.min {
        return 0
    }
    
    return reverseX
}

reverse(x: reverseEx1)
reverse(x: reverseEx2)

reverse2(x: reverseEx1)
reverse2(x: reverseEx2)

// 9. Palindrome Number

func isPalindrome(x : Int) -> Bool {
    let reverseX = reverse2(x: x)
    if reverseX == x {
        return true
    }
    return false
}

var palindromeEx1 = 121
var palindromeEx2 = 432

isPalindrome(x: palindromeEx1)
isPalindrome(x: palindromeEx2)
