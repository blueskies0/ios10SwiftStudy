//
//  ViewController.swift
//  calculator
//
//  Created by Ting Yin on 4/3/2017.
//  Copyright © 2017 Ting Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



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
    var brain = CalculatorBrain()
    
    @IBAction func enter1() {
        
        brain.pushOperand(displayValue)
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
    
    
    @IBAction func operate(_ sender: UIButton) {
        
        if typping {
            enter1()
        }
        //displayValue = brain.preformOperation(sender.currentTitle!)
        let temp = brain.preformOperation(sender.currentTitle!)
        if temp != nil {
            displayValue = temp!
        }
        else {
            //displayValue = nil
            display.text = "nil"
            typping = false
        }
 }

}
