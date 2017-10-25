//: [Previous](@previous)

import Foundation

// Singleton Pattern

class Singleton {
    static let sharedInstance = Singleton()
    fileprivate let hash : Int
    private init() {
        self.hash = Int(arc4random())
    }
    func description() -> String{
        return String(self.hash)
    }
}

let s = Singleton.sharedInstance
s.description()

let v = Singleton.sharedInstance
v.description()

// Strategy Pattern

protocol Strategy {
    func doOperation(_ a : Int, _ b : Int) -> Int
}

class OperationAdd : Strategy{
    func doOperation(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

class OperationSubstract : Strategy {
    func doOperation(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
}

class OperationMultipication : Strategy {
    func doOperation(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
}

class StrategyContext {
    fileprivate let starategy : Strategy
    
    init(strategy : Strategy) {
        self.starategy = strategy
    }
    
    func excute(_ a: Int, _ b: Int) -> Int {
        return self.starategy.doOperation(a, b)
    }
}

let newContext = StrategyContext(strategy: OperationAdd())
newContext.excute(1, 1)
let newContext2 = StrategyContext(strategy: OperationMultipication())
newContext2.excute(1, 1)
let newContext3 = StrategyContext(strategy: OperationSubstract())
newContext3.excute(1, 1)

// Factory Pattern

protocol Pizza {
    var topping : [String] { get set }
    func bake()
}

enum PizzaType {
    case italian, chicago, newyork
}

class ItailianPizza : Pizza {
    var topping : [String] = ["thin douch", "cheese"]
    func bake() {
        print("Mamamia!")
    }
}

class ChicagoPizza : Pizza {
    var topping : [String] = ["big dough", "buch of cheese"]
    func bake() {
        print("this is chicago pizza!")
    }
}

class NewyorkPizza : Pizza {
    var topping : [String] = []
    func bake() {
        print("what is newyork pizza?")
    }
}

class PizzaFactory {
    static func createPizza(type: PizzaType) -> Pizza {
        switch type {
        case .italian:
            return ItailianPizza()
        case .chicago:
            return ChicagoPizza()
        case .newyork:
            return NewyorkPizza()
        }
    }
}

let newPizza = PizzaFactory.createPizza(type: .newyork)
newPizza.bake()

