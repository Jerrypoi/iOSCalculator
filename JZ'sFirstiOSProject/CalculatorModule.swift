//
//  CalculatorModule.swift
//  JZ'sFirstiOSProject
//
//  Created by Jerry Zhang on 2017/8/9.
//  Copyright © 2017年 Jerry Zhang. All rights reserved.
//

import Foundation

struct calculatorBrain {
    private enum Operations {
        case constant(Double)
        case unaryOperation((Double)-> (Double))
        case binaryOperation((Double , Double)->(Double))
        case equal
    }
    

    
    private var accumulator: Double?
    private let operationSymbols: Dictionary<String , Operations>=[
        "π"   :Operations.constant(Double.pi),
        "sin" :Operations.unaryOperation(sin),
        "cos" :Operations.unaryOperation(cos),
        "√"   :Operations.unaryOperation(sqrt),
        "✕"   :Operations.binaryOperation( {$0 * $1 }),
        "-"   :Operations.binaryOperation( { $0 - $1 }),
        "÷"   :Operations.binaryOperation( { $0 / $1 }),
        "+"   :Operations.binaryOperation( { $0 + $1 }),
        "="   :Operations.equal
    ]
    
    mutating func performOperations(_ sysmbol:String){
        if let operation = operationSymbols[sysmbol]{
            switch operation{
            case .constant(let  value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    onGoingBinaryOperation = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equal:
                performBinaryOperation()
            }
        }
    }
    private mutating func performBinaryOperation(){
        if onGoingBinaryOperation != nil && accumulator != nil{
            accumulator = onGoingBinaryOperation!.performOperation(with: accumulator!)
            onGoingBinaryOperation = nil
            
        }
    }
    
    
    private var onGoingBinaryOperation: pendingBinaryOperation?
    
    private struct pendingBinaryOperation{
        let function: (Double , Double) -> Double
        let firstOperand: Double
        
        func performOperation(with secondOperand:Double) -> Double{
            return function(firstOperand , secondOperand)
        }
        
    }
    
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
}
