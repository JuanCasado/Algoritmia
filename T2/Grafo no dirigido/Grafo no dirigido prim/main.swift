//
//  main.swift
//  Grafo no dirigido
//
//  Created by Juan Casado Ballesteros on 10/11/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let max = 9999

//Una arista está formada por un nodo de inicio, uno de fin y una distacia de uno a otro
struct arista{
    let x : Int //Node al que nos hemos unido al insertar el dato
    let y : Int //NUevo nodo disponible para insertar futuros datos
    let distance: Int
}

/**
 Funcion que a partir de una matriz que representa un grafo no dirigido (A[a][b]==A[b][a])
 calcula el camino mínimo entre los nodos
 Output: tupla con =>
 => graph : matriz de tamaño idéntico a la originar, con todas sus aristas a 0 excepto aquellas que formen el camnino mínimo
 => order : vector de aristas en el que se indica como estas fueron elegidas por el algoritmo
 */
func findPath (in data :[[Int]]) -> (graph: [[Int]],order: [arista]) {
    var nodes = data
    var selected_graph = [[Int]].init(repeating: [Int].init(repeating: 0, count: nodes.first!.count), count: nodes.count)
    var selected_order = [arista]()
    var near = [Int].init(repeating: 0, count: nodes.count)
    var distance = [Int].init(nodes.map(){$0.first!}) //Iniciamos el vector distancia al primer valor de cada columna
    for i in 0..<nodes.count-1 {
        var min = max
        var min_index = 0
        //Buscamos el mínimo del vector distancia
        for j in 0..<distance.count {
            if distance[j] < min{
                min = distance[j]
                min_index = j
            }
        }
        //Rellenamos los valores de la salida
        selected_graph[near[min_index]][min_index]=distance[min_index]
        selected_graph[min_index][near[min_index]]=distance[min_index]
        selected_order.append(arista.init(x: near[min_index], y: min_index, distance: distance[min_index]))
        //Marcamos el nodo como tomado para evitar bucles
        nodes[near[min_index]][min_index]=max
        distance[min_index]=max
        //Actualizamos el valor distancia poniendo el mínimo entre el valor que ya tenía para cada columna compardo
        //con el que hay en el grafo en la fila en la que se ha encontrado el valor mínimo
        for j in 0..<nodes[i].count {
            if nodes[j][min_index] < distance[j]{
                distance[j] = nodes[j][min_index]
                near [j] = min_index
            }
        }
    }
    return (selected_graph,selected_order)
}

//Creamos una matriz con datos aleatorios
var nodes =
    [[max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,0,max,Int.random(in: 0 ..< max),Int.random(in: 0 ..< max)],
     [0,0,0,0,max,Int.random(in: 0 ..< max)],
     [0,0,0,0,0,max]]
for (i,node) in nodes.enumerated(){
    for (j,_) in node.enumerated(){
        nodes[j][i] = nodes [i][j]
    }
}
//Mostramos la matriz generada
print("Grafo:")
let numberFormatter = NumberFormatter()
numberFormatter.minimumIntegerDigits = 4
for node in nodes{
    var str = ""
    for data in node{
        str += numberFormatter.string(from: NSNumber(value: data))!+","
    }
    print (str)
}

var distance = 0
let path = findPath (in: nodes) //Obtenemos el camino mínimo
print("\nAristas del camino mínimo en orden de cálculo:")
//Mostramos las aristas que componen el camino mínimo
for (index, node) in path.order.enumerated(){
    print ("\(index). \tx: \(node.x), y:\(node.y), distance:\(numberFormatter.string(from: NSNumber(value: node.distance))!)");
}
//Mostramos el camino en forma de matriz
print("\nGrafo del camino mínimo:")
for node in path.graph{
    var str = ""
    for data in node{
        distance += data
        str += numberFormatter.string(from: NSNumber(value: data))!+","
    }
    print (str)
}
print ("Total distance = \(distance)")
