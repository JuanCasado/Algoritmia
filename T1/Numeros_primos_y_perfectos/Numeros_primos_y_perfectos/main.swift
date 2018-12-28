//
//  main.swift
//  Numeros_primos_y_perfectos
//
//  Created by Juan Casado Ballesteros on 9/22/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

func isA (perfect_prime number:UInt) -> (prime: Bool,perfect :Bool){
    switch number {
    case 1:
        return (false,false)
    case 2:
        return (true,false)
    default:
        var acc:UInt = 0
        var isPrime:Bool = true
        for possibleDivisor in 2..<number{
            if number % possibleDivisor == 0{
                acc += possibleDivisor
                isPrime = false
            }
        }
        return (isPrime,number == (acc+1))
    }
}

func getNumber () -> UInt?{
    guard let input = readLine() else{
        print("I/O ERROR")
        return nil
    }
    guard let number = UInt(input) else{
        print("Input is not a positive number")
        return nil
    }
    return number
}

var primes:UInt
var perfects:UInt
while true{
    print ("Insert a number to calculate primeas and perfects from 0 to it (0 to exit)")
    guard let userInput = getNumber() else{
        print ("end")
        break
    }
    guard userInput > 0 else{
        print ("end")
        break
    }
    primes = 0
    perfects = 0
    for toCheck in 1...userInput{
        let result = isA(perfect_prime:toCheck)
        if result.prime{
            primes += 1
        }
        if result.perfect{
            perfects += 1
        }
    }
    print ("Hasta \(userInput) hay:\n\t\(primes) Numeros primos\n\t\(perfects) Numeros perfectos")
}

