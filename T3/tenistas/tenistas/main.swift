//
//  main.swift
//  tenistas
//
//  Created by Juan Casado Ballesteros on 11/13/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

var domain = [Int]()
let len = Int.random(in: 10...20)

for _ in 0...len{
    domain.append(Int.random(in: 1...50))
}

func divide (_ data : [Int]) -> [Int]{
    let midPoint = data.count/2
    if (data.count <= 2){
        return [data[0]+data[1]]
    }else{
        let firstHalf = divide(Array<Int>(data[0...midPoint]))
        let secondHalf = divide(Array<Int>(data[midPoint..<data.count]))
        let result = firstHalf+secondHalf
        return result
    }
}

func bestPartners (_ data : [Int]) -> (Int,(Int,Int)){
    let midPoint = data.count/2
    if (data.count <= 2){
        return (data[0]+data[1], (data[0], data[1]))
    }else{
        let firstHalf = bestPartners(Array<Int>(data[0...midPoint]))
        let secondHalf = bestPartners(Array<Int>(data[midPoint..<data.count]))
        if firstHalf.0 > secondHalf.0{
            return firstHalf
        }else{
            return secondHalf
        }
    }
}

print(domain)
//print(divide(domain))
print(bestPartners(domain))

