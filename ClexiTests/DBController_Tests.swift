//
//  DBController_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 10/26/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class DBController_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DBManager.isMock = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Inserting tests
    func tests_01_01_InsertBLEClone() {
        let bleCloneItem = BLECloneModel()
        bleCloneItem.id = 1
        bleCloneItem.appid = nil
        bleCloneItem.title = "title"
        bleCloneItem.url = "url"
        bleCloneItem.username = "username"
        
        let result = DBController.InsertBLECloneItem(BLEItem: bleCloneItem)
        XCTAssertTrue(result)
    }
    func tests_01_03_InsertStackItem() {
        let bleStackItem = ChangesStackModel()
        bleStackItem.id = 1
        bleStackItem.appid = nil
        bleStackItem.title = "title"
        bleStackItem.url = "url"
        bleStackItem.username = "username"
        bleStackItem.changekey = ChangeKey.Update
        bleStackItem.password = "password"
        bleStackItem.hashKey = "hash"
        
        let result = DBController.InsertBLEStackItem(BLEStack: bleStackItem)
        XCTAssertTrue(result)
    }
    
    //MARK:- List Loading tests
    func tests_02_01_LoadBLEClone() {
        let id = 1
        let result = DBController.GetBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertEqual(result.title, "title")
        XCTAssertEqual(result.url, "url")
        XCTAssertEqual(result.username, "username")
    }
    func tests_02_02_LoadBLEAttributes() {
        let id = 1
        let result = DBController.GetBLEItemAttribute(With: id)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.popularity, 0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: Date())
        XCTAssertEqual(result.lastused, formatter.date(from: dateStr) as NSDate!)
    }
    func tests_02_03_LoadBLEStack() {
        let id = 1
        let result = DBController.GetBLEStackItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertEqual(result.title, "title")
        XCTAssertEqual(result.url, "url")
        XCTAssertEqual(result.username, "username")
        XCTAssertEqual(result.changekey, ChangeKey.Update)
        XCTAssertEqual(result.password, "password")
        XCTAssertEqual(result.hashKey, "hash")
    }
    
    //MARK:- Updating tests
    func tests_03_01_UpdateCloneItem() {
        let bleCloneItem = BLECloneModel()
        bleCloneItem.id = 1
        bleCloneItem.appid = nil
        bleCloneItem.title = "title 2"
        bleCloneItem.url = "url 2"
        bleCloneItem.username = "username 2"
        
        let result = DBController.InsertBLECloneItem(BLEItem: bleCloneItem)
        XCTAssertTrue(result)
    }
    func tests_03_02_UpdateStackItem() {
        let bleStackItem = ChangesStackModel()
        bleStackItem.id = 1
        bleStackItem.appid = nil
        bleStackItem.title = "new title"
        bleStackItem.url = "new url"
        bleStackItem.username = "new username"
        bleStackItem.changekey = ChangeKey.Update
        bleStackItem.password = "new password"
        bleStackItem.hashKey = "new hash"
        
        let result = DBController.InsertBLEStackItem(BLEStack: bleStackItem)
        XCTAssertTrue(result)
    }
    func tests_03_03_LoadUpdatedCloneItem() {
        let id = 1
        let result = DBController.GetBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertEqual(result.title, "title 2")
        XCTAssertEqual(result.url, "url 2")
        XCTAssertEqual(result.username, "username 2")
    }
    func tests_03_04_LoadUpdatedStackItem() {
        let id = 1
        let result = DBController.GetBLEStackItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertEqual(result.title, "new title")
        XCTAssertEqual(result.url, "new url")
        XCTAssertEqual(result.username, "new username")
        XCTAssertEqual(result.changekey, ChangeKey.Update)
        XCTAssertEqual(result.password, "new password")
        XCTAssertEqual(result.hashKey, "new hash")
    }
    
    //MARK:- Syncing tests
    func tests_04_01_SyncItem() {
        let id = 1;
        let result = DBController.ItemSyncedSuccessfully(With: id)
        XCTAssertTrue(result)
    }
    func tests_04_02_AfterSyncCloneItem() {
        let id = 1
        let result = DBController.GetBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertEqual(result.title, "new title")
        XCTAssertEqual(result.url, "new url")
        XCTAssertEqual(result.username, "new username")
    }
    func tests_04_03_AfterSyncStackItem() {
        let id = 1
        let result = DBController.GetBLEStackItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertNil(result.title)
        XCTAssertNil(result.url)
        XCTAssertNil(result.username)
        XCTAssertNil(result.changekey)
        XCTAssertNil(result.password)
        XCTAssertNil(result.hashKey)
    }
    
    //MARK:- Removing tests
    func tests_05_01_RemoveBLECloneItem() {
        let id = 1;
        let result = DBController.RemoveBLECloneItem(With: id)
        XCTAssertTrue(result)
    }
    func tests_05_02_AfterRemove() {
        let id = 1;
        let result = DBController.GetBLECloneItem(With: id)
        XCTAssertNotNil(result)
        XCTAssertNil(result.appid)
        XCTAssertNil(result.title)
        XCTAssertNil(result.url)
        XCTAssertNil(result.username)
        
        let resultAttribute = DBController.GetBLEItemAttribute(With: id)
        XCTAssertNil(resultAttribute.popularity)
        XCTAssertNil(resultAttribute.lastused)
    }
}
