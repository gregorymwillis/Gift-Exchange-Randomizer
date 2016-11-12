//
//  AlertHelper.swift
//  Gift Exchange
//
//  Created by Greg Willis on 11/12/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

typealias RandomizeNameCallback = (_ success: Bool) -> ()

class AlertHelper {
    
    static func popNotEnoughNameUpWarning(parentVC: UIViewController) {
        let alert = UIAlertController(title: "Try Again", message: "Enter at least three names", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        parentVC.present(alert, animated: true, completion: nil)
    }
    
    static func popDuplicateNameWarning(parentVC: UIViewController) {
        let alert = UIAlertController(title: "Try Again", message: "Names must be different", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        parentVC.present(alert, animated: true, completion: nil)
    }

    static  func checkRandomizeMatchup(names: [String], parentVC: UIViewController, callback: RandomizeNameCallback) {
        
        guard names.count > 2 else {
            popNotEnoughNameUpWarning(parentVC: parentVC)
            callback(false)
            return
        }
        
        for i in 0..<names.count {
            for j in 0..<names.count {
                guard j != i else {
                    continue
                }
                if names[i] == names[j] {
                    callback(false)
                    popDuplicateNameWarning(parentVC: parentVC)
                    return
                }
            }
        }
        
        callback(true)
    }


}
