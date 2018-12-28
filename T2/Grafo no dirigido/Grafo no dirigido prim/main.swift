//
//  main.swift
//  Grafo no dirigido
//
//  Created by Juan Casado Ballesteros on 10/11/18.
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
    var nodes = data
    var selected_graph = [[Int]].init(repeating: [Int].init(repeating: 0, count: nodes.first!.count), count: nodes.count)
    var selected_order = [arista]()
    var near = [Int].init(repeating: 0, count: nodes.count)
    var distance = [Int].init(nodes.map(){$0.first!})
    for i in 0..<nodes.count-1 {
        var min = max
        var min_index = 0
        for j in 0..<nodes[i].count {
            if distance[j] < min{
                min = distance[j]
                min_index = j
            }
        }
        selected_graph[near[min_index]][min_index]=distance[min_index]
        selected_order.append(arista.init(x: near[min_index], y: min_index, distance: distance[min_index]))
        nodes[near[min_index]][min_index]=max
        distance[min_index]=max
        for j in 0..<nodes[i].count {
            if nodes[j][min_index] < distance[j]{
                distance[j] = nodes[j][min_index]
                near [j] = min_index
            }
        }
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
