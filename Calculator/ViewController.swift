//
//  ViewController.swift
//  Calculator
//
//  Created by Jorge Gallardo on 8/19/15.
//  Copyright © 2015 Jorge Gallardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var decimalPoint: UIButton!
    var userIsInTheMiddleOfTypingANumber = false
    var numbersArray = [Double]()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func numberPress(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." {
                display.text! += digit
                decimalPoint.enabled = false
            } else {
                display.text! += digit
            }
        } else {
            display.text = digit
            if digit == "." {
                decimalPoint.enabled = false
            }
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        decimalPoint.enabled = true
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
            case "×": performOperation({ (op1: Double, op2: Double) -> Double in
                return op1 * op2
            })
            
            case "÷": performOperation({ (op1, op2) in return op2 / op1 })
            
            case "−": performOperation({$1 - $0})
            
            case "+": performOperation() {$0 + $1} // or performOperation {$0+S1} because there are no other arguments
            
            case "√": performOperation { sqrt($0) }
            
            case "sin": performOperation { sin($0) }
            
            case "cos": performOperation { cos($0) }
            
            default: break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if numbersArray.count >= 2 {
            displayValue = operation(numbersArray.removeLast(), numbersArray.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if numbersArray.count >= 1 {
            displayValue = operation(numbersArray.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() { // no arguments because there's only 1 enter key
        userIsInTheMiddleOfTypingANumber = false
        decimalPoint.enabled = true
        numbersArray.append(displayValue)
        print(numbersArray)
    }
}