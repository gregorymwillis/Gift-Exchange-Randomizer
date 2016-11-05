//
//  RandomizeButtonTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class RandomizeButtonTableViewCell: UITableViewCell {

    @IBAction func randomizePressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RandomizeAction"), object: nil)
    }

}
