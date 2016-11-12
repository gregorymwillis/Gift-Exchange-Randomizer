//
//  RandomizeNamesTableViewController.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit

class RandomizeNamesTableViewController: UITableViewController {

    // Ordered list of names
    var names = [String]()

    // Who is assigned to who
    var matchups = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeMatchup()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.addObserver(self, selector: #selector(userClickedRandomize(_:)), name: NSNotification.Name("RandomizeAction"), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - Notification Actions

extension RandomizeNamesTableViewController {

    func userClickedRandomize(_ notification: NSNotification) {
        randomizeMatchup()
    }

}

// MARK: - Table view data source

extension RandomizeNamesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return matchups.keys.count

        case 1:
            return 1

        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
            let name = names[indexPath.row]

            if let nameCell = cell as? NameTableViewCell, let buyFor = matchups[name] {
                nameCell.name = "\(name) buys a gift for \(buyFor)"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RandomizeCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        }
    }

}

// MARK: - Helper functions

fileprivate extension RandomizeNamesTableViewController {


    func randomizeMatchup() {
        names = NameManager.shared.getAllNames()
        AlertHelper.checkRandomizeMatchup(names: names, parentVC: self) { (success: Bool) in
            
            if success {
                MatchupManager.shared.names = names
                MatchupManager.shared.randomize()
                matchups = MatchupManager.shared.randomMatchup
                tableView.reloadData()
            }
        }
    }
}


