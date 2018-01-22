//
//  BaseManagedObject.swift
//  Clexi
//
//  Created by Hassaniiii on 10/26/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreData

class BaseManagedObject: NSManagedObject {
    func ItemToModel() -> BaseModel {
        return BaseModel()
    }
}
