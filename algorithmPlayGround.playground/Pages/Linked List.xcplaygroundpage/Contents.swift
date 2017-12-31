//: [Previous](@previous)

import Foundation

class LLNode<T> {
    var key : T?
    var next: LLNode?
    var previos: LLNode?
}

struct Student {
    var name : String
    var id : String
    var grade : String
}

struct Teacher {
    var name : String
    var id : String
    var major : String
}

class StudentNode {
    var key : Student?
    var next : StudentNode?
}

class TeacherNode {
    var key : Teacher?
    var next : TeacherNode?
}

class LinkedList<T:Equatable, Comparable> {
    private var head : LLNode<T> = LLNode<T>()
    var count: Int {
        if head.key == nil {
            return 0
        } else {
            var current : LLNode! = head
            var x: Int = 1
            
            while current.next != nil {
                current = current.next
                x += 1
            }
            return x
        }
    }
    
    func printAllkeys() {
        var current: LLNode! = head
        while current != nil {
            //print("current = \(current!.key)")
            current = current!.next
        }
    }
    
    func addLink(key: T) {
        if head.key == nil {
            head.key = key
            return
        }
        var current : LLNode? = head
        while current != nil {
            var childToUse : LLNode = LLNode<T>()
            childToUse.key = key
            childToUse.previos = current
            current!.next = childToUse
            break
        }
        current = current?.next
    }
    
    func removeLinkAtIndex(index : Int) {
        var current : LLNode<T>? = head
        var trailer : LLNode<T>?
        var listIndex : Int = 0
        
        if index == 0 {
            current = current?.next
            head = current!
            return
        }
        
        while current != nil {
            if listIndex == index {
                trailer!.next = current?.next
                current = nil
                break
            }
            
            trailer = current
            current = current?.next
            listIndex += 1
        }
        
    }
}

var studentList = LLNode<Student>()
var teacherList = LLNode<Teacher>()
