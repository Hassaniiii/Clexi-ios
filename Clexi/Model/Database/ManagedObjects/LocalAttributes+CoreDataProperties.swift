//
//  LocalAttributes+CoreDataProperties.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//

import Foundation
import CoreData


extension LocalAttributes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalAttributes> {
        return NSFetchRequest<LocalAttributes>(entityName: "LocalAttributes")
    }

    @NSManaged public var id: Int16
    @NSManaged public var popularity: Int32
    @NSManaged public var lastused: NSDate?
    @NSManaged public var local_ble: BLEClone?

}
