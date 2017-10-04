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

class SwiftGraph {
    private var canvas : Array<Vertex>
    public var isDirected : Bool
    
    init() {
        canvas = Array<Vertex>()
        isDirected = true
    }
    
    func addVertex(key:String) -> Vertex {
        var childVertex = Vertex(key:key)
        canvas.append(childVertex)
        return childVertex
    }
    
    func addEdge(source:Vertex, neighbor:Vertex, weight:Int) {
        var newEdge = Edge(neighbor:neighbor, weight:weight)
        source.neighbors.append(newEdge)
        
        if isDirected == false {
            var reverseEgde = Edge(neighbor:source, weight: weight)
            neighbor.neighbors.append(reverseEgde)
        }
    }
}
