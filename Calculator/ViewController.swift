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
    var userIsTypingNumber = false
    var numbersArray = [Double]()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTypingNumber = false
        }
    }
    
    @IBAction func numberPress(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTypingNumber {
            display.text! += digit
        } else {
            display.text = digit
            userIsTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsTypingNumber {
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
        userIsTypingNumber = false
        
        numbersArray.append(displayValue)
        print(numbersArray)
    }
}