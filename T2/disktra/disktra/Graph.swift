//
//  Graph.swift
//  disktra
//
//  Created by Juan Casado Ballesteros on 10/21/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

class Graph{
    let graphMaxValue : Int;
    var costMatrix : [[Int]]
    private var shortestPath : [[([(Int, Int)],Int)?]]
    init(nodes: Int, graphMaxValue : Int = 999){
        self.graphMaxValue = graphMaxValue
        costMatrix = [[Int]]()
        for i in 0..<nodes{
            costMatrix.append([Int]())
            for _ in 0..<nodes{
                if Int.random(in: 0..<10) != 0{
                    costMatrix[i].append(Int.random(in: 1..<graphMaxValue))
                }else{
                    costMatrix[i].append(graphMaxValue)
                }
            }
        }
        for i in 0..<nodes{
            costMatrix[i][i] = graphMaxValue
        }
        for (i,_) in costMatrix.enumerated(){
            for (j,_) in costMatrix.enumerated(){
                costMatrix[j][i] = costMatrix [i][j]
            }
        }
        shortestPath = [[([(Int, Int)],Int)?]].init(repeating: [([(Int, Int)],Int)?].init(repeating: nil, count: nodes), count: nodes)
    }
    public func show(){
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = len(of: graphMaxValue)
        for row in costMatrix{
            var str = ""
            for cost in row {
                str += numberFormatter.string(from: NSNumber(value: cost))!+","
            }
            print (str);
        }
    }
    public func getAll () -> [[([(Int, Int)],Int)?]]{
        return shortestPath
    }
    private func len(of number:Int) -> Int{
            var number = number
            var len = 0
            repeat {
                number /= 10
                len += 1
            } while (number > 0)
            return len
    }
    public func calculatePath (from start :Int = 0, to end :Int) -> ([(Int, Int)],Int){
        if let path = shortestPath[start][end]{
            return path
        }else{
            let newPaths = disjkstra(from: start)
            for node in newPaths.selected{
                var newPath = pathGenerator(from: start, with: node, over: newPaths.previous)
                newPath.append((node, costMatrix[newPath.last!.0][node]))
                shortestPath[start][node] = (newPath, newPaths.weights[node])
                shortestPath[node][start] = (shift(newPath.reversed()), newPaths.weights[node])
                if newPath.count > 2 {
                    for index in 0..<newPath.count{
                        if index > 1 {
                            shortestPath[newPath[index].0][newPath[index-1].0] = (shift([newPath[index],newPath[index-1]]), newPath[index].1)
                            newPath[index-1].1 = 0
                            shortestPath[newPath[index-1].0][newPath[index].0] = ([newPath[index-1],newPath[index]], newPath[index].1)
                        }
                    }
                }
            }
            return calculatePath (from: start, to: end)
        }
    }
    public func calculatePath (from start :Int = 0) -> ([(Int, Int)],Int){
        return calculatePath(from: start, to: graphMaxValue)
    }
    
    public func shift(_ path : [(Int,Int)]) -> [(Int,Int)]{
        var path = path
        let len = path.count - 1
        for index in 0..<path.count-1 {
            path[len - index].1 = path[len - index - 1].1
        }
        path[0].1 = 0
        return path
    }
    
    private func pathGenerator (from start :Int, with node :Int, over previous :[Int]) -> [(Int,Int)]{
        if previous[node] == start{
            return [(start, 0)]
        }else{
            var new = pathGenerator(from:start, with:previous[node], over: previous)
            new.append((previous[node], costMatrix[new.last!.0][previous[node]]))
            return new
        }
    }
    
    private func disjkstra(from start :Int = 0) -> (selected: [Int],weights: [Int],previous: [Int]){
        var selected = [start]
        var candidates = [Int]()
        for candidate in 0..<costMatrix.count{
            candidates.append(candidate)
        }
        candidates.remove(at: candidates.firstIndex(of: start)!)
        var weights = [Int].init(costMatrix[start])
        weights[start] = 0
        var totalWeight = 0
        var minWeightIndex = start
        var previous = [Int].init(repeating: 0, count: costMatrix.count)
        while !candidates.isEmpty {
            var minWeight = graphMaxValue;
            for candidate in candidates{
                if (weights[candidate] <= minWeight){
                    minWeight = weights[candidate]
                    minWeightIndex = candidate
                }
            }
            selected.append(minWeightIndex)
            candidates.remove(at: candidates.firstIndex(of: minWeightIndex)!)
            totalWeight = weights[minWeightIndex]
            for candidate in candidates{
                if (weights[candidate] > (totalWeight + costMatrix[minWeightIndex][candidate])){
                    weights[candidate] = totalWeight + costMatrix[minWeightIndex][candidate]
                    previous[candidate] = minWeightIndex
                }
            }
        }
        return (selected, weights, previous)
    }
}
