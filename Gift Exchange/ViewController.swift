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
    
    //MARK: - Variables
    var namesEntered = [String]()
    var namesArray = [String]()
    var results: String = ""
    var index = Int()
    
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
        randomizeNames()
        showResults()
        
    }

    @IBAction func addMoreButtonPressed(_ sender: AnyObject) {
    
    }
    
    func putNamesInArray()  {
        if let textField1Text = textField1.text {
            if textField1.hasText {
                namesEntered.append(textField1Text)
                textField1.text = ""
            } 
        }
        
        if let textField2Text = textField2.text {
            if textField2.hasText {
                namesEntered.append(textField2Text)
                textField2.text = ""
            }
            
        }
        
        if let textField3Text = textField3.text {
            if textField3.hasText {
                namesEntered.append(textField3Text)
                textField3.text = ""
            }
        }
        
        if let textField4Text = textField4.text {
            if textField4.hasText {
                namesEntered.append(textField4Text)
                textField4.text = ""
            }
        }
        
        if let textField5Text = textField5.text {
            if textField5.hasText {
                namesEntered.append(textField5Text)
                textField5.text = ""
            }
        }
        
        if let textField6Text = textField6.text {
            if textField6.hasText {
                namesEntered.append(textField6Text)
                textField6.text = ""
            }
        }
        
        if let textField7Text = textField7.text {
            if textField7.hasText {
                namesEntered.append(textField7Text)
                textField7.text = ""
            }
        }
        
        if let textField8Text = textField8.text {
            if textField8.hasText {
                namesEntered.append(textField8Text)
                textField8.text = ""
            }
        }
        
        if let textField9Text = textField9.text {
            if textField9.hasText {
                namesEntered.append(textField9Text)
                textField9.text = ""
            }
        }
        
        if let textField10Text = textField10.text {
            if textField10.hasText {
                namesEntered.append(textField10Text)
                textField10.text = ""
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
        resultsLabel.sizeToFit()
        resultsLabel.text = results
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
    }
}

