//
//  BaseModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/26/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreData

class BaseModel: NSObject {
    var managedContext: NSManagedObjectContext!
    var id:             Int16!
    
    func ModelToItem(Item: inout BaseManagedObject) {}
}
