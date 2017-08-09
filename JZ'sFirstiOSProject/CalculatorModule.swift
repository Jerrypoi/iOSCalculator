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
    }
    
    private var accumulator: Double?
    private let operationSymbols: Dictionary<String , Operations>=[
        "π"   :Operations.constant(Double.pi),
        "sin" :Operations.unaryOperation(sin),
        "cos" :Operations.unaryOperation(cos),
        "√"   :Operations.unaryOperation(sqrt)
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
            }
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
