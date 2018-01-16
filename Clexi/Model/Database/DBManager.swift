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
    
    //MARK:- Shared functions
    private class func GetList(from Request: NSFetchRequest<NSFetchRequestResult>, result: inout [NSObject]) {
        let managedContext = GetDatabaseInstance()
        if let fetchResults = (try? managedContext.fetch(Request)) {
            for record in fetchResults {
                if let rec = record as? NSManagedObject {
                    result.append(ItemToModel(from: rec))
                }
            }
        }
    }
    private class func GetItem(from Request: NSFetchRequest<NSFetchRequestResult>, result: inout NSObject) {
        let managedContext = GetDatabaseInstance()
        do {
            let fetchResults = try managedContext.fetch(Request)
            if let rec = fetchResults.first as? NSManagedObject {
                result = ItemToModel(from: rec)
            }
        } catch {
            result = NSObject()
        }
    }
    private class func InsertItem(entity Request: String, item: NSObject) -> Bool {
        let managedContext = GetDatabaseInstance()
        var newItem = NSEntityDescription.insertNewObject(forEntityName: Request, into:managedContext)
        ModelToItem(from: item, To: &newItem)
        
        do {
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }
    private class func RemoveItem(from Request: NSFetchRequest<NSFetchRequestResult>) -> Bool {
        let managedContext = GetDatabaseInstance()
        if let fetchResult = (try? managedContext.fetch(Request)) {
            if fetchResult.count == 1 {
                if let rec = fetchResult.first as? NSManagedObject {
                    managedContext.delete(rec)
                }
            }
            else {
                return false
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
    private class func UpdateItem(from Request: NSFetchRequest<NSFetchRequestResult>, To New: NSObject) -> Bool {
        let managedContext = GetDatabaseInstance()
        if var fetchResult = (try? managedContext.fetch(Request))?.first as? NSManagedObject {
            ModelToItem(from: New, To: &fetchResult)
            
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    //MARK:- BLE Clone
    class func GetBLECloneItemList() -> [BLECloneModel] {
        var result = [NSObject]()
        GetList(from: BLEClone.fetchRequest(), result: &result)
        if let res = result as? [BLECloneModel] {
            return res
        }
        return [BLECloneModel]()
    }
    class func InsertNew(BLEItem: BLECloneModel) -> Bool {
        return InsertItem(entity: "BLEClone", item: BLEItem)
    }
    class func LoadBLECloneItem(With ID: Int) -> BLECloneModel? {
        let fetchRequest = BLEClone.fetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        var result = NSObject()
        GetItem(from: fetchRequest, result: &result)
        return result as? BLECloneModel
    }
    class func RemoveBLECloneItem(With ID: Int) -> Bool {
        let fetchRequest = BLEClone.fetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        return RemoveItem(from: fetchRequest)
    }
    class func UpdateBLECloneItem(With ID: Int, To newItem: BLECloneModel) -> Bool {
        let fetchRequest = BLEClone.fetchRequest()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        return UpdateItem(from: fetchRequest, To: newItem)
    }
    
    //MARK:- Changes Stack
    class func GetBLEStackItemList() -> [ChangesStackModel] {
        var result = [ChangesStackModel]()
        return result
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
    private class func ItemToModel(from Item: NSManagedObject) -> NSObject {
        if let item = Item as? BLEClone {
            let model = BLECloneModel()
            model.appid = item.appid
            model.id = item.id
            model.title = item.title
            model.url = item.url
            model.username = item.username
            
            return model
        }
        return NSObject()
    }
    
    //MARK:- Model To Item
    private class func ModelToItem(from Model: NSObject, To Item: inout NSManagedObject) {
        if let model = Model as? BLECloneModel{
            if let item = Item as? BLEClone {
                item.appid = model.appid
                item.id = model.id
                item.url = model.url
                item.title = model.title
                item.username = model.username
            }
        }
    }
}