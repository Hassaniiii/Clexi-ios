//
//  ChangesStack+CoreDataProperties.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//

import Foundation
import CoreData


extension ChangesStack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChangesStack> {
        return NSFetchRequest<ChangesStack>(entityName: "ChangesStack")
    }

    @NSManaged public var password: String?
    @NSManaged public var changekey: Int16
    @NSManaged public var hashkey: String?

}
