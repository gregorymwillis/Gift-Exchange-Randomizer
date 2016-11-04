//
//  MainTableViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var names = [String]()
    var nameArray = [String]()
    var results = String()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(newNameAdded(_:)), name: NSNotification.Name(rawValue: "NewName"), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // TODO: Keep track of selected cell

}

// MARK: - notifications

extension MainTableViewController {

    func newNameAdded(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            // TODO: Log an error
            return
        }
        guard let name = userInfo["name"] as? String else {
            // TODO: Log an error that there was no name provided back
            return
        }

        names.append(name)
        names = names.sorted()

        if let indexPath = indexPathForName(name: name) {
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }

}

// MARK: - Table view data source

extension MainTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        case 1:
            return 1

        default:
            return names.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "NamesCell", for: indexPath)

        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "AddNameCell", for: indexPath)

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
            if let nameCell = cell as? NameTableViewCell {
                nameCell.name = names[indexPath.row]
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 2:
            return true
        default:
            return false
        }
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.names.remove(at: indexPath.row)
            tableView.endUpdates()

        }

        return [deleteAction]
    }

}

// MARK: - Helper functions

extension MainTableViewController {

    func indexPathForName(name: String) -> IndexPath? {
        for i in 0..<names.count {
            if names[i] == name {
                return IndexPath(row: i, section: 2)
            }
        }
        return nil
    }
    
    func randomizeNames() {
        nameArray = names
        for name in names {
            let randomName = getRandomName(name: name)
            results += "\(name) buys for \(randomName) \n"
            removeNameFromArray()
        }
        print(results)
    }
    
    func getRandomName(name: String) -> String {
        var randomName = nameArray[getIndex()]
        
        while name == randomName {
            randomName = getRandomName(name: name)
        }
        return randomName
    }

    func entriesAreValid() -> Bool {
        if names.count <= 2 {
            // Pop up warning message
            let alertController = UIAlertController(title: "Try Again", message: "Three names must be entered", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }

    func areAnyNamesTheSame() -> Bool {
        for name in names {
            var x = 1
            repeat {
                if name == nameArray[x] {
                    return true
                }
                
                x += 1
            } while x <= nameArray.count;
        }
        return false
    }
    
    func removeNameFromArray() {
        nameArray.remove(at: index)
    }
    
    
    func getIndex() -> Int {
        index = Int(arc4random_uniform(UInt32(nameArray.count)))
        return index
    }
}
