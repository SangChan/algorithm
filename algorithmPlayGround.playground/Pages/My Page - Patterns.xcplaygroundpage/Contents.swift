//: [Previous](@previous)

import Foundation

class Singleton {
    static let sharedInstance = Singleton()
    fileprivate let hash : Int
    private init() {
        self.hash = Int(arc4random())
    }
    func description() {
        print("\(self.hash)")
    }
}

//let s = Singleton.sharedInstance
//s.description()

//let v = Singleton.sharedInstance
//v.description()

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
