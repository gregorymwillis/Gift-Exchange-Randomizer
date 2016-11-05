//
//  ButtonTableViewCell.swift
//  Gift Exchange
//
//  Created by Greg Willis on 11/2/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit
import Foundation

class ButtonTableViewCell: UITableViewCell {

    @IBAction func resetButtonPressed() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ResetAction"), object: nil)
    }  
    
}
