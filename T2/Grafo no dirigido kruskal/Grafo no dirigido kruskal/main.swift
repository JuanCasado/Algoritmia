//
//  main.swift
//  Grafo no dirigido kruskal
//
//  Created by Juan Casado Ballesteros on 10/21/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let max = 9999

struct arista{
    let x : Int
    let y : Int
    let distance: Int
}


func findPath (in data :[[Int]]) -> (graph: [[Int]],order: [arista]) {
    var aristas = [arista]()
    for (i,node) in data.enumerated(){
        for (j,value) in node.enumerated(){
            aristas.append(arista.init(x: j, y: i, distance: value))
        }
    }
    aristas.sort { (a1, a2) -> Bool in
        return a1.distance<a2.distance
    }
    var selected_order = [arista]()
    while selected_order.count < data.count-1{
        for ar in selected_order{
            if ar.x == aristas.first!.x{
                aristas.remove(at: 0)
                continue;
            }
            if ar.x == aristas.first!.y{
                aristas.remove(at: 0)
                continue;
            }
            if ar.y == aristas.first!.y{
                aristas.remove(at: 0)
                continue;
            }
            if ar.y == aristas.first!.x{
                aristas.remove(at: 0)
                continue;
            }
        }
        selected_order.append(aristas.first!)
        aristas.remove(at: 0)
    }
    var selected_graph = [[Int]].init(repeating: [Int].init(repeating: 0, count: nodes.first!.count), count: nodes.count)
    for ar in selected_order{
        selected_graph[ar.y][ar.x] = ar.distance
    }
    return (selected_graph,selected_order)
}

var nodes =
    [[max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,0,0,max,Int.random(in: 0 ..< max)],
     [0,0,0,0,0,max]]
for (i,node) in nodes.enumerated(){
    for (j,_) in node.enumerated(){
        nodes[j][i] = nodes [i][j]
    }
}
print("Grafo:")
let numberFormatter = NumberFormatter()
numberFormatter.minimumIntegerDigits = 4
for node in nodes{
    var str = ""
    for data in node{
        str += numberFormatter.string(from: NSNumber(value: data))!+","
    }
    print (str)
}
var distance = 0
let path = findPath (in: nodes)
print("\nAristas del camino mínimo en orden de cálculo:")
for (index, node) in path.order.enumerated(){
    print ("\(index). \tx: \(node.x), y:\(node.y), distance:\(node.distance)");
}
print("\nGrafo del amino mínimo:")
for node in path.graph{
    var str = ""
    for data in node{
        distance += data
        str += numberFormatter.string(from: NSNumber(value: data))!+","
    }
    print (str)
}
print ("Total distance = \(distance)")

