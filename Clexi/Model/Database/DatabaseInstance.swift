//
//  DatabaseInstance.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//https://gist.github.com/papallas/b7dc2f32769a369425c35a85b86d13ad

import UIKit
import CoreData

class DatabaseInstance: NSObject {
    var isMock: Bool = false
    private static var sharedInstance = DatabaseInstance()
    private override init() {
        super.init()
    }
    class func SharedInstance() -> DatabaseInstance {
        return sharedInstance
    }
    
    func managedObjectContext() -> NSManagedObjectContext {
        return managedObjectContextLazy
    }
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "ClexiDB", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var secureAppGroupPersistentStoreURL : URL = {
        let fileManager = FileManager.default
        let groupDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: App_Group)!
        return groupDirectory.appendingPathComponent("ClexiDB.sqlite")
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = secureAppGroupPersistentStoreURL
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            if DatabaseInstance.SharedInstance().isMock {
                try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            }
            else {
                try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            }
        } catch var error1 as NSError {
            let alertController = UIAlertController(
                title: Error,
                message: Reinstallation,
                preferredStyle: UIAlertControllerStyle.alert
            )
            
            let confirmAction = UIAlertAction(
            title: OK, style: UIAlertActionStyle.default) { (action) in
                exit(0)
            }
            
            alertController.addAction(confirmAction)
//            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.present(alertController, animated: true,  completion: nil)
            
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

}

