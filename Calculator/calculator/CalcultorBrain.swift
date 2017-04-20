//
//  CalcultorBrain.swift
//  calculator
//
//  Created by Yin on 3/18/17.
//  Copyright © 2017 Ting Yin. All rights reserved.
//

import Foundation
class CalculatorBrain {
    private enum op: CustomStringConvertible
    {
        case operand(Double)
        case unaryOperation(String, (Double) -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
        var description: String {
            get{
                    switch(self){
                        case .operand(let d):
                                return "\(d)"
                        case .unaryOperation(let str,_):
        
                                return str
        
                        case .binaryOperation(let str,_):
        
                                return str
                    }
                }
        }
    }
    private var opStack = [op]()
    private var knowOperation = Dictionary<String, op>()
    init(){
        knowOperation["+"] = op.binaryOperation("+",{$0+$1})
        knowOperation["−"] = op.binaryOperation("−",{$0-$1})
        knowOperation["×"] = op.binaryOperation("×", {$0*$1})
        knowOperation["÷"] = op.binaryOperation("÷", {$0/$1})
        knowOperation["√"] = op.unaryOperation("√", {sqrt($0)})
        
    }
    func preformOperation(_ operation: String) -> Double? {
        let ops = knowOperation[operation]
        if (ops != nil) {
            opStack.append(ops!)
        }
        //let (res, _) = evaluate(opStack)
        
        //return res
        //print("opstack = \(opStack)")
        let (result, remainingOps) = evaluate(opStack)
        print("(\(opStack) = \(result) + \(remainingOps)")
        return result
    }
    
    func pushOperand(_ operand: Double) {
        opStack.append(op.operand(operand))
        //print("opstack = \(opStack)")
    
    }
    private func evaluate(_ ops: [op]) -> (result: Double?, remainingOps: [op]) {
        var remainingOps = ops
        if ops.isEmpty {
            return (nil, remainingOps)
        }
        let cur = remainingOps.removeLast()
        switch cur {
        case .operand(let operand) :
            return (operand, remainingOps)
        
        case .unaryOperation(_, let operation) :
        
            let (fingure, ops1) = evaluate(remainingOps)
            if (fingure != nil) {
                let unaryReslut = operation(fingure!)
                return (unaryReslut, ops1)
            }
            else {
                return (nil, ops1)
            //ops1.pushback(unaryReslut)
            }
        case .binaryOperation(_, let operation) :
            let (fingure, ops1) = evaluate(remainingOps)
            // let binaryLReslut = fingure
            let (fingureR, ops2) = evaluate(ops1)
            if(fingure != nil && fingureR != nil) {
                let lRes = operation(fingure!, fingureR!)
                //ops2.pushBack(lRes)
                return (lRes, ops2)
            }
            else {
                return (nil, ops1)
                
            }
        }
    }
        
}
