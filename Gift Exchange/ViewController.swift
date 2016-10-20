//
//  ViewController.swift
//  Gift Exchange
//
//  Created by Greg Willis on 10/17/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterYourNameImage: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var textField7: UITextField!
    @IBOutlet weak var textField8: UITextField!
    @IBOutlet weak var textField9: UITextField!
    @IBOutlet weak var textField10: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    
    //MARK: - Variables
    var namesEntered = [String]()
    var namesArray = [String]()
    var results: String = ""
    var index = Int()
    var textInTextFieldCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func randomizeButtonPressed(_ sender: AnyObject) {
        putNamesInArray()
        if entriesAreValid() {
            clearTextFields()
            randomizeNames()
            showResults()
        } else {
           resetEverything()
        }
        
        
    }

    @IBAction func addMoreButtonPressed(_ sender: AnyObject) {
        putNamesInArray()
    }
    
    @IBAction func startOverButtonPressed(_ sender: AnyObject) {
        resetEverything()
    }
    
    func putNamesInArray()  {
        if let textField1Text = textField1.text {
            if textField1.hasText {
                namesEntered.append(textField1Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField2Text = textField2.text {
            if textField2.hasText {
                namesEntered.append(textField2Text)
                textInTextFieldCount += 1
            }
            
        }
        
        if let textField3Text = textField3.text {
            if textField3.hasText {
                namesEntered.append(textField3Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField4Text = textField4.text {
            if textField4.hasText {
                namesEntered.append(textField4Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField5Text = textField5.text {
            if textField5.hasText {
                namesEntered.append(textField5Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField6Text = textField6.text {
            if textField6.hasText {
                namesEntered.append(textField6Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField7Text = textField7.text {
            if textField7.hasText {
                namesEntered.append(textField7Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField8Text = textField8.text {
            if textField8.hasText {
                namesEntered.append(textField8Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField9Text = textField9.text {
            if textField9.hasText {
                namesEntered.append(textField9Text)
                textInTextFieldCount += 1
            }
        }
        
        if let textField10Text = textField10.text {
            if textField10.hasText {
                namesEntered.append(textField10Text)
                textInTextFieldCount += 1
            }
        }
        
        namesArray = namesEntered
        
        print(namesEntered)
        print(namesArray)
    }
    
    func randomizeNames() {
        for name in namesEntered {
            let randomName = getRandomName(name: name)
            results += "\(name) buys for \(randomName) \n"
            removeNameFromArray()
        }
        print(results)
    }
    
    func getRandomName(name: String) -> String {
        let setName = name
        var randomName = namesArray[getIndex()]
        
        while namesMatch(name: setName, randomName: randomName) {
            randomName = getRandomName(name: name)
        }
        return randomName
    }
    
    func getIndex() -> Int {
        index = Int(arc4random_uniform(UInt32(namesArray.count)))
        return index
    }
    
    func removeNameFromArray() {
        namesArray.remove(at: index)
    }
    
    func namesMatch(name: String, randomName: String) -> Bool {
        if name == randomName {
            return true
        } else {
            return false
        }
    }
    
    func showResults() {
        resultsLabel.isHidden = false
        resultsLabel.text = results
        resultsLabel.numberOfLines = 0
        resultsLabel.sizeToFit()
        enterYourNameImage.isHidden = true
        textField1.isHidden = true
        textField2.isHidden = true
        textField3.isHidden = true
        textField4.isHidden = true
        textField5.isHidden = true
        textField6.isHidden = true
        textField7.isHidden = true
        textField8.isHidden = true
        textField9.isHidden = true
        textField10.isHidden = true
        randomizeButton.isHidden = true
        addMoreButton.isHidden = true
        startOverButton.isHidden = false
    }
    
    func resetEverything() {
        resultsLabel.isHidden = true
        resultsLabel.text = ""
        enterYourNameImage.isHidden = false
        textField1.isHidden = false
        textField2.isHidden = false
        textField3.isHidden = false
        textField4.isHidden = false
        textField5.isHidden = false
        textField6.isHidden = false
        textField7.isHidden = false
        textField8.isHidden = false
        textField9.isHidden = false
        textField10.isHidden = false
        randomizeButton.isHidden = false
        addMoreButton.isHidden = false
        startOverButton.isHidden = true
        
        namesEntered = []
        namesArray = []
        results = ""
        textInTextFieldCount = 0
    }
    
    func clearTextFields() {
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        textField5.text = ""
        textField6.text = ""
        textField7.text = ""
        textField8.text = ""
        textField9.text = ""
        textField10.text = ""
    }
    
    func entriesAreValid() -> Bool {
        if textInTextFieldCount <= 1 {
            // Pop up warning message
            return false
        }
        
        if textInTextFieldCount == 2 {
            if areAnyNamesTheSame() {
                // Pop up warning message
                return false
            }
        }
        return true
    }
    
    func areAnyNamesTheSame() -> Bool {
        for name in namesEntered {
            var x = 1
            repeat {
                if name == namesEntered[x] {
                    return true
                }
                
                x += 1
            } while x <= namesEntered.count;
        }
        return false
    }
    
// MARK: - TODO - Add protection for case "only one name entered", "two names entered that are the same"
//    - Fix scroll view to actually scroll
//    - Correct constraints
}

