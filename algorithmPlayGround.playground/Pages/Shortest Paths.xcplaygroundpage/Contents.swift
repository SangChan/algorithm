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

func processDijkstra(source: Vertex, destination: Vertex) -> Path? {
    var frontier: Array<Path> = Array()
    var finalPaths : Array<Path> = Array()
    
    for e in source.neighbors {
        let newPath : Path = Path()
        newPath.destination = e.neighbor
        newPath.previous = nil
        newPath.total = e.weight
        
        frontier.append(newPath)
    }
    
    var bestPath : Path
    
    while frontier.count != 0 {
        bestPath = Path()
        
        var pathIndex : Int = 0
        
        for x in 0 ..< frontier.count {
            let itemPath : Path = frontier[x]
            if bestPath.total == nil || itemPath.total < bestPath.total {
                bestPath = itemPath
                pathIndex = x
            }
        }
        
        for e in bestPath.destination.neighbors {
            let newPath : Path = Path()
            
            newPath.destination = e.neighbor
            newPath.previous = bestPath
            newPath.total = bestPath.total + e.weight
            
            frontier.append(newPath)
        }
        
        finalPaths.append(bestPath)
        
        frontier.remove(at: pathIndex)
    }
    
    var shotestPath : Path! = Path()
    
    for itemPath in finalPaths {
        if itemPath.destination.key == destination.key {
            if shotestPath.total == nil || itemPath.total < shotestPath.total {
                shotestPath = itemPath
            }
        }
    }
    
    return shotestPath
}
