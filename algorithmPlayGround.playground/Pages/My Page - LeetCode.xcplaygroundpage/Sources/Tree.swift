import Foundation

class Tree<T> {
    var x : T!
    var left : Tree?
    var right : Tree?
    
    init() {
        self.x = nil
        self.left = nil
        self.right = nil
    }
    
    convenience init(x : T) {
        self.init()
        self.x = x
    }
    
    convenience init(x : T, left : Tree, right : Tree) {
        self.init()
        self.x = x
        self.left = left
        self.right = right
    }
    
    func inOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        inOrder(tree: treeForUse.left)
        // process tree.value
        inOrder(tree: treeForUse.right)
    }
    
    func inOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let stack = Stack<Tree>()
        var currentTree : Tree? = treeForUse
        while currentTree != nil || stack.isEmpty() == false {
            while currentTree != nil {
                stack.push(x: currentTree!)
                currentTree = currentTree!.left
            }
            
            currentTree = stack.pop()
            // process tree.value
            currentTree = currentTree!.right
        }
    }
    
    func preOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        // process tree.value
        preOrder(tree: treeForUse.left)
        preOrder(tree: treeForUse.right)
    }
    
    func preOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let stack = Stack<Tree>()
        stack.push(x: treeForUse)
        while stack.isEmpty() == false {
            if let currentTree = stack.pop() {
                
                // process tree.value
                if let right = currentTree.right {
                    stack.push(x: right)
                }
                if let left = currentTree.left {
                    stack.push(x: left)
                }
            }
        }
    }
    
    func postOrder(tree : Tree?) {
        guard let treeForUse = tree else { return }
        postOrder(tree: treeForUse.left)
        postOrder(tree: treeForUse.right)
        // process tree.value
    }
    
    func postOrder2(tree : Tree?) {
        guard let treeForUse = tree else { return }
        let tmpStack = Stack<Tree>()
        let allStack = Stack<Tree>()
        tmpStack.push(x: treeForUse)
        while tmpStack.isEmpty() == false {
            if let currentTree = tmpStack.pop() {
                allStack.push(x: currentTree)
                if let right = currentTree.right {
                    tmpStack.push(x: right)
                }
                if let left = currentTree.left {
                    tmpStack.push(x: left)
                }
            }
        }
        
        while allStack.isEmpty() == false {
            if let currentTree = allStack.pop() {
                // process tree.value
                print(currentTree.x)
            }
        }
    }
}
