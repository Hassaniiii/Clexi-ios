//
//  BLEClone+CoreDataClass.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//

import Foundation
import CoreData


class BLEClone: NSManagedObject {
    @nonobjc public class func FetchRequest() -> NSFetchRequest<BLEClone> {
        return NSFetchRequest<BLEClone>(entityName: "BLEClone")
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var appid: String?
    @NSManaged public var title: String?
    @NSManaged public var username: String?
    @NSManaged public var ble_local: LocalAttributes?
}
