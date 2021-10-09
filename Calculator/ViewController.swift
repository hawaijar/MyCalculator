//
//  ViewController.swift
//  Calculator
//
//  Created by Sushil Mayengbam on 05/10/21.
//

import UIKit

class ViewController: UIViewController {
    private var userIsInTheMiddleOfTyping: Bool = false
    @IBOutlet private weak var display: UILabel!
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }
    
    private var displayValue:Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.titleLabel!.text!
        
        if digit == "C" {
            display.text = "0"
            userIsInTheMiddleOfTyping = false
            return
        }
        
        if userIsInTheMiddleOfTyping {
            let currentDisplay = display.text!
            display.text = currentDisplay + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if let mathOperator = sender.titleLabel!.text {
            brain.setOperand(operand: displayValue)
            brain.performOperation(symbol: mathOperator)
            displayValue = brain.result
            userIsInTheMiddleOfTyping = false
        }
    }
}

