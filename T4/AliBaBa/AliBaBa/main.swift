//
//  main.swift
//  AliBaBa
//
//  Created by Juan Casado Ballesteros on 11/29/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let cantidad_objetos = Int.random(in: 2...10)
var objetos = [(peso : Int, valor : Int)]()
var peso_base = 1
var valor_base = 1

//Calculo de datos aleatorios
for _ in 0...cantidad_objetos {
    peso_base += Int.random(in: 1...5)
    valor_base += Int.random(in: 1...5)
    objetos.append((peso: peso_base, valor : valor_base))
}
//objetos = [(peso: 2, valor: 3), (peso: 6, valor: 7), (peso: 9, valor: 10), (peso: 13, valor: 14)]

//Matriz de resultados parciales
var memory = [[Int]]()

/**
 Expande la matriz de resultados parciales calculando la cantidad máxima de objetos que forman la solución
 óptima hasta el tamaño de alforja indicado.
 En la tabla se tienen en cuenta los objetos disponibles en cada momento
 */
func actualizarMatriz(hasta final_size: Int) {
    if memory.isEmpty {
        memory.append([Int].init(repeating: 0, count: objetos.count))
    }
    for _ in memory.count...final_size{
        var memory_fragment = [Int]()
        for index in 0..<objetos.count{
            if index == 0{//CASO BASE, objeto de menor tamaño
                if objetos [0].peso > memory.count { //el objeto de menor tamaño es más grande que la alforja
                    memory_fragment.append(0)
                } else {
                    memory_fragment.append(objetos[0].valor)
                }
            } else {
                if memory.count-objetos[index].peso < 0 || objetos [index].peso > memory.count{
                    //No se puede tomar el objeto nuevo
                    memory_fragment.append(memory_fragment[index-1])
                } else {
                    //Se toma el objeto nuevo si tomarlo es mejor resultado que no hacerlo
                    memory_fragment.append(max(memory_fragment[index-1],
                                               memory[memory.count-objetos[index].peso][index-1]+objetos[index].valor))
                }
            }
        }
        memory.append(memory_fragment)
    }
}

/**
 Obtene os un array con los objetos que forman parte del resultado óptimo
 La variable inout (regarding used) indica a false los objetos disponibles para usar
 */
func obtenerObjetos (para alforja : Int, con mem : [[Int]], y obj : [(peso : Int, valor : Int)],
                     en pos : Int, regarding used : inout [Bool]) -> [(peso : Int, valor : Int)] {
    if (pos == 0){//Estamos en el objeto más pequeño
        if (alforja >= obj[pos].peso) && !used[pos]{//Si cabe y no lo hemos usado es resultado
            used [pos] = true;
            return [obj[pos]]
        }
        return [(peso : Int, valor : Int)]()
        //Tratamos los objetos ya usados
    } else if (used[pos]) ||  ((mem [alforja][pos] == mem [alforja][pos-1]) && !used[pos-1]){
        return obtenerObjetos(para: alforja, con: mem, y: obj, en: pos - 1, regarding : &used)
    } else{
        if alforja >= obj[pos].peso{//Es el objeto más grande de los que podemos introducir, si cabe es resultado
            var lista_objetos = [obj[pos]]
            used [pos] = true;
            //Añadimos el nuevo resultado a los resultados obtenidos recursivamente
            lista_objetos.append(contentsOf : obtenerObjetos(para: alforja - obj[pos].peso, con: mem, y: obj, en: pos - 1, regarding : &used))
            return lista_objetos
        }
        return obtenerObjetos(para: alforja, con: mem, y: obj, en: pos - 1, regarding : &used)
    }
}

/**
 Permite calcular los objetos a introducir en dos alforjas sin perder la matriz de resultados parciales
 */
func obtenerObjetos(para alforja1 : Int, y alforja2 : Int) -> (alforja1:[(peso : Int, valor : Int)],alforja2:[(peso : Int, valor : Int)]){
    let max_alforja : Int
    let min_alforja : Int
    //Averiguamos que alforja es más grande
    if alforja1 > alforja2{
        max_alforja = alforja1
        min_alforja = alforja2
    } else {
        max_alforja = alforja2
        min_alforja = alforja1
    }
    if (max_alforja >= memory.count){//La matriz de resultados parciales se expande si no cubre el tamaño de la alforja máxima
        actualizarMatriz(hasta: max_alforja)
    }
    var used = [Bool].init(repeating: false, count: objetos.count)//Almacena los objetos que ya se tomaron
    //Se pretende evitar que la alforja grande le quetite los objetos chicos a la pequeña de modo que pasa primero para llenarse de los
    //objetos que sean de mayor tamaño y que no pueda tomar los chicos, todos los que no quepan en ella irán a la pequeña
    let objetos_max_alforja = obtenerObjetos(para: max_alforja, con: memory, y: objetos, en: objetos.count - 1, regarding: &used)
    let objetos_min_alforja = obtenerObjetos(para: min_alforja, con: memory, y: objetos, en: objetos.count - 1, regarding: &used)
    if max_alforja == alforja1{
        return (objetos_max_alforja,objetos_min_alforja)
    }else {
        return (objetos_min_alforja,objetos_max_alforja)
    }
}

/**
 Solicita un número al usuario
 */
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

while true {
    print ("-------------------------------------------------------")
    print ("Tienes: ")
    print (objetos)
    print ("Introduzca el tamaño de la alforja 1: ")
    guard let alforja1 = getNumber() else {
        print ("End.")
        break
    }
    print ("Introduzca el tamaño de la alforja 2: ")
    guard let alforja2 = getNumber() else {
        print ("End.")
        break
    }
    //Se calcula y muestra el resultado de los objetos que irán en cada alforja
    print("Objetos: \(obtenerObjetos(para: alforja1, y: alforja2) as Any)");
}
