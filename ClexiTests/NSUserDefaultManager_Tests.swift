//
//  NSUserDefaultManager_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 10/24/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class NSUserDefaultManager_Tests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_1_InsertLoad() {
        let str = "Hello World!"
        
        NSUserDefaultManager.SaveItem(str, key: "TEST_KEY")
        let loadedStr = NSUserDefaultManager.LoadItem("TEST_KEY")
        
        XCTAssertNotNil(loadedStr)
        XCTAssertEqual(str, loadedStr as? String)
    }
}
