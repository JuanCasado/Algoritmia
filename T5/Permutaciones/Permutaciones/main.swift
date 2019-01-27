//
//  main.swift
//  Permutaciones
//
//  Created by Juan Casado Ballesteros on 1/2/19.
//  Copyright © 2019 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var data = [Int]()
for _ in 1...Int.random(in: 2...5){
    data.append(Int.random(in: 0...100))
}
var valid = [Bool].init(repeating: true, count: data.count)

func permutate (data : inout [Int], output : inout [Int], util : inout [Bool], depth : Int = 0){
    if output.count <= depth {
        print (output)
    } else {
        for i in 0..<data.count{
            if util[i]{
                util[i] = false
                output[depth] = data[i]
                permutate(data : &data, output: &output, util: &util, depth: depth + 1)
                util[i] = true
            }
        }
    }
}



print ("Data: \(data)")
var resultado = [Int].init(repeating: 0, count: data.count)
permutate(data: &data, output: &resultado, util : &valid)
//print ("Permutation: \()")

