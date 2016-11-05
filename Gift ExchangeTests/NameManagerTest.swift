//
//  NameManagerTest.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import XCTest
@testable import Gift_Exchange

class NameManagerTest: XCTestCase {

    var initialNames = [String]()

    override func setUp() {
        super.setUp()
        initialNames = NameManager.shared.getAllNames()
        UserDefaults.standard.set(nil, forKey: "names")
    }
    
    override func tearDown() {
        UserDefaults.standard.set(initialNames, forKey: "names")
        super.tearDown()
    }

}

// MARK: - Test adding names

extension NameManagerTest {

    func testAddNames() {
        XCTAssertEqual(0, NameManager.shared.getAllNames().count, "We have some names already")

        NameManager.shared.add(name: "Greg")
        XCTAssertEqual(1, NameManager.shared.getAllNames().count, "Greg didn't get added, bummer...")

        NameManager.shared.add(name: "Eric")
        XCTAssertEqual(2, NameManager.shared.getAllNames().count, "Eric didn't get added, bummer...")

        XCTAssertEqual(["Eric", "Greg"], NameManager.shared.getAllNames(), "The names weren't sorted correctly")
    }

}

// MARK: - Test deleting names

extension NameManagerTest {

    func testDeleteNames() {
        XCTAssertEqual(0, NameManager.shared.getAllNames().count, "We have some names already")

        NameManager.shared.add(name: "Eric")
        NameManager.shared.add(name: "Greg")
        NameManager.shared.add(name: "Lori")
        XCTAssertEqual(3, NameManager.shared.getAllNames().count, "Incorrect number of names.")

        NameManager.shared.remove(name: "Greg")
        XCTAssertEqual(2, NameManager.shared.getAllNames().count, "Incorrect number of names after deleting Greg")
        XCTAssertEqual(["Eric", "Lori"], NameManager.shared.getAllNames())

        NameManager.shared.remove(index: 0)
        XCTAssertEqual(1, NameManager.shared.getAllNames().count, "Incorrect number of names after deleting index 0")
        XCTAssertEqual(["Lori"], NameManager.shared.getAllNames())

        NameManager.shared.remove(index: 0)
        XCTAssertEqual(0, NameManager.shared.getAllNames().count, "Incorrect number of names after deleting index 0")
        XCTAssertEqual([], NameManager.shared.getAllNames())
    }
}
