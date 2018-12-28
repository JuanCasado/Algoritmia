//
//  main.swift
//  Posición igual a valor
//
//  Created by Juan Casado Ballesteros on 10/28/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var domain = [Int]()
domain.append(-Int.random(in: 3...7))
for _ in 0...Int.random(in: 5...15){
    domain.append(domain.last! + Int.random(in: 1...3))
}
//domain = [-3, 0, 1, 3, 5, 7, 8, 10, 11, 13, 15]
//domain = [-3, -2, 0, 1, 4, 6, 8, 9, 12, 14, 15, 18, 21]
print (domain)

func binaryIndex (over data: [Int], offset: Int = 0) -> Int?{
    let index = Int((data.count-1)/2)
    //print (data)
    //print (offset)
    if data[index] == index+offset {
        return offset
    }else if data.count == 1{
        return nil
    }else if data[index] < index{
        return binaryIndex(over: Array<Int>(data[index+1..<data.count]), offset: offset+1+index)
    }else{
        return binaryIndex(over: Array<Int>(data[0...index]), offset: offset)
    }
}
print (binaryIndex(over: domain) as Any)

