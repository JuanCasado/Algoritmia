//
//  main.swift
//  Minimo en funcion
//
//  Created by Juan Casado Ballesteros on 12/31/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

/**
 Interfaz de las funciones
 */
protocol Function {
    //Calcula los valores y de la función para una x dada
    func getY (x: Double) -> Double
    //Representa a la funcion que se realiza
    func toString () -> String
}

/**
 Función cuadrática de la forma ax^2 +bx +c
 */
class Cuadratic : Function {
    init() {
        a = Double.random(in: 1...100)
        b = Double.random(in: -50...50)
        c = Double.random(in: -50...50)
    }
    init(a : Double, b : Double, c : Double) {
        self.a = a
        self.b = b
        self.c = c
    }
    private let a : Double
    private let b : Double
    private let c : Double
    func getY (x: Double) -> Double {
        return a * x * x + b * x + c
    }
    func toString () -> String {
        return "\(a)x^2 + \(b)x + \(c)"
    }
}

/**
 Función que encuentra el mínimo relativo de la una función en un rango con la precisión indicada
 */
func findMIn (over function : Function, x1 : Double = 300, x4 : Double = -300, precision min_range : Double = 0.0001) -> (Double, Double)? {
    let range_width = x1 - x4
    if (range_width < min_range){
        return (x1, x4)
    }
    //Dividimos la función en 3 rangos de igual tamaño (Cada vez el tamaño será menor)
    let x2 = x4 + range_width/2
    let x3 = x4 + range_width/4
    let y1 = function.getY(x: x1)
    let y2 = function.getY(x: x2)
    let y3 = function.getY(x: x3)
    let y4 = function.getY(x: x4)
    //Evaluamos si la función crece o decrece en cada rango
    let range1 = y1 > y2
    let range2 = y2 > y3
    let range3 = y3 > y4
    if (range1 && !range2 && !range3) { //El minimo está entre los rangos 1 y 2
        return findMIn(over: function, x1: x1, x4 : x3, precision: min_range)
    } else if (range1 && range2 && !range3) { //El minimo está entre los rangos 2 y 3
        return findMIn(over: function, x1: x2, x4 : x4, precision: min_range)
    } else { //No sabemos donde está el mínimo
        return nil
    }
}

let function = Cuadratic()
print ("Function: " + function.toString())
print (findMIn(over: function) as Any)
