//
//  ViewController.swift
//  JZ'sFirstiOSProject
//
//  Created by Jerry Zhang on 2017/7/15.
//  Copyright © 2017年 Jerry Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numDisplay: UILabel!
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get{
            return Double(numDisplay.text!)!
        }
        set{
            numDisplay.text = String(newValue)
        }
    }
    
    @IBAction func digittouched(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let currentlyDisplay = numDisplay.text!
            numDisplay.text = currentlyDisplay + digit
        }else {
            numDisplay.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private var brain:calculatorBrain = calculatorBrain()
    @IBAction func operationtouched(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperations(mathematicalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
}
