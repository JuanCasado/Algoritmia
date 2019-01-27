//
//  main.swift
//  trasponer
//
//  Created by Juan Casado Ballesteros on 11/8/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var domain = [[Int]]()
var cols = Int.random(in: 2...20)
var rows = Int.random(in: 2...20)
for _ in 0..<cols{
    var row = [Int]()
    for _ in 0..<rows {
        row.append(Int.random(in :0...1))
    }
    domain.append(row)
}

/*
domain = [[0,0,0,0],
          [0,0,1,0],
          [0,0,0,0],
          [0,0,0,0]]
cols = domain.count
rows = domain[0].count
*/

print ("Original:")
for row in domain{
    print (row)
}
//Tamaño de la matriz (múltiplo de 2) sobre el que el algoritmo puede aplicarse
let toGO = max(Int(pow(2,log2(Double(cols)).rounded(FloatingPointRoundingRule.up))), Int(pow(2,log2(Double(rows)).rounded(FloatingPointRoundingRule.up))))
let inc_cols = toGO - cols
let inc_rows = toGO - rows
//Se amplia la matriz original hasta el tamaño anterior
if (inc_rows > 0){
    for index in 0..<domain.count{
        domain[index].append(contentsOf: [Int].init(repeating: 0, count: inc_rows))
    }
}
if (inc_cols > 0){
    for _ in 0..<inc_cols{
        domain.append([Int].init(repeating: 0, count: (rows+inc_rows)))
    }
}

/**
 Toma una matriz y la divide en cuatro partes iguales correspondiento estas con los 4 cuadrantes
 */
func quarter (_ data :[[Int]]) -> ([[Int]],[[Int]],[[Int]],[[Int]]) {
    let cropSize = data.count/2;
    var q1 = [[Int]]()
    var q2 = [[Int]]()
    var q3 = [[Int]]()
    var q4 = [[Int]]()
    for i in 0..<cropSize{
        q1.append(Array<Int>(data[i][0..<cropSize]))
    }
    for i in cropSize..<data.count{
        q2.append(Array<Int>(data[i][0..<cropSize]))
    }
    for i in 0..<cropSize{
        q3.append(Array<Int>(data[i][cropSize..<data.count]))
    }
    for i in cropSize..<data.count{
        q4.append(Array<Int>(data[i][cropSize..<data.count]))
    }
    return (q1,q2,q3,q4)
}
/**
 Función recursiva que implmenta un algoritmo divide y vencerás para transponer matrices
 */
func transpose (_ data :[[Int]]) ->[[Int]]{
    //Caso base
    if data.count == 2 {
        var data = data
        let temp = data[0][1]
        data[0][1] = data [1][0]
        data[1][0] = temp
        return data
    }else{
        //La matriz se divide en cuatro cuartos
        let reduced =  quarter(data)
        var r1 = transpose(reduced.0)
        var r2 = transpose(reduced.1)
        var r3 = transpose(reduced.2)
        var r4 = transpose(reduced.3)
        //Se montan los resultados parciales
        let num = r1[1].count
        for i in 0..<num{
            r1[i].append(contentsOf: r2[i])
        }
        for i in 0..<num{
            r3[i].append(contentsOf: r4[i])
        }
        for i in 0..<num{
            r1.append(r3[i])
        }
        return r1
    }
}


let result = transpose(domain)
print ("Transposed:")
//De la matriz resultado se muestra solo la parte correspindiente al tamaño de matriz introducido
var str = "["
for i in 0..<rows{
    for j in 0..<cols {
        if j == cols-1{
            str += "\(result[i][j])]"
        }
        else{
            str += "\(result[i][j]), "
        }
    }
    print(str)
    str = "["
}
