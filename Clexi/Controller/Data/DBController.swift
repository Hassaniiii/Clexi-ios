//
//  DBController.swift
//  Clexi
//
//  Created by Hassaniiii on 10/26/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

class DBController: NSObject {
    
    //Default functions
    class func GetBLECloneList() -> [BLECloneModel] {
        return DBManager.GetBLECloneItemList()
    }
    class func GetBLEStackList() -> [ChangesStackModel] {
        return DBManager.GetBLEStackItemList()
    }
    
    class func GetBLECloneItem(With ID: Int) -> BLECloneModel {
        if let item = DBManager.LoadBLECloneItem(With: ID) {
            return item
        }
        return BLECloneModel()
    }
    class func GetBLEStackItem(With ID: Int) -> ChangesStackModel {
        if let item = DBManager.LoadBLEStackItem(With: ID) {
            return item
        }
        return ChangesStackModel()
    }
    class func GetBLEItemAttribute(With ID: Int) -> LocalAttributesModel {
        if let item = DBManager.LoadAttribute(With: ID) {
            return item
        }
        return LocalAttributesModel()
    }

    class func InsertBLECloneItem(BLEItem: BLECloneModel) -> Bool {
        let id = Int(BLEItem.id)
        if DBManager.LoadBLECloneItem(With: id) != nil {
            return DBManager.UpdateBLECloneItem(With: id, To: BLEItem)
        }
        if InitiateAttribute(For: id) {
            return DBManager.InsertNew(BLEItem: BLEItem)
        }
        return false
    }
    class func InsertBLEStackItem(BLEStack: ChangesStackModel) -> Bool {
        let id = Int(BLEStack.id)
        if DBManager.LoadBLEStackItem(With: id) != nil {
            return DBManager.UpdateBLEStackItem(With: id, To: BLEStack)
        }
        return DBManager.InsertNew(StackItem: BLEStack)
    }
    
    class func RemoveBLECloneItem(With ID: Int) -> Bool {
        var result = true
        result = result && RemoveAttribute(For: ID)
        return result && DBManager.RemoveBLECloneItem(With: ID)
    }
    class func RemoveBLEStackItem(With ID: Int) -> Bool {
        return DBManager.RemoveBLEStackItem(With: ID)
    }
    
    //Special functions
    class func ItemSyncedSuccessfully(With ID: Int) -> Bool {
        var result = true
        
        //first get the item from stack db
        let syncedItem = GetBLEStackItem(With: ID)
        
        //then find the change
        if syncedItem.changekey == ChangeKey.Insert || syncedItem.changekey == ChangeKey.Update {
            //insert or update the item to the ble clone db
            result = result && InsertBLECloneItem(BLEItem: StackToClone(BLEStack: syncedItem))
        }
        else if syncedItem.changekey == ChangeKey.Remove {
            //remove corresponded item in the ble clone db
            result = result && RemoveBLECloneItem(With: ID)
        }
        //then remove the item from stack
        result = result && RemoveBLEStackItem(With: ID)
        return result
    }
    
    private class func InitiateAttribute(For ID: Int) -> Bool {
        let inititateAttribute = LocalAttributesModel()
        inititateAttribute.id = Int16(ID)
        inititateAttribute.popularity = 0
        inititateAttribute.lastused = PrepareDate()
        
        return DBManager.AddAttribute(Attributes: inititateAttribute)
    }
    private class func RemoveAttribute(For ID: Int) -> Bool {
        return DBManager.RemoveAttribute(With: ID)
    }
    private class func PrepareDate() -> NSDate {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: Date())
        
        return formatter.date(from: dateStr) as NSDate!
    }
    private class func StackToClone(BLEStack: ChangesStackModel) -> BLECloneModel {
        let BLEClone = BLECloneModel()
        BLEClone.id = BLEStack.id
        BLEClone.username = BLEStack.username
        BLEClone.url = BLEStack.url
        BLEClone.title = BLEStack.title
        BLEClone.appid = BLEStack.appid
        return BLEClone
    }
}
