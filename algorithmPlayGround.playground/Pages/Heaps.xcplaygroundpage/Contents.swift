//: [Previous](@previous)

import Foundation

class Vertex {
    var key : String?
    var neighbors : Array<Edge>
    
    init() {
        neighbors = Array<Edge>()
    }
    
    convenience init(key : String) {
        self.init()
        self.key = key
    }
}

class Edge {
    var neighbor : Vertex
    var weight : Int
    init() {
        weight = 0
        neighbor = Vertex()
    }
    
    convenience init(neighbor: Vertex, weight: Int) {
        self.init()
        self.weight = weight
        self.neighbor = neighbor
    }
}

class Path {
    var total : Int!
    var destination : Vertex
    var previous : Path!
    
    init() {
        destination = Vertex()
    }
}

class PathHeap {
    private var heap : Array<Path>
    
    var count : Int {
        return self.heap.count
    }
    
    init() {
        heap = Array()
    }
    
    func enQueue(key:Path) {
        heap.append(key)
        
        var childIndex : Float = Float(heap.count) - 1
        var parentIndex : Int! = 0
        
        if childIndex != 0 {
            parentIndex = Int(floorf((childIndex - 1)/2))
        }
        
        while childIndex != 0 {
            var childToUse : Path = heap[Int(childIndex)]
            var parentToUse : Path = heap[parentIndex]
            
            if childToUse.total < parentToUse.total {
                heap.insert(childToUse, at: parentIndex)
                heap.remove(at: Int(childIndex) + 1)
                
                heap.insert(parentToUse, at: Int(childIndex))
                heap.remove(at:parentIndex+1)
            }
            
            childIndex = Float(parentIndex)
            
            if childIndex != 0 {
                parentIndex = Int(floorf((childIndex - 1)/2))
            }
        }
    }
    
    func peek() -> Path! {
        if heap.count > 0 {
            var shotestPath : Path = heap[0]
            return shotestPath
        } else {
            return nil
        }
    }
}

func processDijkstraWithHeap(source: Vertex, destination: Vertex) -> Path! {
    var frontier : PathHeap = PathHeap()
    var finalPath : PathHeap = PathHeap()
    
    for e in source.neighbors {
        let newPath = Path()
        newPath.destination = e.neighbor
        newPath.previous = nil
        newPath.total = e.weight
        
        frontier.enQueue(key: newPath)
    }
    
    var bestPath : Path
    
    while frontier.count != 0 {
        bestPath = Path()
        bestPath = frontier.peek()
        
        for e in bestPath.destination.neighbors {
            let newPath = Path()
            newPath.destination = e.neighbor
            newPath.previous = bestPath
            newPath.total = bestPath.total + e.weight
            
            frontier.enQueue(key: newPath)
        }
        
        if bestPath.destination.key == destination.key {
            finalPath.enQueue(key: bestPath)
        }
        
        //frontier.deQueue()
    }
    
    var shotestPath = finalPath.peek()
    return shotestPath
}
