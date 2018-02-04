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
        if let attribute = DBManager.LoadBLECloneItem(With: ID)?.attributes {
            return attribute
        }
        return LocalAttributesModel()
    }

    class func InsertBLECloneItem(BLEItem: BLECloneModel) -> Bool {
        let id = Int(BLEItem.id)
        if DBManager.LoadBLECloneItem(With: id) != nil {
            return DBManager.UpdateBLECloneItem(With: id, To: BLEItem)
        }
        BLEItem.attributes = InitiateAttribute(For: id)
        return DBManager.InsertNew(BLEItem: BLEItem)
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
        result = result && DBManager.RemoveBLECloneItem(With: ID)
        return result && RemoveAttribute(For: ID)
    }
    class func RemoveBLEStackItem(With ID: Int) -> Bool {
        return DBManager.RemoveBLEStackItem(With: ID)
    }

    class func WipeDatabase() -> Bool {
        return (DBManager.Wipe(entity: .BLEClone) &&
            DBManager.Wipe(entity: .BLEStack) &&
            DBManager.Wipe(entity: .LocalAttributes))
    }
    
    //Special functions
    class func ItemIsUsed(With ID: Int) -> Bool {
        //get current attribute
        let itemAttribute = GetBLEItemAttribute(With: ID)
        
        //update last used data
        itemAttribute.lastused = PrepareDate()
        
        //update popularity
        itemAttribute.popularity = itemAttribute.popularity + 1
        
        return DBManager.UpdateAttribute(With: ID, To: itemAttribute)
    }
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
    
}

extension DBController {
    
    private class func InitiateAttribute(For ID: Int) -> LocalAttributesModel {
        let inititateAttribute = LocalAttributesModel()
        inititateAttribute.id = Int16(ID)
        inititateAttribute.popularity = 0
        inititateAttribute.lastused = PrepareDate()
        
        return inititateAttribute
    }
    private class func RemoveAttribute(For ID: Int) -> Bool {
        return DBManager.RemoveAttribute(With: ID)
    }
    private class func PrepareDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: Date())
        
        return formatter.date(from: dateStr)!
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
