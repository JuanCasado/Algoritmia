//
//  main.swift
//  largest_common_secuence
//
//  Created by Juan Casado Ballesteros on 1/2/19.
//  Copyright © 2019 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var secuence1 = [Int]()
var secuence2 = [Int]()
let secuence1_count = Int.random(in: 5...20)
let secuence2_count = Int.random(in: 5...20)
//Datos aleatorios
for _ in 0...secuence1_count {
    secuence1.append(Int.random(in: 0...1))
}
for _ in 0...secuence2_count {
    secuence2.append(Int.random(in: 0...1))
}

//secuence1 = [0, 1, 1, 1, 0, 0]
//secuence2 = [1, 0, 1, 0, 1, 0, 1, 0]

//Almacena los resultados ya calculados
var memory = [[[Int]?]].init(repeating: [[Int]?].init(repeating: nil, count: secuence2.count), count: secuence1.count)

/**
 Función recursiva que toma dos vectores y proporciona de ellos la parte común a ambos que tenga un tamaño mayor.
 Hace uso de una memoria de resultados parciales para evitar calcular varias veces los mismo resultados
 */
func largestCommonSecuence (of secuence1  : [Int], and secuence2 : [Int], index1 : Int = 0, index2 : Int = 0) -> [Int] {
    if (index1 == secuence1.count) || (index2 == secuence2.count) {//Hemos teminado (hemos recorrido ambos vectores)
        return [Int]()
    } else if memory[index1][index2] != nil {//El resultado ya fue calculado anteriormente
        return memory [index1][index2]!
    } else if secuence1[index1] == secuence2 [index2]{//Como el valor de los vectores coincide este valor formará parte de la cadena común
        memory [index1][index2] = [secuence1[index1]]
            + largestCommonSecuence(of: secuence1, and: secuence2, index1: index1+1, index2: index2 + 1)
        return memory[index1][index2]!
    } else {//El valor a evaluar de los vectores difiere
        //La cadena común será la más larga entre la formada incluyendo al valor del vector1 pero no al del dos o viceversa
        let l1 = largestCommonSecuence(of: secuence1, and: secuence2, index1: index1 + 1, index2 : index2)
        let l2 = largestCommonSecuence(of: secuence1, and: secuence2, index1: index1, index2 : index2 + 1)
        if l1.count >= l2.count {
            memory[index1][index2] = l1
        } else {
            memory[index1][index2] = l2
        }
        return memory[index1][index2]!
    }
}
print ("S1: \(secuence1)")
print ("S2: \(secuence2)")
print ("LargestCommonSecuence: \(largestCommonSecuence(of: secuence1, and: secuence2))")
