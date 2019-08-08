//
//  CalculateViewController.swift
//  Calculeta
//
//  Created by Mac on 3.08.2019.
//  Copyright © 2019 Varol. All rights reserved.
//

import Cocoa

class CalculateViewController: NSViewController {

    @IBOutlet weak var resultLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "x"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValueStr = ""
    var result = ""
    var isMax = false
    var resultsArray = [String]()
    let label = NSTextField(frame: CGRect(x: 0, y: 248, width: 225, height: 100))

    @IBAction func terminateButton(_ sender: Any) {
        exit(1)
        
    }
    
    @IBAction func historyButton(_ sender: Any) {
         if isMax == false {
            view.bounds.size.height += 100
            label.isSelectable = true
            label.alignment = .right
            label.stringValue = "0"
            self.view.addSubview(label)
            isMax = true
        } else {
            view.bounds.size.height -= 100
            isMax = false
        }
        label.stringValue = resultsArray.joined(separator: "\n")

    }
    
    
    
    
    
    @IBAction func buttonPressed(_ sender: NSButton) {
        if resultLabel.stringValue == "0" || resultLabel.stringValue == "x" || resultLabel.stringValue == "-" || resultLabel.stringValue == "+" || resultLabel.stringValue == "/"{
            resultLabel.stringValue = ""
        }
        resultLabel.uzunlukAyarla()
        runningNumber += "\(sender.tag)"
        resultLabel.stringValue = runningNumber
    }
    
    @IBAction func commaButton(_ sender: Any) {
        
        if !resultLabel.stringValue.contains(".") {
            if resultLabel.stringValue == "0" {
                runningNumber += "0."
                resultLabel.stringValue = runningNumber
            } else {
                runningNumber += "."
                resultLabel.stringValue = runningNumber
            }
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if resultLabel.stringValue != "0" {
            currentOperation = .Empty
            processOperation(operation: .Add)
            resultLabel.stringValue = currentOperation.rawValue

        }
    }
    
    @IBAction func subtractButton(_ sender: Any) {
        if resultLabel.stringValue != "0" {
            currentOperation = .Empty
            processOperation(operation: .Subtract)
            resultLabel.stringValue = currentOperation.rawValue
         }
    }
    
    @IBAction func multiplyButton(_ sender: Any) {
        if resultLabel.stringValue != "0" {
            currentOperation = .Empty
            processOperation(operation: .Multiply)
            resultLabel.stringValue = currentOperation.rawValue
        }
    }
    
    @IBAction func divideButton(_ sender: Any) {
        
        if resultLabel.stringValue != "0" {
            currentOperation = .Empty
            processOperation(operation: .Divide)
            resultLabel.stringValue = currentOperation.rawValue
        }


    }
    
    @IBAction func clearButton(_ sender: Any) {
            currentOperation = .Empty
            resultLabel.stringValue = "0"
            runningNumber = ""
            leftValStr = ""
     }
    
    @IBAction func equalButton(_ sender: Any) {

        if leftValStr != "" {
            processOperation(operation: currentOperation)
            label.stringValue = resultsArray.joined(separator: "\n")
            ////////////////
        }
        label.stringValue = resultsArray.joined(separator: "\n")

    }

    
    
    func processOperation (operation : Operation) {

        if currentOperation != Operation.Empty {
            if runningNumber != ""{
                rightValueStr = runningNumber
                runningNumber = ""


                if currentOperation == Operation.Multiply {
 
                    
                        result = "\(Double(leftValStr)! * Double (rightValueStr)!)"
                        insertToArray(result: "\(leftValStr) \(currentOperation.rawValue) \(rightValueStr) = \(result)")
                        
                        leftValStr = ""

                  
                    

                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double (rightValueStr)!)"
                    insertToArray(result: "\(leftValStr) \(currentOperation.rawValue) \(rightValueStr) = \(result)")

                    leftValStr = ""

                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double (rightValueStr)!)"
                    insertToArray(result: "\(leftValStr) \(currentOperation.rawValue) \(rightValueStr) = \(result)")

                    leftValStr = ""

                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double (rightValueStr)!)"
                    insertToArray(result: "\(leftValStr) \(currentOperation.rawValue) \(rightValueStr) = \(result)")

                    leftValStr = ""

                }
                
                leftValStr = result
                resultLabel.stringValue = result
                
            }
            currentOperation = operation
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }

        resultLabel.uzunlukAyarla()
    }
    
    
    func insertToArray(result: String){

        if resultsArray.count < 5 {
            resultsArray.append(result)
        } else {

            resultsArray.insert(result, at: 0)
            resultsArray.remove(at: 5)
         }

    }
    
 }





extension CalculateViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> CalculateViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("CalculateViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? CalculateViewController else {
            fatalError("Why cant i find CalculateViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

extension NSTextField {
    func uzunlukAyarla(){
        if self.stringValue.count > 8 {
            self.font = NSFont.systemFont(ofSize: 30)
        } else if self.stringValue.count < 8 {
            self.font = NSFont.systemFont(ofSize: 38)

        }
        
    }
}
