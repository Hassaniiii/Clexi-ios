//
//  DBManager_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class DBManager_Tests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        DBManager.isMock = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- BLE Clone Tests
    func tests_01_BLECloneInsert() {
        let newItem = BLECloneModel()
        newItem.id          = 0
        newItem.title       = "TEST TITILE"
        newItem.url         = "TEST URL"
        newItem.username    = "TEST USERNAME"
        newItem.appid       = nil
        
        let result = DBManager.InsertNew(BLEItem: newItem)
        XCTAssertTrue(result)
    }
    func tests_02_BLECloneList() {
        let list = DBManager.GetBLECloneItemList()
        XCTAssertNotNil(list)
        XCTAssertGreaterThan(list.count, 0)
    }
    func tests_03_BLECloneLoad() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, "TEST TITILE")
        XCTAssertEqual(result?.url, "TEST URL")
        XCTAssertEqual(result?.username, "TEST USERNAME")
        XCTAssertNil(result?.appid)
    }
    func tests_04_BLECloneUpdate() {
        let id = 0
        let newItem = BLECloneModel()
        newItem.id          = Int16(id)
        newItem.title       = "TEST TITILE 2"
        newItem.url         = "TEST URL 2"
        newItem.username    = "TEST USERNAME 2"
        newItem.appid       = nil
        
        let result = DBManager.UpdateBLECloneItem(With: id, To: newItem)
        XCTAssertTrue(result)
        
        let updatedItem = DBManager.LoadBLECloneItem(With: id)
        XCTAssertEqual(updatedItem?.title, "TEST TITILE 2")
        XCTAssertEqual(updatedItem?.url, "TEST URL 2")
        XCTAssertEqual(updatedItem?.username, "TEST USERNAME 2")
        XCTAssertNil(updatedItem?.appid)
    }
    func tests_05_BLECloneRemove() {
        let id = 0
        let result = DBManager.RemoveBLECloneItem(With: id)
        XCTAssertTrue(result)
        
        let list = DBManager.GetBLECloneItemList()
        XCTAssertEqual(list.count, 0)
    }
    func tests_06_BLECloneLoadInvallid() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNil(result)
    }
    func tests_07_BLECloneDoubleRemove() {
        let id = 0
        let result = DBManager.RemoveBLECloneItem(With: id)
        XCTAssertFalse(result)
    }
    
    
    //MARK:- Changes Stack Tests
    func tests_11_BLEStackList() {
        let list = DBManager.GetBLEStackItemList()
        XCTAssertNotNil(list)
    }
    func tests_12_BLEStackInsert() {
        let newItem = ChangesStackModel()
        let result = DBManager.InsertNew(StackItem: newItem)
        XCTAssertTrue(result)
    }
    func tests_13_BLEStackLoad() {
        let id = 0
        let result = DBManager.LoadBLEStackItem(With: id)
        XCTAssertNotNil(result)
    }
    func tests_14_BLEStackRemove() {
        let id = 0
        let result = DBManager.RemoveBLEStackItem(With: id)
        XCTAssertTrue(result)
    }
    func tests_15_BLEStackUpdate() {
        let id = 0
        let newItem = ChangesStackModel()
        let result = DBManager.UpdateBLEStackItem(With: id, To: newItem)
        XCTAssertTrue(result)
    }
    
    //MARK:- Local Attributes Tests
    func tests_21_AttributeInsert() {
        let id = 0
        let result = DBManager.AddAttribute(To: id)
        XCTAssertTrue(result)
    }
    func tests_22_AttributeLoad() {
        let id = 0
        let result = DBManager.LoadAttribute(With: id)
        XCTAssertNotNil(result)
    }
    func tests_23_AttributeRemove() {
        let id = 0
        let result = DBManager.RemoveAttribute(With: id)
        XCTAssertTrue(result)
    }
    func tests_24_AttributeUpdate() {
        let id = 0
        let newItem = LocalAttributesModel()
        let result = DBManager.UpdateAttribute(With: id, To: newItem)
        XCTAssertTrue(result)
    }
}
