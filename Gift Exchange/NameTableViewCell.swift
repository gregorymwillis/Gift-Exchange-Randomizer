//
//  NameTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
