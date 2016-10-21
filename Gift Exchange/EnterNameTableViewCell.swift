//
//  EnterNameTableViewCell.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class EnterNameTableViewCell: UITableViewCell {

    @IBOutlet fileprivate var nameText: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameText.delegate = self
    }

}

// MARK: - UITextFieldDelegate

extension EnterNameTableViewCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string == "\n" {
            textField.resignFirstResponder()
            notifyNewName(name: textField.text)
            textField.text = nil
            return false
        }

        return true
    }
}

// MARK: - Helpers

extension EnterNameTableViewCell {

    func notifyNewName(name: String?) {
        guard let name = name else {
            return
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewName"), object: nil, userInfo: ["name": name])
    }

}
