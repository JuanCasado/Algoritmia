//
//  main.swift
//  Sumatorio_recursivo
//
//  Created by Juan Casado Ballesteros on 9/23/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

/**
 De forma recursiva calculamos el sumatorio desde 0 a to
 :conditions la función se debe llamar sin utilizar los parámetros opcionales, estos son solo para la recursión
 :returns sumatorio de 0 a to
 */
func n_adder (to end:UInt, count:UInt=0, acc:UInt=0) -> UInt{
    if (end < count){
        return acc
    }
    return n_adder(to: end,count: count+1, acc: acc+count)
}

/**
 Pedimos al usuario un número por teclado
 :conditions se debe introducir un número positivo
 :returns Si lo introducido es un número es válido lo devolvemos, si no retornamos nil
 */
func getNumber () -> UInt?{
    guard let input = readLine() else{
        print("I/O ERROR")
        return nil
    }
    guard let number = UInt(input) else{
        print("Input is not a positive number")
        return nil
    }
    return number
}

//MAIN
while (true){
    print ("Insert a number to calculate n adder from 1 to it (0 to exit)")
    guard let userInput = getNumber() else{ // Si lo introducido es algo no válido volvemos a pedir un número
        print ("error")
        continue
    }
    guard userInput > 0 else{ // Introduciendo un 0 cancelamos la ejecución del programa sin errores
        print ("end")
        break
    }
    print(n_adder(to:userInput)) //Se muestra en resultado del sumatorio de 0 a to
}
