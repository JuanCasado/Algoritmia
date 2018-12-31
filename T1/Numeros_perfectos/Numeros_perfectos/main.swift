//
//  main.swift
//  Numeros_perfectos
//
//  Created by Juan Casado Ballesteros on 9/22/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

/**
 De forma iterativa calculamos si un número es perfecto
 :src http://www.vaxasoftware.com/doc_edu/mat/numperfe_esp.pdf :Listado de números perfectos
 :returns decimos si la suma de todos los números divisibles desde 1 al introducido es igual al número introducido
 */
func isPerfect (_ number:UInt) -> Bool{
    var acc :UInt = 0
    for posibleDivisor in 1..<number{       // Desde 1 incluido al número sin incluir
        if number % posibleDivisor == 0{    // Si el número es divisible
            acc += posibleDivisor           // Lo sumamos a un acumulador
        }
    }
    return acc == number                    // Devolvemos si el acumulador es igual al número dado
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
while true{
    print ("Insert a number to know if it is perfect (0 to exit)")
    guard let userInput = getNumber() else{ // Si lo introducido es algo no válido volvemos a pedir un número
        print ("end")
        continue
    }
    guard userInput > 0 else{ // Introduciendo un 0 cancelamos la ejecución del programa sin errores
        print ("end")
        break
    }
    if isPerfect(userInput){ // Mostramos si es perfecto o no
        print ("\(userInput) is a Perfect number")
    }else{
        print ("\(userInput) is not a Perfect number")
    }
}
