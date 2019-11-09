//
//  ViewController.swift
//  Calculator
//
//  Created by Steve Vovchyna on 03.11.2019.
//  Copyright © 2019 Steve Vovchyna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var left : Int = 0
    var right : Int = 0
    var operation : String = ""
    var newNumber : Bool = true

    @IBOutlet weak var onscreenNumbers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberTapped(_ sender: UIButton) {
        print("Button pressed: \(sender.tag)")
        if newNumber || onscreenNumbers.text! == "0" {
            onscreenNumbers.text! = String(sender.tag)
            right = Int(onscreenNumbers.text!) ?? 1
            newNumber = false
        } else {
            onscreenNumbers.text! += String(sender.tag)
            right = Int(onscreenNumbers.text!) ?? 1
        }
    }
    
    @IBAction func allClear(_ sender: Any) {
        print("Label cleared!")
        onscreenNumbers.text! = "0"
        left = 0
        right = 0
        operation = ""
    }
    
    @IBAction func setNegativeNumber(_ sender: Any) {
        if let i = onscreenNumbers.text!.firstIndex(of: "-") {
            onscreenNumbers.text!.remove(at: i)
            print("Value set to positive")
        } else {
            if onscreenNumbers.text! != "0" {
                onscreenNumbers.text! = "-\(onscreenNumbers.text!)"
                print("Value set to negative")
            }
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        left = Int(onscreenNumbers.text!) ?? 0
        newNumber = true
        print("Operation chosen: \(sender.tag). left = \(left). right = \(right)")
        switch sender.tag {
        case 0:
            operation = "plus"
        case 1:
            operation = "minus"
        case 2:
            operation = "multiply"
        case 3:
            operation = "divide"
        default:
            operation = ""
            print("Nothing chosen")
        }
    }
   
    @IBAction func result(_ sender: UIButton) {
        newNumber = true
        let result = calculator()
        print("Result: \(result). Right: \(right). Left: \(left). operation: \(operation)")
        if result == "Error" {
            onscreenNumbers.text! = "Error"
        } else {
            onscreenNumbers.text! = result
            left = Int(result)!
        }
    }
    
    func calculator() -> String {
        switch operation {
        case "plus":
            return String(left + right)
        case "minus":
            return String(left - right)
        case "multiply":
            return String(left * right)
        case "divide":
            return right == 0 ? "Error" : String(left / right)
        case "":
            return String(right)
        default:
            print("error")
            return "Error"
        }
    }
    
}

