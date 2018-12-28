//
//  main.swift
//  Corchos y botellas
//
//  Created by Juan Casado Ballesteros on 10/27/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var corchos = [Int]()
var botellas = [Int]()
let cantidad = 10

while botellas.count < cantidad{
    let toAdd = Int.random(in: 0..<100)
    if let _ = botellas.firstIndex(of: toAdd) {} else{
        botellas.append(toAdd)
        corchos.append(toAdd)
    }
}
botellas.shuffle()
corchos.shuffle()
print ("Botellas: \(botellas)")
print ("Corchos: \(corchos)")

func findCorcho (of key :Int, in data: [Int], offset :Int = 0) -> Int? {
    let midIndex = Int((data.count-1)/2)
    let midValue = data[midIndex]
    if midValue == key {
        return midIndex + offset
    } else if data.count == 1 {
        return nil
    } else if midValue > key {
        return findCorcho(of: key, in: Array<Int>(data[0...midIndex]), offset: offset)
    } else {
        return findCorcho(of: key, in: Array<Int>(data[midIndex+1..<data.count]), offset: offset + midIndex + 1)
    }
}

func findBotella (of key :Int, in data: [Int]) -> Int? {
    for (index, value) in data.enumerated() {
        if value == key {
            return index
        }
    }
    return nil
}

func pivotar (pivote: Int, data :[Int]) -> ([Int], [Int]){
    var data = data
    var minIndex = 0
    var maxIndex = data.count - 1
    while minIndex < maxIndex {
        while data [minIndex] < pivote {
            minIndex += 1
        }
        while data [maxIndex] > pivote {
            maxIndex -= 1
        }
        data.swapAt(minIndex, maxIndex)
    }
    return (Array<Int>(data[0...minIndex]) , Array<Int>(data[minIndex+1..<data.count]))
}

func quickSortCorchos (in data: [Int], comparing: [Int]) -> [Int] {
    if (data.count > 1){
        let botella_equivalente = comparing[findBotella(of: data[0], in: comparing)!]
        let corchos_separados_por_botella = pivotar(pivote: botella_equivalente, data: data)
        var resultado_unido = [Int]()
        resultado_unido.append(contentsOf: quickSortCorchos(in: corchos_separados_por_botella.0, comparing: comparing))
        resultado_unido.append(contentsOf: quickSortCorchos(in: corchos_separados_por_botella.1, comparing: comparing))
        return resultado_unido
    } else{
        return data
    }
}
func quickSortBotellas (in data :[Int], comparing: [Int]) -> [Int] {
    if (data.count > 1){
        let corcho_equivalente = comparing[findCorcho(of: data[0], in: comparing)!]
        let botellas_separadas_por_corcho = pivotar(pivote: corcho_equivalente, data: data)
        var resultado_unido = [Int]()
        resultado_unido.append(contentsOf: quickSortCorchos(in: botellas_separadas_por_corcho.0, comparing: comparing))
        resultado_unido.append(contentsOf: quickSortCorchos(in: botellas_separadas_por_corcho.1, comparing: comparing))
        return resultado_unido
    } else{
        return data
    }
}

let sortedCorchos = quickSortCorchos(in: corchos, comparing: botellas)
print (sortedCorchos)
print(quickSortBotellas(in: botellas, comparing: sortedCorchos))






