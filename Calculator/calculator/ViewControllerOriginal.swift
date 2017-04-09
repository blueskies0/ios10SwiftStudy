//
//  ViewControllerOriginal.swift
//  calculator
//
//  Created by Yin on 3/19/17.
//  Copyright © 2017 Ting Yin. All rights reserved.
//
import UIKit

class ViewControllerOriginal: UIViewController {
    
    
    
    @IBOutlet weak var display: UILabel!
    
    
    var typping: Bool = false
    
    @IBAction func appendD(_ sender: UIButton) {
        if (typping == false)
        {
            typping = true
            display.text = sender.currentTitle!
        }
        else
        {
            
            // Equals to
            //display.text!.append(sender.currentTitle!)
            let digit = sender.currentTitle!
            display.text = display.text! + digit
        }
        
    }
    var digits = Array<Double>()
    
    @IBAction func enter1() {
        
        digits.append(displayValue)
        print("digits = \(digits)")
        typping = false
        
        
    }
    // computered property
    var displayValue: Double {
        get{
            return NumberFormatter().number( from: display.text!)!.doubleValue
        }
        set{
            // convert sth to string via "\(sth)"
            display.text = "\(newValue)"
            typping = false
        }
    }
    
    func multiply(d1 : Double, d2 : Double) -> Double {
        return d1 * d2
    }
    func minus(d1 : Double, d2 : Double) -> Double {
        return d1 - d2
    }
    func divide(d1 : Double, d2 : Double) -> Double {
        return d1 / d2
    }
    func add(d1 : Double, d2 : Double) -> Double {
        return d1 + d2
    }
    
    @IBAction func operate(_ sender: UIButton) {
        
        if typping {
            enter1()
        }
        
        // Mechod1 :
        //performoperation(sender.currentTitle!)
        // Mechod2 : Use function as parameter
        // see performOperation2
        //
        switch sender.currentTitle! {
        case "√":
            performOperation2_1({sqrt($0)})
        case "+":
            // 1.
            //performOperation2(add)
            // 2. inline the add function to simplipy
            performOperation2({$0 + $1})
            // 3. if it is the last parameter, it could be placed out of the parameters(), and left other parameters still inside (),such as
            //performOperation2(){$0 + $1}
            // 4. more over, if it is the only parameter, you could skip () totally, like following:
            //performOperation2 {$0 + $1}
            
        case "−":
            
            //performOperation2(minus)
            performOperation2({$0 - $1})
        case "×":
            
            //performOperation2(multiply)
            performOperation2({$0 * $1})
            
        case "÷":
            
            //performOperation2(divide)
            performOperation2({$0 / $1})
            
        default: break
        }
    }
    func performOperation2(_ operation : (Double, Double) -> Double){
        if digits.count >= 2 {
            displayValue = operation(digits.removeLast(),digits.removeLast())
            enter1()
        }
    }
    
    func performOperation2_1(_ operation : (Double) -> Double){
        if digits.count >= 1 {
            displayValue = operation(digits.removeLast())
            enter1()
        }
    }
    
    func performoperation(_ calOperator : String) {
        if digits.count < 2 {
            return
        }
        
        switch calOperator {
        case "+":
            
            displayValue = digits.removeLast() + digits.removeLast()
            
        case "−":
            
            displayValue = digits.removeLast() - digits.removeLast()
            
        case "×":
            
            displayValue = digits.removeLast() * digits.removeLast()
            
            
        case "÷":
            
            displayValue = digits.removeLast() / digits.removeLast()
            
            
        default: break
        }
        enter1()
    }
    
}


