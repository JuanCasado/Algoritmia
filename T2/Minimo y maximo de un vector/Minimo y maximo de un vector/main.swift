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
func findMinMax(of data: inout [Int]) -> (min :Int,max :Int){
    let half = data.count/2
    for index in 0..<half{                           //Se realizan comparaciones con 1/2 de los valores
        let opposite_index = data.count-1-index
        if (data[index] > data[opposite_index]){
            data.swapAt(index, opposite_index)
        }
    }//En la primera mitad del array aseguramos que está el valor mínimo y en la segurnda el valor máximo.
    //Se realizan comparaciones con 1/2 de los valores
    let min = findBest(of : data, using : {d1, d2 in d1 < d2}, from: 0, to: half)
    //Se realizan comparaciones con 1/2 de los valores
    let max = findBest(of : data, using : {d1, d2 in d1 > d2}, from: half, to: data.count)
    return (min,max)
}

/**
 De un array de datos se nos proporciona su mejor valor para la función de optimización proporcionada entre el rango indicado.
 Se comparan todos los datos en el rango indicado.
 */
func findBest(of values: [Int], using comparator : (Int,Int)->Bool, from start_point : Int = 0, to end_point : Int) -> Int {
    var best = values.first!
    for index in start_point ..< end_point{
        let value = values[index]
        if (comparator(value, best)){
            best = value
        }
    }
    return best
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
//Realizamos el cálculo
let result = findMinMax(of: &data)
print ("El valor maximo es \(result.max) y el mínimo es \(result.min)")

