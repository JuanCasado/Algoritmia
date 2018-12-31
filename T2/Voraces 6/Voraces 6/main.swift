//
//  main.swift
//  Voraces 6
//
//  Created by Juan Casado Ballesteros on 10/24/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let maxValue = 50
let trozosEscalera = 15
var escaleras = [Int]()

for _ in 0..<trozosEscalera{
    escaleras.append(Int.random(in: 1...maxValue))
}
//escaleras=[4,2,3,7,8,9,22,45,12,3]
print ("Data:")
print (escaleras)
escaleras.sort()
print ("Sorted data:")
print (escaleras)
print ("-------------------------------------------------------------------------------------")
var nueva_escalera : Int
var escalera_1 : Int
var escalera_2 : Int
var insert_index : Int
var time = 0;
for _ in escaleras{
    if escaleras.count > 2 {
        //Los dos primeras escaleras del vector son los que proporcionan un tiempo mínimo ya que son las más peqiueñas
        escalera_1 = escaleras.remove(at: 0)
        escalera_2 = escaleras.remove(at: 0)
        nueva_escalera = escalera_1 + escalera_2
        time += nueva_escalera;
        insert_index = 0;
        //Colocamos la nueva escalera ordenada dentro del vector
        while insert_index < escaleras.count && (escaleras[insert_index] < nueva_escalera){
            insert_index += 1
        }
        escaleras.insert(nueva_escalera, at: insert_index)
        //Mostramos datos
        print ("Added: \(nueva_escalera) <-- \(escalera_1) + \(escalera_2), at: \(insert_index)")
        print ("time: \(time)")
        print (escaleras)
    } else {//Con los dos últimos valores ya no es necesario ejecutar el algoritmo, los tomamos en orden
        for escalera_impar in escaleras{
            print ("Added: \(escalera_impar)")
            time += escalera_impar;
            escaleras.remove(at: 0)
        }
    }
}
print ("Total time: \(time)")





