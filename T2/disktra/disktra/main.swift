//
//  main.swift
//  disktra
//
//  Created by Juan Casado Ballesteros on 10/19/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let graph = Graph.init(nodes: 10)
print("Graph:")
graph.show()
let path1 = graph.calculatePath(from: 0, to: 9)
print ("\nPath of 0 to 9:")
print(path1)
print ("\nAll generated paths:")
for (i,row) in graph.getAll().enumerated() {
    for (j,path) in row.enumerated() {
        print ("from: \(i) to: \(j) with: \(path as Any)")
    }
}


