//
//  main.swift
//  Minimo y maxcimo de un vector
//
//  Created by Juan Casado Ballesteros on 10/11/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

func findMinMax(of data: [Int]) -> (min :Int,max :Int){
    var values = ArraySlice<Int>.init(data)
    let count = values.count
    let half = count/2
    for index in 0..<half{                           //Se realizan comparaciones con 1/3 de los valores
        let opposite_index = count-1-index
        if (values[index] > values[opposite_index]){
            values.swapAt(index, opposite_index)
        }
    }
    let min = findMin(of : Array(values[..<half]))
    let max = findMax(of : Array(values[half...]))
    
    return (min,max)
}

func findMax(of values: [Int]) -> Int {
    var max = values.first!
    for value in values{
        if (value > max){
            max = value
        }
    }
    return max
}
func findMin(of values: [Int]) -> Int {
    var min = values.first!
    for value in values{
        if (value < min){
            min = value
        }
    }
    return min
}

var data = [Int].init()
for _ in 0..<20{
    data.append(Int.random(in: -999...999))
}
print ("Data")
var str = ""
for number in data{
    str+=String(number)+","
}
print (str)
let result = findMinMax(of: data)
print ("El valor maximo es \(result.max) y el mínimo es \(result.min)")

