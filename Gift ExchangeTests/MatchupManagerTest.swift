//
//  MatchupManagerTest.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/5/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import XCTest
@testable import Gift_Exchange

class MatchupManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

// MARK: - Test Randomize

extension MatchupManagerTest {

    func testRandomize() {

        for _ in 0..<100 {
            let names = [ "Bob", "Mary", "Jane", "Eric", "Homer", "Marge", "Bart" ]
            MatchupManager.shared.names = names
            MatchupManager.shared.randomize()
            let assignments = MatchupManager.shared.randomMatchup

            for key in assignments.keys {
                XCTAssertNotEqual(key, assignments[key], "\(key) was assigned to themselves")
            }
            for name in names {
                XCTAssertTrue(Set<String>(assignments.keys).contains(name))
                XCTAssertTrue(Set<String>(assignments.values).contains(name))
            }
        }

    }

}
