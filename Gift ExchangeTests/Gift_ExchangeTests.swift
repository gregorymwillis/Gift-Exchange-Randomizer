//
//  Gift_ExchangeTests.swift
//  Gift ExchangeTests
//
//  Created by Greg Willis on 10/17/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import XCTest
@testable import Gift_Exchange

class Gift_ExchangeTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAreAnyNamesTheSame() {
        let nameEntered: [String] = ["Mary", "Poppins", "Gary"]
        var answer: Bool = false
        
        var x = 1
        repeat {
            for name in nameEntered {
                if name == nameEntered[x] {
                    answer = true
                } else {
                    answer = false
                }
            }
            x += 1
        } while x < nameEntered.count
        
        print(answer)
    }
   
    
}
