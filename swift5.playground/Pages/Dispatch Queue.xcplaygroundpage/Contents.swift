//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let semaphore : DispatchSemaphore = DispatchSemaphore(value:1)
for i in 1...40 {
    DispatchQueue.global().async{
        semaphore.wait()
        print("1-\(i)")
        semaphore.signal()
    }
}

let dispatchQueue = DispatchQueue(label: "testQueue")


dispatchQueue.async {
    var sum = 0
    
    for i in 1...10000 {
        sum += i
    }
    
    print("sum: \(sum)")
    
}

DispatchQueue.global(qos: .background).async {
    for i in 1 ... 100 {
        print("async background = \(i)")
    }
}

DispatchQueue.global(qos: .default).async {
    for i in 1 ... 100 {
        print("async default = \(i)")
    }
}

DispatchQueue.global(qos: .unspecified).async {
    for i in 1 ... 100 {
        print("async unspecified = \(i)")
    }
}

DispatchQueue.global(qos: .userInitiated).async {
    for i in 1 ... 100 {
        print("async userInitiated = \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).async {
    for i in 1 ... 100 {
        print("async userInteractive = \(i)")
    }
}

DispatchQueue.global(qos: .utility).async {
    for i in 1 ... 100 {
        print("async utility = \(i)")
    }
}


DispatchQueue.global(qos: .background).async {
    for i in 1 ... 100 {
        print("background = \(i)")
    }
}

DispatchQueue.global(qos: .default).sync {
    for i in 1 ... 100 {
        print("sync default = \(i)")
    }
}

DispatchQueue.global(qos: .unspecified).sync {
    for i in 1 ... 100 {
        print("sync unspecified = \(i)")
    }
}

DispatchQueue.global(qos: .userInitiated).sync {
    for i in 1 ... 100 {
        print("sync userInitiated = \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).sync {
    for i in 1 ... 100 {
        print("sync userInteractive = \(i)")
    }
}

DispatchQueue.global(qos: .utility).sync {
    for i in 1 ... 100 {
        print("sync utility = \(i)")
    }
}

PlaygroundPage.current.finishExecution()
