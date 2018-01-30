//
//  DBManager.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreData

enum Entity: String {
    case BLEClone
    case BLEStack
    case LocalAttributes
    var description: String {
        switch self {
            case .BLEClone: return "BLEClone"
            case .BLEStack: return "ChangesStack"
            case .LocalAttributes: return "LocalAttributes"
        }
    }
}

class DBManager: NSObject {
    static var isMock: Bool = false
    private class func GetDatabaseInstance() -> NSManagedObjectContext {
        let database = DatabaseInstance.SharedInstance()
        database.isMock = isMock
        return database.managedObjectContext()
    }
    private class func GetPersistentCoordinator() -> NSPersistentStoreCoordinator? {
        let database = DatabaseInstance.SharedInstance()
        database.isMock = isMock
        return database.persistentStoreCoordinator
    }
    
    //MARK:- Shared functions
    private class func GetList(from entity: Entity, result: inout [BaseModel]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description)
        let managedContext = GetDatabaseInstance()
        if let fetchResults = (try? managedContext.fetch(fetchRequest)) {
            for record in fetchResults {
                if let rec = record as? BaseManagedObject {
                    result.append(ItemToModel(from: rec))
                }
            }
        }
    }
    private class func GetItem(from entity: Entity, With ID: Int, result: inout BaseModel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description)
        let managedContext = GetDatabaseInstance()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if let rec = fetchResults.first as? BaseManagedObject {
                result = ItemToModel(from: rec)
            }
        } catch {
            result = BaseModel()
        }
    }
    private class func InsertItem(into entity: Entity, item: BaseModel) -> Bool {
        let managedContext = GetDatabaseInstance()
        if var newItem = NSEntityDescription.insertNewObject(forEntityName: entity.description, into:managedContext) as? BaseManagedObject {
            ModelToItem(from: item, To: &newItem)
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        else {
            return false
        }
    }
    private class func RemoveItem(from entity: Entity, With ID: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description)
        let managedContext = GetDatabaseInstance()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        if let fetchResult = (try? managedContext.fetch(fetchRequest)) {
            if fetchResult.count == 1 {
                if let rec = fetchResult.first as? BaseManagedObject {
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
    private class func UpdateItem(from entity: Entity, To New: BaseModel, With ID: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description)
        let managedContext = GetDatabaseInstance()
        let fetchPredicate = NSPredicate(format: "id = \(ID)")
        fetchRequest.predicate = fetchPredicate
        
        if var fetchResult = (try? managedContext.fetch(fetchRequest))?.first as? BaseManagedObject {
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
        var result = [BaseModel]()
        GetList(from: Entity.BLEClone, result: &result)
        if let res = result as? [BLECloneModel] {
            return res
        }
        return [BLECloneModel]()
    }
    class func InsertNew(BLEItem: BLECloneModel) -> Bool {
        return InsertItem(into: Entity.BLEClone, item: BLEItem)
    }
    class func LoadBLECloneItem(With ID: Int) -> BLECloneModel? {
        var result = BaseModel()
        GetItem(from: Entity.BLEClone, With: ID, result: &result)
        return result as? BLECloneModel
    }
    class func RemoveBLECloneItem(With ID: Int) -> Bool {
        return RemoveItem(from: Entity.BLEClone, With: ID)
    }
    class func UpdateBLECloneItem(With ID: Int, To newItem: BLECloneModel) -> Bool {
        return UpdateItem(from: Entity.BLEClone, To: newItem, With: ID)
    }
    
    //MARK:- Changes Stack
    class func GetBLEStackItemList() -> [ChangesStackModel] {
        var result = [BaseModel]()
        GetList(from: Entity.BLEStack, result: &result)
        if let res = result as? [ChangesStackModel] {
            return res
        }
        return [ChangesStackModel]()
    }
    class func InsertNew(StackItem: ChangesStackModel) -> Bool {
        return InsertItem(into: Entity.BLEStack, item: StackItem)
    }
    class func LoadBLEStackItem(With ID: Int) -> ChangesStackModel? {
        var result = BaseModel()
        GetItem(from: Entity.BLEStack, With: ID, result: &result)
        return result as? ChangesStackModel
    }
    class func RemoveBLEStackItem(With ID: Int) -> Bool {
        return RemoveItem(from: Entity.BLEStack, With: ID)
    }
    class func UpdateBLEStackItem(With ID: Int, To newItem: ChangesStackModel) -> Bool {
        return UpdateItem(from: Entity.BLEStack, To: newItem, With: ID)
    }
    
    //MARK:- Local Attributes
    class func AddAttribute(Attributes: LocalAttributesModel) -> Bool {
        return InsertItem(into: Entity.LocalAttributes, item: Attributes)
    }
    class func LoadAttribute(With ID: Int) -> LocalAttributesModel? {
        var result = BaseModel()
        GetItem(from: Entity.LocalAttributes, With: ID, result: &result)
        return result as? LocalAttributesModel
    }
    class func RemoveAttribute(With ID: Int) -> Bool {
        return RemoveItem(from: Entity.LocalAttributes, With: ID)
    }
    class func UpdateAttribute(With ID: Int, To newAttribute: LocalAttributesModel) -> Bool {
        return UpdateItem(from: Entity.LocalAttributes, To: newAttribute, With: ID)
    }

    //MARK:- Dangerous Area
    class func Wipe(entity: Entity) -> Bool {
        var result = true
        var items = [BaseModel]()
        GetList(from: entity, result: &items)
        for item in items {
            result = result && RemoveItem(from: entity, With: Int(item.id))
        }
        return result
    }
}

extension DBManager {
    //MARK:- Item To Model
    private class func ItemToModel(from Item: BaseManagedObject) -> BaseModel {
        return Item.ItemToModel()
    }
    
    //MARK:- Model To Item
    private class func ModelToItem(from Model: BaseModel, To Item: inout BaseManagedObject) {
        Model.ModelToItem(Item: &Item)
    }
}
