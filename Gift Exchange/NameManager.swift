//
//  NameManager.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation

/**
 * This class is responsible for managing the list of people
 */
class NameManager {
    static let shared = NameManager()

    fileprivate var names: [String] {
        get {
            return UserDefaults.standard.array(forKey: "names") as? [String] ?? [String]()
        }
        set {
            UserDefaults.standard.set(newValue.sorted(), forKey: "names")
        }
    }
}

// MARK: - API

extension NameManager {

    // Gets you the list of names
    func getAllNames() -> [String] {
        return names
    }

    // Add a specific name
    func add(name person: String) {
        var values = names
        values.append(person)
        names = values
    }

    // Remove a specific name (by index)
    func remove(index row: Int) {
        var values = names
        values.remove(at: row)
        names = values
    }

    // Remove a specific name from the list (if you have multiples of the same name, this will remove them all)
    func remove(name person: String) {
        let values = names.filter { (aName: String) -> Bool in
            return aName != person
        }
        names = values
    }

    // Clears the names
    func clear() {
        names = []
    }

    // Gets you the row for the provided name
    func row(forName name: String) -> Int? {
        for i in 0..<names.count {
            if names[i] == name {
                return i
            }
        }
        return nil
    }

}

// MARK: - Helpers

fileprivate extension NameManager {

}
