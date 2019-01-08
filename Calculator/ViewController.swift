//
//  ViewController.swift
//  Calculator
//
//  Created by formation3 on 28/11/2018.
//  Copyright © 2018 formation3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var clearLabel : Bool = false
    var selectDot : Bool = false
    var previousValue : Double = 0
    var resultCalcul : Double = 0
    var selectOperator : String?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onDigitTapped(_ sender: UIButton) {
        
        guard let stringDigit = sender.titleLabel?.text else {
            print("The button as no label !")
            return
        }
        
        guard let _ = Double(stringDigit) else {
            print("The button as no digit value, check if it's not a operator")
            return
        }
        
        if clearLabel == false {
            label.text? = ""
            label.text?.append(stringDigit)
            clearLabel = true
        } else {
            label.text?.append(stringDigit)
        }
    }
    
    @IBAction func onSelectOperator(_ sender: UIButton){
        
        guard let stringOperator = sender.titleLabel?.text else {
            print("The button as no label !")
            return
        }
        
        selectOperator = stringOperator
        previousValue = Double(label.text ?? "0") ?? 0
        label.text? = "0"
        clearLabel = false
        selectDot = false
    }
    
    
    @IBAction func onCalculOperator(_ sender: UIButton) {
        
        guard let _ = sender.titleLabel?.text else {
            print("The button as no label !")
            return
        }
        guard let stringLabelValue = label.text else{
            print("The label isn't not used")
            return
        }
        guard let doubleLabelValue = Double(stringLabelValue) else {
            print("Label haven't number on text")
            return
        }
        
        switch selectOperator {
        case "+":
            resultCalcul = previousValue + doubleLabelValue
            break
        case "-":
            resultCalcul = previousValue - doubleLabelValue
            break
        case "x":
            resultCalcul = previousValue * doubleLabelValue
            break
        case "/":
            if doubleLabelValue == 0 {
                let alert = UIAlertController(title: "ERROR", message: "You can't divide by zero", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.show(alert, sender: self)
            } else {
                resultCalcul = previousValue / doubleLabelValue
            }
            break
        default:
            resultCalcul = 0
        }
        
        label.text? = String(resultCalcul)
        previousValue = resultCalcul
    }
    
    
    @IBAction func clearCalcul(_ sender: UIButton) {
        
        guard let _ = sender.titleLabel?.text else {
            print("The button as no label !")
            return
        }
        
        previousValue = 0
        label.text? = "0"
        clearLabel = false
        selectOperator = nil
        selectDot = false
    }
    
    @IBAction func addDot(_ sender: UIButton) {
        
        guard let stringDot = sender.titleLabel?.text else {
            print("The button as no label !")
            return
        }
        
        if selectDot == false {
            label.text?.append(stringDot)
            selectDot = true
            clearLabel = true
        } else {
            print("Can't add two dots on number")
        }
    }
}

