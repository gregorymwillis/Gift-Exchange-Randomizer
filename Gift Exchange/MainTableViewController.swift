//
//  MainTableViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 10/20/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

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

        registerForListeners()

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
        guard let name = userInfo["name"] as? String, name != "" else {
            // TODO: Log an error that there was no name provided back
            return
        }

        NameManager.shared.add(name: name)

        if let indexPath = indexPathForName(name: name) {
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }

    func resetAction(_ notification: NSNotification) {
        NameManager.shared.clear()
        tableView.reloadData()
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

        case 2:
            return NameManager.shared.getAllNames().count

        case 3:
            return 1

        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "NamesCell", for: indexPath)

        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "AddNameCell", for: indexPath)

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
            if let nameCell = cell as? NameTableViewCell {
                nameCell.name = NameManager.shared.getAllNames()[indexPath.row]
            }
            return cell

        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "ButtonsCell", for: indexPath)

        default:
            return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
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
            NameManager.shared.remove(index: indexPath.row)
            tableView.endUpdates()

        }

        return [deleteAction]
    }

}

// MARK: - Helper functions

fileprivate extension MainTableViewController {

    func registerForListeners() {
        let listenerMap = [
            "NewName": #selector(newNameAdded(_:)),
            "ResetAction": #selector(resetAction(_:)),
        ]

        for key in listenerMap.keys {
            guard let selector = listenerMap[key] else {
                continue
            }
            NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: key), object: nil)
        }
    }

    func indexPathForName(name: String) -> IndexPath? {
        guard let row = NameManager.shared.row(forName: name) else {
            return nil
        }

        return IndexPath(row: row, section: 2)
    }

}
