//: [Previous](@previous)

import Foundation

class QNode<T> {
    var key : T?
    var next : QNode?
}

class Queue<T> {
    var top : QNode<T>! = QNode<T>()
    
    func enQueue(key: T) {
        if top == nil {
            top = QNode<T>()
        }
        
        if top == nil {
            top.key = key
            return
        }
        
        var childToUse : QNode<T> = QNode<T>()
        var current : QNode = top
        
        while current.next != nil {
            current = current.next!
        }
        
        childToUse.key = key
        current.next = childToUse
    }
    
    func deQueue() -> T? {
        let topItem : T? = self.top?.key
        
        if topItem == nil {
            return nil
        }
        
        var queueItem : T? = top.key!
        
        if let nextItem = top.next {
            top = nextItem
        } else {
            top = nil
        }
        
        return queueItem
    }
    
    func isEmpty() -> Bool {
        if let topItem : T = self.top?.key {
            return false
        } else {
            return true
        }
    }
    
    func peek() -> T? {
        return top.key!
    }
}
