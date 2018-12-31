//
//  main.swift
//  Minimo y maximo de un vector
//
//  Created by Juan Casado Ballesteros on 10/11/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

/**
 De un array de datos se nos proporciona su valor máximo y mínimo.
 Se comparan solo 3/2 veces todos los datos.
 */
func findMinMax(of data: [Int]) -> (min :Int,max :Int){
    var values = ArraySlice<Int>.init(data)
    let count = values.count
    let half = count/2
    for index in 0..<half{                           //Se realizan comparaciones con 1/2 de los valores
        let opposite_index = count-1-index
        if (values[index] > values[opposite_index]){
            values.swapAt(index, opposite_index)
        }
    }//En la primera mitad del array aseguramos que está el valor mínimo y en la segurnda el valor máximo.
    let min = findMin(of : Array(values[..<half]))  //Se realizan comparaciones con 1/2 de los valores
    let max = findMax(of : Array(values[half...]))  //Se realizan comparaciones con 1/2 de los valores
    return (min,max)
}

/**
 De un array de datos se nos proporciona su valor máximo.
 Se comparan todos los datos.
 */
func findMax(of values: [Int]) -> Int {
    var max = values.first!
    for value in values{
        if (value > max){
            max = value
        }
    }
    return max
}

/**
 De un array de datos se nos proporciona su valor mínimo.
 Se comparan todos los datos.
 */
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
//data = [10,20,45,3,7,8,12]
print ("Data")
var str = ""
for number in data{
    str+=String(number)+","
}
print (str)
let result = findMinMax(of: data)
print ("El valor maximo es \(result.max) y el mínimo es \(result.min)")

