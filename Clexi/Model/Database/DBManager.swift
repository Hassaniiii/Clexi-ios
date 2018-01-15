//
//  DBManager.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {
    static var isMock: Bool = false
    private class func GetDatabaseInstance() -> NSManagedObjectContext {
        let database = DatabaseInstance.SharedInstance()
        database.isMock = isMock
        return database.managedObjectContext()
    }
    
    
    //MARK:- BLE Clone
    class func GetBLECloneItemList() -> [BLECloneModel] {
        let managedContext = GetDatabaseInstance()
        let fetchRequest = BLEClone.FetchRequest()
        var result = [BLECloneModel]()
        
        if let fetchResults = (try? managedContext.fetch(fetchRequest)) {
            for record in fetchResults {
                result.append(ItemToModel(from: record))
            }
        }
        return result
    }
    class func InsertNew(BLEItem: BLECloneModel) -> Bool {
        let managedContext = GetDatabaseInstance()
        if var newItem = NSEntityDescription.insertNewObject(forEntityName: "BLEClone", into:managedContext) as? BLEClone {
            ModelToItem(from: BLEItem, To: &newItem)
            
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    class func LoadBLECloneItem(With ID: Int) -> BLECloneModel? {
        let managedContext = GetDatabaseInstance()
        let fetchRequest = BLEClone.FetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        if let fetchResult = (try? managedContext.fetch(fetchRequest)) {
            if fetchResult.count == 1 {
                return ItemToModel(from: fetchResult.first!)
            }
        }
        return nil
    }
    class func RemoveBLECloneItem(With ID: Int) -> Bool {
        let managedContext = GetDatabaseInstance()
        let fetchRequest = BLEClone.FetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        if let fetchResult = (try? managedContext.fetch(fetchRequest)) {
            if fetchResult.count == 1 {
                managedContext.delete(fetchResult.first!)
            }
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    class func UpdateBLECloneItem(With ID: Int, To newItem: BLECloneModel) -> Bool {
        let managedContext = GetDatabaseInstance()
        let fetchRequest = BLEClone.FetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        if var fetchResult = (try? managedContext.fetch(fetchRequest))?.first {
            newItem.id = Int16(ID)
            ModelToItem(from: newItem, To: &fetchResult)

            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
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
    private class func ItemToModel(from Item: BLEClone) -> BLECloneModel {
        let model = BLECloneModel()
        model.appid = Item.appid
        model.id = Item.id
        model.title = Item.title
        model.url = Item.url
        model.username = Item.username
        
        return model
    }
    private class func ItemToModel(from Item: ChangesStack) -> ChangesStackModel {
        return ChangesStackModel()
    }
    private class func ItemToModel(from Item: LocalAttributes) -> LocalAttributesModel {
        return LocalAttributesModel()
    }
    
    //MARK:- Model To Item
    private class func ModelToItem(from Model: BLECloneModel, To Item: inout BLEClone) {
        Item.appid = Model.appid
        Item.id = Model.id
        Item.url = Model.url
        Item.title = Model.title
        Item.username = Model.username
    }
    private class func ModelToItem(from Model: ChangesStackModel) -> ChangesStack {
        return ChangesStack()
    }
    private class func ModelToItem(from Model: LocalAttributesModel) -> LocalAttributes {
        return LocalAttributes()
    }
}
