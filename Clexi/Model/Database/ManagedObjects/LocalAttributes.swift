//
//  LocalAttributes+CoreDataClass.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//

import Foundation
import CoreData


class LocalAttributes: BaseManagedObject {
    @nonobjc public class func FetchRequest() -> NSFetchRequest<LocalAttributes> {
        return NSFetchRequest<LocalAttributes>(entityName: "LocalAttributes")
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var popularity: Int32
    @NSManaged public var lastused: NSDate?
    
    override func ItemToModel() -> LocalAttributesModel {
        let model = LocalAttributesModel()

        model.id = self.id
        model.popularity = self.popularity
        model.lastused = self.lastused

        return model
    }
}
