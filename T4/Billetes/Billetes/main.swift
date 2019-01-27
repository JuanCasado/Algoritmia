//
//  main.swift
//  Billetes
//
//  Created by Juan Casado Ballesteros on 11/22/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var billetes = [(valor : Int,cantidad : Int)]()
var max_value = 0
let cantidad_billetes = Int.random(in: 3...10)
billetes.append((Int.random(in: 1...10), Int.random(in: 1...3)))
for _ in 0...cantidad_billetes{
    billetes.append((Int.random(in: 1...10) + billetes.last!.valor, Int.random(in: 1...3)))
}

func getNumber () -> Int?{
    guard let input = readLine() else{
        print("I/O ERROR")
        return nil
    }
    guard let number = Int(input) else{
        print("Input is not a valid number")
        return nil
    }
    return number
}

billetes = [(2,1),(4,1),(6,1)]

var matriz_precios = [[Int?]].init(arrayLiteral: [Int?].init(repeating: 0, count: billetes.count));
func actualizarMatriz (hasta precio : Int = 0) {
    for precio_actual in matriz_precios.count...precio {
        var nueva_columna = [Int?]()
        for (index,billete) in billetes.enumerated() {
            if index == 0{
                if precio_actual < billete.valor{
                    nueva_columna.append(nil)
                } else {
                    nueva_columna.append(1 + (matriz_precios [precio_actual - billete.valor][0] ?? 1))
                }
            } else if precio_actual < billete.valor{
                nueva_columna.append(nueva_columna[index-1])
            }else {
                if (nueva_columna[index-1] != nil) && (matriz_precios[matriz_precios.count - billete.valor][index] != nil) {
                    nueva_columna.append(min(nueva_columna[index-1]!, 1 + matriz_precios[matriz_precios.count - billete.valor][index]!))
                } else if nueva_columna[index-1] != nil {
                    nueva_columna.append(nueva_columna[index-1])
                } else if matriz_precios[matriz_precios.count - billete.valor][index] != nil {
                    nueva_columna.append(matriz_precios[matriz_precios.count - billete.valor][index])
                } else {
                    nueva_columna.append(nil)
                }
            }
        }
        matriz_precios.append(nueva_columna)
    }
}

func vueltas (de precio : Int) -> [(valor : Int, cantidad :Int)]? {
    if (precio == 0){
        return nil
    }
    var index = billetes.count - 1
    while index > 0 && billetes[index].valor > precio {
        index -= 1
    }
    guard let cantidad_billetes = matriz_precios[precio][index] else {
        return nil
    }
        var vuelta = [(valor : Int, cantidad : Int)]()
        var precio = precio
        var local_billletes = billetes
        while (index > 0) {
            if index == 0 {
                if billetes[index].cantidad >= cantidad_billetes {
                    return [(valor : billetes[index].valor, cantidad : cantidad_billetes)]
                } else {
                    return nil
                }
            }
            if (matriz_precios[precio][index] == matriz_precios[precio][index-1]){
                if (index-1 == 0){
                    if (local_billletes [index].cantidad >= matriz_precios[index][precio]!){
                        vuelta.append((valor : local_billletes[index].valor, cantidad : cantidad_billetes))
                        return vuelta
                    } else {
                        return nil
                    }
                } else{
                    index -= 1;
                }
            } else {
                guard let cantidad_billetes = matriz_precios[precio][index] else {
                    index -= 1
                    continue
                }
                if (local_billletes [index].cantidad >= matriz_precios[index][precio]!){
                    vuelta.append((valor : local_billletes[index].valor, cantidad : cantidad_billetes))
                    precio -= local_billletes[index].valor
                    local_billletes [index].cantidad -= matriz_precios[index][precio]!
                    return vuelta
                } else {
                    return nil
                }
            }
        }
    
    
    return nil
}


for billete in billetes {
    max_value += billete.valor * billete.cantidad
}

print ("Tienes : \n \(billetes)")

while true {
    print ("Introduzca precio a pagar: ")
    guard let precio = getNumber() else {
        print ("End.")
        break
    }
    if (precio >= matriz_precios.count){
        actualizarMatriz(hasta: precio)
    }
    print("Debes devolver: \(vueltas(de: precio) as Any)");
}
