//
//  main.swift
//  Descender un valle
//
//  Created by Juan Casado Ballesteros on 10/28/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var domain = [Int]()
domain.append(Int.random(in: 500...600))
for _ in 0...Int.random(in: 5...15){
    domain.append(domain.last!-Int.random(in: 10...30))
}
for _ in 0...Int.random(in: 5...15){
    domain.append(domain.last!+Int.random(in: 10...30))
}

print(domain)

func gradienDescend (in data : [Int], offset :Int = 0) -> Int {
    let index = (data.count-1) / 2
    if data.count == 1 {
        return offset
    }else if data.count == 2{
        if data[0] > data [1]{
            return offset + 1
        } else {
            return offset
        }
    }else if data[index-1] < data[index] {
        return gradienDescend(in: Array<Int>(data[0..<index]), offset: offset)
    } else {
        return gradienDescend(in: Array<Int>(data[index..<data.count]), offset: offset+index)
    }
}

print("Minimo en posición: \(gradienDescend(in: domain))")

