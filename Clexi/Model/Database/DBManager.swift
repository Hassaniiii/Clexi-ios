//
//  DBManager.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    //MARK:- BLE Clone
    class func GetBLECloneItemList() -> [BLECloneModel] {
        return [BLECloneModel]()
    }
    class func InsertNew(BLEItem: BLECloneModel) -> Bool {
        return true
    }
    class func LoadBLECloneItem(With ID: Int) -> BLECloneModel {
        return BLECloneModel()
    }
    class func RemoveBLECloneItem(With ID: Int) -> Bool {
        return true
    }
    class func UpdateBLECloneItem(With ID: Int, To newItem: BLECloneModel) -> Bool {
        return true
    }
    
    //MARK:- Changes Stack
    class func GetBLEStackItemList() -> [ChangesStackModel] {
        return [ChangesStackModel]()
    }
    class func InsertNew(StackItem: ChangesStackModel) -> Bool {
        return true
    }
    class func LoadBLEStackItem(With ID: Int) -> ChangesStackModel {
        return ChangesStackModel()
    }
    class func RemoveBLEStackItem(With ID: Int) -> Bool {
        return true
    }
    class func UpdateBLEStackItem(With ID: Int, To newItem: ChangesStackModel) -> Bool {
        return true
    }
    
    //MARK:- Local Attributes
    class func AddAttribute(To ID: Int) -> Bool {
        return true
    }
    class func LoadAttribute(With ID: Int) -> LocalAttributesModel {
        return LocalAttributesModel()
    }
    class func RemoveAttribute(With ID: Int) -> Bool {
        return true
    }
    class func UpdateAttribute(With ID: Int, To newAttribute: LocalAttributesModel) -> Bool {
        return true
    }
}

extension DBManager {
    //MARK:- Item To Model
    class func ItemToModel(from: BLEClone) -> BLECloneModel {
        return BLECloneModel()
    }
    class func ItemToModel(from: ChangesStack) -> ChangesStackModel {
        return ChangesStackModel()
    }
    class func ItemToModel(from: LocalAttributes) -> LocalAttributesModel {
        return LocalAttributesModel()
    }
    
    //MARK:- Model To Item
    class func ModelToItem(from: BLECloneModel) -> BLEClone {
        return BLEClone()
    }
    class func ModelToItem(from: ChangesStackModel) -> ChangesStack {
        return ChangesStack()
    }
    class func ModelToItem(from: LocalAttributesModel) -> LocalAttributes {
        return LocalAttributes()
    }
    
}
