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


class BLEClone: BaseManagedObject {
    
    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var appid: String?
    @NSManaged public var title: String?
    @NSManaged public var username: String?
    @NSManaged public var attributes: LocalAttributes
    
    override func ItemToModel() -> BLECloneModel {
        let model = BLECloneModel()
        
        model.appid = self.appid
        model.id = self.id
        model.title = self.title
        model.url = self.url
        model.username = self.username
        model.attributes = self.attributes.ItemToModel()
        
        return model
    }
}
