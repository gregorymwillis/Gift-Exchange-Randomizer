//
//  MatchupManager.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/5/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation

/**
 This class is responsible for taking a list of names and creating a random matchup of who buys a gift for who.
 The way you use this manager is by doing the following:
 1.  Set the list of names:  
 ```
 MatchupManager.shared.names = [ "Bob", "John", "Sue", "Lindsay", "Ralph" ]
 ```
 2.  Call the randomize function: 
 ```
 MatchupManager.shared.randomize()
 ```
 3.  Get the randomized Name Assignments: 
 ```
 let matchup = MatchupManager.shared.randomMatchup
 ```
 */
class MatchupManager {
    static let shared = MatchupManager()

    var names = [String]()
    var randomMatchup = [String: String]()
}

// MARK: - API

extension MatchupManager {

    /** This function is responsible for creating the random matchup.  */
    func randomize() {
        guard names.count > 0 else {
            randomMatchup = [:]
            return
        }
        var unassigned = names
        randomMatchup = [:]

        for assignName in names {
            guard let index = pickRandomName(assignTo: assignName, unassignedNames: unassigned) else {
                randomize()
                return
            }
            randomMatchup[assignName] = unassigned.remove(at: index)
        }
    }

}

// MARK: - Helpers

fileprivate extension MatchupManager {

    /** 
     Returns the index of the unassigned name to pick for the assign to name, unless the unassigned name has only one row left, and it's the same as the assignTo name, if that's the case, then return nil.
     */
    func pickRandomName(assignTo name: String, unassignedNames names: [String]) -> Int? {
        guard names.count > 0 else {
            return nil
        }
        if names.count == 1 && names.first == name {
            return nil
        }
        guard names.count != 1 else {
            return 0
        }

        let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
        guard names[randomIndex] != name else {
            return pickRandomName(assignTo: name, unassignedNames: names)
        }

        return randomIndex
    }
}
