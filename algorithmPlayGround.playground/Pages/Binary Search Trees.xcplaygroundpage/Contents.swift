//: [Previous](@previous)

import Foundation

class AVLTree<T: Comparable> {
    var key : T!
    var left : AVLTree?
    var right : AVLTree?
    
    lazy var height : Int = {
        var nodeHeight = 0
        nodeHeight = max(getNodeHeight(aNode: self.left), getNodeHeight(aNode: self.right)) + 1
        return nodeHeight
    }()
    
    func addNode(key: T) {
        if self.key == nil {
            self.key = key
            return
        }
        
        guard let selfKey = self.key else { return }
        
        if key < selfKey {
            if self.left != nil {
                left!.addNode(key: key)
            } else {
                let leftChild = AVLTree<T>()
                leftChild.key = key
                self.left = leftChild
            }
        } else if key > selfKey {
            if self.right != nil {
                right!.addNode(key: key)
            } else {
                let rightChild = AVLTree<T>()
                rightChild.key = key
                self.right = rightChild
            }
        }
    }
    
    func getNodeHeight(aNode : AVLTree!) -> Int {
        if aNode == nil {
            return 0
        }
        return height
    }
    
    func isTreeBalanced() -> Bool {
        guard self.key != nil else { return false }
        
        if abs(getNodeHeight(aNode: self.left) - getNodeHeight(aNode: self.right)) <= 1 {
            return true
        } else {
            return false
        }
    }
    
}

let numberList : Array<Int> = [8,2,10,9,11,1,7]

var root = AVLTree<Int>()

for number in numberList {
    root.addNode(key: number)
}

