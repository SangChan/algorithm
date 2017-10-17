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
