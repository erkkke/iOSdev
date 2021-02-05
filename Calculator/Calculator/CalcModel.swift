//
//  CalcModel.swift
//  Calculator
//
//  Created by Erkebulan on 01.02.2021.
//

import Foundation

var isSaved = false

enum Operations {
    case constants(Double)
    case unaryOperation((Double)-> Double)
    case binaryOperation((Double, Double)-> Double)
    case equals
    case clear
}

func percent(number: Double)-> Double {
    let number1 = saving?.firstNumber
    if number1 != nil && isSaved{
        return number1! * (number / 100)
    }
    else {
        return number / 100
    }
}

struct CalculatorModel {
    private var globalValue: Double?!
    var isCleared = false

    var operationsDict: Dictionary<String, Operations> =
    [
        "AC": Operations.constants(0),
        "C": Operations.clear,
        "%": Operations.unaryOperation(percent),
        "+/-": Operations.unaryOperation({$0*(-1)}),
        "+": Operations.binaryOperation({$0+$1}),
        "-": Operations.binaryOperation({$0-$1}),
        "×": Operations.binaryOperation({$0*$1}),
        "÷": Operations.binaryOperation({$0/$1}),
        "=": Operations.equals
    ]
    
    mutating func setOperand(_ number: Double) {
        globalValue = number

    }
    
    mutating func performOperation(_ operation: String) {
        
        
        let symbol = operationsDict[operation]!

        switch symbol {
        case .constants(let value):
            globalValue = value
            saving = nil
            isSaved = false
            
            
        case .unaryOperation(let function):
            globalValue = function(globalValue!)
            
        case .binaryOperation(let function):
            if (!isSaved) {
                isSaved = true
            }
            else {
                doBinaryOperation()
            }
            saving = SaveFirstNumberAndOperation(firstNumber: globalValue!, operation: function)


        case .equals:
            if ((saving?.firstNumber) != nil) {
                doBinaryOperation()
                isSaved = false
            }
        
        case .clear:
            isCleared = true
            globalValue = 0
        }
    }
    
    var result: Double? {
        get {
                return globalValue
        }
    }
    
    mutating func doBinaryOperation() {
        globalValue = saving?.performOperationWith(secondNumber: globalValue!)
    }
}


private var saving: SaveFirstNumberAndOperation?

struct SaveFirstNumberAndOperation {
    var firstNumber: Double
    var operation: (Double, Double)-> Double
    
    func performOperationWith(secondNumber number2: Double)-> Double {
        return operation(firstNumber, number2)
    }

}
