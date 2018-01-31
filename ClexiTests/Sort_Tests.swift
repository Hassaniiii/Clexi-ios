//
//  Sort_Tests.swift
//  ClexiTests
//
//  Created by Hassan Shahbazi on 2018-01-30.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class Sort_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tests_1_SortEmptyList() {
        let items = DBController.GetBLECloneList()
        XCTAssertNotNil(items)
        XCTAssertEqual(items.Sort(By: .Title).count, 0)
    }
    
    func tests_2_SortIdenticalList() {
        XCTAssertTrue(false)
    }
 
    func tests_3_SortByTitle() {
        XCTAssertTrue(false)
    }
    
    func tests_4_SortByPopularity() {
        XCTAssertTrue(false)
    }
    
    func tests_5_SortByLastUsed() {
        XCTAssertTrue(false)
    }
}
