import Foundation

class ListNode {
    var value : Int?
    var next : ListNode?
}

class LinkedList {
    private var head : ListNode?
    private var tail: ListNode? {
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    func addLink(value: Int) {
        let newNode : ListNode = ListNode()
        newNode.value = value
        if let lastNode = tail {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    func printAllkeys() {
        guard let firstNode = head else { return }
        printNode(firstNode)
    }
    
    fileprivate func printNode(_ node : ListNode) {
        if let value = node.value {
            print("value = \(value)")
        }
        
        if let next = node.next {
            printNode(next)
        }
    }
}
