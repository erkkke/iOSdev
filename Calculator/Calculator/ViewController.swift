//
//  ViewController.swift
//  Calculator
//
//  Created by Erkebulan on 01.02.2021.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
    var typing = false
    var isDot = false
    
    private var calculatorModel = CalculatorModel()
    
    @IBOutlet weak var myDisplay: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func NumberButton(_ sender: UIButton) {
        clearButton.setTitle("C", for: .normal)
        let currentDigit = sender.currentTitle!
        if typing {
            myDisplay.text! += currentDigit
        }
        else {
            myDisplay.text = currentDigit
            typing = true
        }
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if !isDot {
            if (!typing) {
                myDisplay.text! = "0."
            }
            else {
                myDisplay.text! += sender.currentTitle!
            }
            typing = true
            isDot = true
        }
    }

    var displayValue: Double {
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text = String(newValue)
        }
    }
    
    @IBAction func operationButton(_ sender: UIButton) {
        
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.result!
        
        if calculatorModel.isCleared {
                    clearButton.setTitle("AC", for: .normal)
                }
        typing = false
        isDot = false
            }
    
    
}

