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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- BLE Clone Tests
    func tests_01_BLECloneList() {
        let list = DBManager.GetBLECloneItemList()
        XCTAssertNotNil(list)
    }
    func tests_02_BLECloneInsert() {
        let newItem = BLECloneModel()
        let result = DBManager.InsertNew(BLEItem: newItem)
        XCTAssertTrue(result)
    }
    func tests_03_BLECloneLoad() {
        let id = 0
        let result = DBManager.LoadBLECloneItem(With: id)
        XCTAssertNotNil(result)
    }
    func tests_04_BLECloneRemove() {
        let id = 0
        let result = DBManager.RemoveBLECloneItem(With: id)
        XCTAssertTrue(result)
    }
    func tests_05_BLECloneUpdate() {
        let id = 0
        let newItem = BLECloneModel()
        let result = DBManager.UpdateBLECloneItem(With: id, To: newItem)
        XCTAssertTrue(result)
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
    
    //MARK:- Conversations Tests
    func test_31_BLECloneItem_To_BLEItemModel() {
        let item = BLEClone()
        let result = DBManager.ItemToModel(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: BLECloneModel.classForCoder()))
    }
    func test_32_BLEStackItem_To_BLEStackModel() {
        let item = ChangesStack()
        let result = DBManager.ItemToModel(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: ChangesStackModel.classForCoder()))
    }
    func test_33_AttributeItem_To_AttributeModel() {
        let item = LocalAttributes()
        let result = DBManager.ItemToModel(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: LocalAttributesModel.classForCoder()))
    }
    
    func test_34_BLECloneModel_To_BLEItemItem() {
        let item = BLECloneModel()
        let result = DBManager.ModelToItem(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: BLEClone.classForCoder()))
    }
    func test_35_BLEStackModel_To_BLEStackItem() {
        let item = ChangesStackModel()
        let result = DBManager.ModelToItem(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: ChangesStack.classForCoder()))
    }
    func test_36_AttributeModel_To_AttributeItem() {
        let item = LocalAttributesModel()
        let result = DBManager.ModelToItem(from: item)
        XCTAssertNotNil(result)
        XCTAssertTrue(result.isKind(of: LocalAttributes.classForCoder()))
    }
}
