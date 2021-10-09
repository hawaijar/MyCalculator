//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Sushil Mayengbam on 05/10/21.
//

import Foundation

func multiply(a: Double, b: Double) -> Double {
    return a * b
}
func sum(a: Double, b: Double) -> Double {
    return a + b
}

class CalculatorBrain {
    private var accumulator = 0.0
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    var operations: Dictionary<String, Operation> = [
        "∏": Operation.Constant(Double.pi),
        "√": Operation.UnaryOperation(sqrt),
        "×": Operation.BinaryOperation(multiply),
        "+": Operation.BinaryOperation(sum),
        "−": Operation.BinaryOperation({$0 - $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "=": Operation.Equals
    ]
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                
            case .Equals:
                executePendingOperation()
            }
        }
    }
    
    func executePendingOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
