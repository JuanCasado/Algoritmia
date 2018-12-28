//
//  main.swift
//  Minimo en vector
//
//  Created by Juan Casado Ballesteros on 10/25/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

let inicioIntervalo = 14
let finIntervalo = 12
let valorMinimo = 3
let precision = 3

let target = 10

func createDomain () -> [Int]? {
    guard (inicioIntervalo > valorMinimo) || (finIntervalo > valorMinimo) else {
        return nil
    }
    var domain = [Int]()
    var newValue = inicioIntervalo;
    domain.append(newValue)
    while newValue > valorMinimo {
        newValue -= precision
        domain.append(newValue)
    }
    while newValue < finIntervalo {
        newValue += precision
        domain.append(newValue)
    }
    domain.append(finIntervalo)
    return domain
}

func splitMin(of data: [Int]) -> (min :Int,index :Int){
    var values = ArraySlice<Int>.init(data)
    let count = values.count
    let half = count/2
    var hash = [Int]()
    for index in 0..<half{                           //Se realizan comparaciones con 1/3 de los valores
        let opposite_index = count-1-index
        if (values[index] < values[opposite_index]){
            values.swapAt(index, opposite_index)
            hash.append(index)
        }else{
            hash.append(opposite_index-half)
        }
    }
    let min = findMin(of : Array(values[half..<values.count]))
    return (min.min, hash[min.index])
}

func findMin(of values: [Int]) -> (min :Int, index :Int) {
    var min = values.first!
    var minIndex = 0
    for (index,value) in values.enumerated(){
        if (value < min){
            minIndex = index
            min = value
        }
    }
    return (min, minIndex)
}

func binarySearch (of key :Int, in data :[Int], offset :Int = 0, minFirst :Bool) -> Int {
    let midIndex = Int((data.count-1)/2)
    let midValue = data[midIndex]
    //print ("\(key), \(data), \(offset), \(midIndex), \(midValue)")
    if midValue == key {
        return midIndex + offset
    } else if data.count == 1{
        return midIndex + offset
    } else {
        if (minFirst){
            if (midValue > key){
                return binarySearch(of: key, in: Array<Int>(data[0..<midIndex]), offset: offset, minFirst: minFirst)
            } else {
                return binarySearch(of: key, in: Array<Int>(data[midIndex..<data.count]), offset: offset+midIndex, minFirst: minFirst)
            }
        }else {
            if (midValue < key){
                return binarySearch(of: key, in: Array<Int>(data[0..<midIndex]), offset: offset, minFirst: minFirst)
            } else {
                return binarySearch(of: key, in: Array<Int>(data[midIndex..<data.count]), offset: offset+midIndex, minFirst: minFirst)
            }
        }
    }
}

func enRange (key : Int, target :Int,  over data : [Int], minFirst :Bool) -> [Int]{
    if data[key] == target{
        return [key]
    } else {
        if minFirst{
            if data[key] > target {
                return [key-1, key]
            }else {
                return [key, key+1]
            }
        } else {
            if data[key] > target {
                return [key, key+1]
            }else {
                return [key-1, key]
            }
        }
    }
}


if let domain = createDomain(){
    print (domain)
    let minIndex = splitMin(of: [Int](domain)).index
    if minIndex == 0{
        print(enRange(key: binarySearch(of: target, in: domain, minFirst: true), target: target, over: domain, minFirst: true))
    } else if(minIndex == (domain.count-1)){
        print(enRange(key: binarySearch(of: target, in: domain, minFirst: false), target: target, over: domain, minFirst: false))
    } else {
        print(enRange(key: binarySearch(of: target,  in: Array<Int>(domain[0..<minIndex]), minFirst: false), target: target, over: domain, minFirst: false))
        print(enRange(key: binarySearch(of: target,  in: Array<Int>(domain[minIndex..<domain.count]), offset: minIndex, minFirst: true), target: target, over: domain, minFirst: true))
    }
}else{
    print ("Values of domain not correct")
}







