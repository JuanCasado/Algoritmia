//
//  main.swift
//  Billetes
//
//  Created by Juan Casado Ballesteros on 11/22/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var billetes = [(valor : Int,cantidad : Int)]()
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

func vueltas (de precio :Int,
              teniendo billetes : [(valor : Int,cantidad : Int)])
                -> [(valor : Int,cantidad : Int)]? {
    if precio >= billetes.first!.valor{
        var vuelta = [(valor : Int,cantidad : Int)]()
        var index = 0
        for (i,billete) in billetes.enumerated(){
            vuelta.append((valor : billete.valor, cantidad : 0))
            if (billete.valor <= precio) && (billete.cantidad > 0){
                index = i
            }
        }
        var valor = 0
        var billetes = billetes
        while index >= 0{
            valor = billetes[index].valor
            billetes[index].cantidad -= 1
            vuelta[index].cantidad += 1
            if (precio - valor) > 0 {
                guard let sigVuelta = vueltas(de: precio-valor, teniendo: billetes) else {
                    billetes[index].cantidad += 1
                    vuelta[index].cantidad -= 1
                    index -= 1
                    break
                }
                for (i,v) in sigVuelta.enumerated(){
                    vuelta[i].cantidad += v.cantidad;
                }
            }
            return vuelta
        }
        return nil
    }
    return nil
}

print ("Tienes : \n \(billetes)")
while true {
    print ("Introduzca precio a pagar: ")
    guard let precio = getNumber() else {
        print ("End.")
        break
    }
    print("Debes devolver: \(vueltas(de: precio, teniendo: billetes) as Any)");
}
