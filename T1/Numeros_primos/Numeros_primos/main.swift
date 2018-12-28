//
//  main.swift
//  Algoritmia_Tema1_Ej1
//
//  Created by Juan Casado Ballesteros on 9/19/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

func isPrime (_ number:UInt) -> Bool{
    if number <= 2{
        return true
    }
    for possibleDivisor in 2...UInt(sqrt(Double(number))) {
        if (number%possibleDivisor == 0){
            return false;
        }
    }
    return true;
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

while true{
    print ("Insert a number to know if it is prime (0 to exit)")
    guard let userInput = getNumber() else{
        print ("end")
        break
    }
    guard userInput > 0 else{
        print ("end")
        break
    }
    if isPrime(userInput){
        print ("\(userInput) is a Prime")
    }else{
        print ("\(userInput) is not a Prime")
    }
}

