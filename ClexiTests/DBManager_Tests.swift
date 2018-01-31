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
    func tests_1_01_BLECloneInsert() {
        let newItem = BLECloneModel()
        newItem.id          = 0
        newItem.title       = "TEST TITILE"
        newItem.url         = "TEST URL"
        newItem.username    = "TEST USERNAME"
        newItem.appid       = nil
        
        let attributes = LocalAttributesModel()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        
        attributes.id = newItem.id
        attributes.popularity = 1
        attributes.lastused = formatter.date(from: date)! as NSDate
        newItem.attributes  = attributes
        
        let result = DBManager.InsertNew(BLEItem: newItem)
        XCTAssertTrue(result)
    }
    func tests_1_02_BLECloneList() {
        let list = DBManager.GetBLECloneItemList()
        XCTAssertNotNil(list)
        XCTAssertGreaterThan(list.count, 0)
    }
    func tests_1_03_BLECloneLoad() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, "TEST TITILE")
        XCTAssertEqual(result?.url, "TEST URL")
        XCTAssertEqual(result?.username, "TEST USERNAME")
        XCTAssertNil(result?.appid)
    }
    func tests_1_04_BLECloneAttribute() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        
        XCTAssertEqual(result?.attributes?.id, 0)
        XCTAssertEqual(result?.attributes?.popularity, 1)
        XCTAssertEqual(result?.attributes?.lastused, formatter.date(from: date)! as NSDate)
    }
    func tests_1_05_BLECloneUpdate() {
        let id = 0
        let newItem = BLECloneModel()
        newItem.id          = Int16(id)
        newItem.title       = "TEST TITILE 2"
        newItem.url         = "TEST URL 2"
        newItem.username    = "TEST USERNAME 2"
        newItem.appid       = nil
        XCTAssertTrue(DBManager.UpdateBLECloneItem(With: id, To: newItem))
    }
    func tests_1_06_LoadUpdatedBLEClone() {
        let id = 0
        let updatedItem = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNotNil(updatedItem)
        XCTAssertEqual(updatedItem?.title, "TEST TITILE 2")
        XCTAssertEqual(updatedItem?.url, "TEST URL 2")
        XCTAssertEqual(updatedItem?.username, "TEST USERNAME 2")
        XCTAssertNil(updatedItem?.appid)
    }
    func tests_1_07_UpdateAttribute() {
        let id = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.string(from: Date())
        
        let newAttribute = LocalAttributesModel()
        newAttribute.id = Int16(id)
        newAttribute.popularity = 2
        newAttribute.lastused = formatter.date(from: date)! as NSDate

        XCTAssertTrue(DBManager.UpdateAttribute(With: id, To: newAttribute))
    }
    func tests_1_08_LoadUpdatedAttribute() {
        let id = 0
        let updatedItem = DBManager.LoadBLECloneItem(With: id)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.string(from: Date())

        XCTAssertNotNil(updatedItem)
        XCTAssertEqual(updatedItem?.attributes?.id, 0)
        XCTAssertEqual(updatedItem?.attributes?.popularity, 2)
        XCTAssertEqual(updatedItem?.attributes?.lastused, formatter.date(from: date)! as NSDate)
    }
    func tests_1_09_BLECloneRemove() {
        let id = 0
        let list_before = DBManager.GetBLECloneItemList()
        let result = DBManager.RemoveBLECloneItem(With: id)
        XCTAssertTrue(result)
        
        let list_after = DBManager.GetBLECloneItemList()
        XCTAssertLessThan(list_after.count, list_before.count)
    }
    func tests_1_10_BLECloneLoadInvallid() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNil(result)
    }
    func tests_1_11_BLECloneDoubleRemove() {
        let id = 0
        let result = DBManager.RemoveBLECloneItem(With: id)
        XCTAssertFalse(result)
    }
    
    
    //MARK:- Changes Stack Tests
    func tests_2_01_BLEStackInsert() {
        let newItem = ChangesStackModel()
        newItem.id          = 0
        newItem.title       = "TEST TITILE"
        newItem.url         = "TEST URL"
        newItem.username    = "TEST USERNAME"
        newItem.appid       = nil
        newItem.password    = "TEST PASSWORD"
        newItem.changekey   = ChangeKey.Insert
        newItem.hashKey     = "TEST HASH"
        
        let result = DBManager.InsertNew(StackItem: newItem)
        XCTAssertTrue(result)
    }
    func tests_2_02_BLEStackList() {
        let list = DBManager.GetBLEStackItemList()
        XCTAssertNotNil(list)
        XCTAssertGreaterThan(list.count, 0)
    }
    func tests_2_03_BLEStackLoad() {
        let id = 0
        let result = DBManager.LoadBLEStackItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, "TEST TITILE")
        XCTAssertEqual(result?.url, "TEST URL")
        XCTAssertEqual(result?.username, "TEST USERNAME")
        XCTAssertNil(result?.appid)
        XCTAssertEqual(result?.password, "TEST PASSWORD")
        XCTAssertEqual(result?.changekey, ChangeKey.Insert)
        XCTAssertEqual(result?.hashKey, "TEST HASH")
    }
    func tests_2_04_BLEStackUpdate() {
        let id = 0
        let newItem = ChangesStackModel()
        newItem.id          = Int16(id)
        newItem.title       = "TEST TITILE 2"
        newItem.url         = "TEST URL 2"
        newItem.username    = "TEST USERNAME 2"
        newItem.appid       = nil
        newItem.password    = "TEST PASSWORD 2"
        newItem.changekey   = ChangeKey.Remove
        newItem.hashKey     = "TEST HASH 2"

        
        let result = DBManager.UpdateBLEStackItem(With: id, To: newItem)
        XCTAssertTrue(result)
        
        let updatedItem = DBManager.LoadBLEStackItem(With: id)
        XCTAssertNotNil(updatedItem)
        XCTAssertEqual(updatedItem?.title, "TEST TITILE 2")
        XCTAssertEqual(updatedItem?.url, "TEST URL 2")
        XCTAssertEqual(updatedItem?.username, "TEST USERNAME 2")
        XCTAssertNil(updatedItem?.appid)
        XCTAssertEqual(updatedItem?.password, "TEST PASSWORD 2")
        XCTAssertEqual(updatedItem?.changekey, ChangeKey.Remove)
        XCTAssertEqual(updatedItem?.hashKey, "TEST HASH 2")

    }
    func tests_2_05_BLEStackRemove() {
        let id = 0
        let result = DBManager.RemoveBLEStackItem(With: id)
        XCTAssertTrue(result)
        
        let list = DBManager.GetBLEStackItemList()
        XCTAssertEqual(list.count, 0)
    }
    func tests_2_06_BLECloneLoadInvallid() {
        let id = 0
        let result = DBManager.LoadBLEStackItem(With: id)
        XCTAssertNil(result)
    }
    func tests_2_07_BLECloneDoubleRemove() {
        let id = 0
        let result = DBManager.RemoveBLEStackItem(With: id)
        XCTAssertFalse(result)
    }
    
    
    //MARK:- Local Attributes Tests
    func tests_3_01_AttributeRemove() {
        let id = 0
        let result = DBManager.RemoveAttribute(With: id)
        XCTAssertTrue(result)
    }
    
    //MARK:- Wipe Database
    func tests_4_01_WipeDatabase() {
        XCTAssertTrue(DBManager.Wipe(entity: .BLEClone))
        XCTAssertTrue(DBManager.Wipe(entity: .BLEStack))
    }
    func tests_4_02_AfterWipe() {
        let CloneList = DBManager.GetBLECloneItemList()
        XCTAssertEqual(CloneList.count, 0)
        
        let StackList = DBManager.GetBLEStackItemList()
        XCTAssertEqual(StackList.count, 0)
    }
}
