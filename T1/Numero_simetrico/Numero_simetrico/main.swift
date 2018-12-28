//
//  main.swift
//  Numero_simetrico
//
//  Created by Juan Casado Ballesteros on 9/23/18.
//  Copyright © 2018 Juan Casado Ballesteros. All rights reserved.
//

import Foundation

func invertNumber (_ toInvert:UInt, startNumber invertedNumber:UInt=0) -> UInt{
    if toInvert == 0{
        return invertedNumber
    }
    return invertNumber(toInvert / 10, startNumber: invertedNumber*10+toInvert%10)
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
    print ("Insert a number to Invert (0 to exit)")
    guard let userInput = getNumber() else{
        print ("end")
        break
    }
    guard userInput > 0 else{
        print ("end")
        break
    }
    print(invertNumber(userInput))
}
