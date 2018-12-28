//
//  main.swift
//  Ordenar_en_base_a_otro
//
//  Created by Juan Casado Ballesteros on 11/8/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var domain = [Int]()
var hash = [Int]()
for _ in 0...Int.random(in: 5...13){
    domain.append(Int.random(in: 1...50))
}
for index in 0..<domain.count{
    hash.append(index)
}

func merge (_ fragment1 :[Int],_ fragment2 :[Int])->[Int]{
    var merged = [Int]()
    var fragment1_index = 0
    var fragment2_index = 0
    for _ in 0..<(fragment1.count + fragment2.count){
        if fragment1_index >= fragment1.count{
            merged.append(fragment2[fragment2_index])
            fragment2_index += 1
        } else if fragment2_index >= fragment2.count{
            merged.append(fragment1[fragment1_index])
            fragment1_index += 1
        } else {
            if fragment1[fragment1_index] < fragment2[fragment2_index] {
                merged.append(fragment1[fragment1_index])
                fragment1_index += 1
            } else {
                merged.append(fragment2[fragment2_index])
                fragment2_index += 1
            }
        }
    }
    return merged
}

func short (_ matrix :[Int]) -> [Int]{
    var matrix = matrix
    if matrix.count == 1{
        return matrix
    } else if matrix.count == 2{
        if matrix[0] > matrix[1]{
            matrix.swapAt(0, 1)
        }
        return matrix
    }
    return merge (short(Array<Int>(matrix[0..<matrix.count/2])),short(Array<Int>(matrix[matrix.count/2..<matrix.count])))
}

func merge_has (_ fragment1 :[Int],_ fragment2 :[Int])->[Int]{
    var merged = [Int]()
    var fragment1_index = 0
    var fragment2_index = 0
    for _ in 0..<(fragment1.count + fragment2.count){
        if fragment1_index >= fragment1.count{
            merged.append(fragment2[fragment2_index])
            fragment2_index += 1
        } else if fragment2_index >= fragment2.count{
            merged.append(fragment1[fragment1_index])
            fragment1_index += 1
        } else {
            if domain[fragment1[fragment1_index]] < domain[fragment2[fragment2_index]] {
                merged.append(fragment1[fragment1_index])
                fragment1_index += 1
            } else {
                merged.append(fragment2[fragment2_index])
                fragment2_index += 1
            }
        }
    }
    return merged
}

func short_has (_ matrix :[Int]) -> [Int]{
    var matrix = matrix
    if matrix.count == 1{
        return matrix
    } else if matrix.count == 2{
        if domain[matrix[0]] > domain[matrix[1]]{
            matrix.swapAt(0, 1)
        }
        return matrix
    }
    return merge_has (short_has(Array<Int>(matrix[0..<matrix.count/2])),short_has(Array<Int>(matrix[matrix.count/2..<matrix.count])))
}

print (domain)
print (short(domain))
print (short_has(hash))






