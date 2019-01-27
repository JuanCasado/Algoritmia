//
//  main.swift
//  Sustitucion
//
//  Created by Juan Casado Ballesteros on 1/2/19.
//  Copyright © 2019 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

//Estas dos variables almacenan los datos a partir de los que las sustituciones se realizan
let matriz_sustitucion : [[Character]] = [["b","b","a","d"],
                                          ["c","a","d","a"],
                                          ["b","a","c","c"],
                                          ["d","c","d","b"]]
let index_of  : [Character:Int] = ["a":0,"b":1,"c":2,"d":3]

/**
 Nos permite converitir un conjunto de dos letras en una sola aplicando las reglas proporcionadas
 */
func sustitucion (_ letra1 : Character, _ letra2 : Character) -> String{
    return String(matriz_sustitucion[index_of[letra1]!][index_of[letra2]!])
}

//Datos sobre los que realizar el cálculo
let cadena_inicial = "acabada"
let target = "c"

/**
 Función que indica si una cadena de caracteres es converitble en otra
 En caso de ser convertible nos proporcionará cómo realizar la conversión
 */
func convertir (_ cadena : String, en target : String) -> [String]?{
    if (cadena == target) { //CASO BASE: Se puede hacer la conversión
        return [String]()
    }
    var first_index = cadena.startIndex
    var second_index = cadena.index(after: first_index)
    while second_index != cadena.endIndex {
        var nueva_cadena = cadena //Duplicamos la cadena para no perder la original
        //Realizamos la conversión que toque según los índices de lectura
        nueva_cadena.replaceSubrange(first_index...second_index, with: sustitucion(cadena[first_index], cadena[second_index]))
        guard var acciones = convertir(nueva_cadena, en: target) else { //No se pudo realizar la converisón
            //Vamos al siguiente elemento
            first_index = second_index
            second_index = cadena.index(after: second_index)
            continue
        }
        acciones.append("\(cadena) -> \(nueva_cadena), " +
            "(\(cadena[first_index])\(cadena[second_index]) -> \(sustitucion(cadena[first_index], cadena[second_index])))")
        return acciones //La converión se pudo realizar, devolvemos la lista de pasos necesarios para hacerla
    }
    return nil //CASO BASE: NO se puede hacer la conversión
}

if let acciones = convertir(cadena_inicial, en: target) {
    for paso in acciones {
        print (paso)
    }
} else {
    print ("No se puede convertir \(cadena_inicial) en \(target)")
}
