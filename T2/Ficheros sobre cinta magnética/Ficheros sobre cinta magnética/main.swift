//
//  main.swift
//  Ficheros sobre cinta magnética
//
//  Created by Juan Casado Ballesteros on 10/11/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

func order(files : [(longitud : UInt,peticiones: UInt)]) {
    var values = [(value : UInt, ref : Int)]()
    for (ref,file) in files.enumerated() {
        values.append((file.peticiones/file.longitud, ref)) //Calculamos el valor de un archivo como la cantidad de peticiones que va a recibir / de su longitud, con esto obtendremos cuan eficientes es cada archivo.
    }
    values.sort(by:{$0.value > $1.value}) //Ordenamos los archivos en función de su valor.
    for (index,ordered) in values.enumerated() {
        let ref = ordered.ref
        print("\(index).\t Value: \(ordered.value) \t-> \tLongitud: \(files[ref].longitud), \tPeticiones: \(files[ref].peticiones)")
    }
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

func getTupple () -> (longitud : UInt, peticiones : UInt)? {
    print ("Longitud:")
    guard let longitud = getNumber() else {
        return nil
    }
    guard longitud > 0 else {
        return nil
    }
    print ("Peticiones:")
    guard let peticiones = getNumber() else {
        return nil
    }
    guard peticiones > 0 else {
        return nil
    }
    return (longitud, peticiones)
}

var data = [(longitud: UInt,peticiones: UInt)]();
//MAIN
while (true){
    print ("Insert a pair of number to create a file data")
    print ("Insert an 0 to calculate the order of the files in the magnetic tape")
    guard let userInput = getTupple() else{ // Si lo introducido es algo no válido mostramos el resultado con los datos que tengamos.
        print ("final order:")
        order(files: data)
        break
    }
    data.append(userInput)
}

