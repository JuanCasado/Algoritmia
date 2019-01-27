//
//  main.swift
//  caballo_ajedrez
//
//  Created by Juan Casado Ballesteros on 1/2/19.
//  Copyright © 2019 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

//Generación aleatoria de datos
var cols = Int.random(in: 1...10)
var rows = Int.random(in: 1...10)
//cols = 3
//rows = 4

var visited = [[Bool]].init(repeating: [Bool].init(repeating: false, count: rows), count: cols)
let max_count = visited.count * visited.first!.count - 1
print ("\(visited.count) x \(visited.first!.count) => Steps: \(max_count)")

var x = Int.random(in: 0..<visited.count)
var y = Int.random(in: 0..<visited.first!.count)
//x = 0
//y = 0
print ("Starting at: (\(x),\(y))")

//Almacena el resultado
var answer = [(Int, Int)]()
/**
 Función que indica si se puede recorrer un tablero del tamaño de la matriz visited empezando en la posisión (x,y)
 En caso de poderse recorrer nos proporcionará el camino realizado
 */
func chees (startx x : Int, starty y : Int, visited : inout [[Bool]], count : Int = 0) -> Bool{
    if (count >= max_count){//La casilla es valida y además la última
        answer.append((x,y))
        return true;//Indimacos que todas las casillas que llevaron a llegar a esta sean añadidas a la recursión, además esta finalizará
    } else {
        visited[x][y] = true //Marca la casilla actual como visitada para todas las llamadas recursivas a partir de esta rama
        for i in -2...2 {
            for j in -2...2 {
                if (((abs(i)==1)&&(abs(j)==2))||((abs(i)==2)&&(abs(j)==1)))//Es un movimiento de caballo valido
                    && ((y+j) >= 0) && ((x+i) >= 0) && ((x+i) < visited.count) && ((y+j) < visited.first!.count)//Dentro del tablero
                    && (!visited[x+i][y+j])//Hacia una casilla no visitada anteriormente
                    && chees (startx : x+i, starty : y+j, visited : &visited, count : count + 1) { //Que permite llegar a una solución
                        answer.append((x,y))
                        return true
                }
            }
        }
        visited[x][y] = false //Hace que para el resto de las llamadas recursivas que no estén en la rama puedan visitar la casilla
        return false
    }
}

if chees(startx: x, starty: y, visited: &visited) {
    print (answer)
} else {
    print ("Sin solución")
}


