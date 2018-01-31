//
//  BLECloneModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreData

class BLECloneModel: BaseModel {
    var appid:      String?
    var title:      String!
    var url:        String?
    var username:   String?
    var attributes: LocalAttributesModel?
    
    override init() {
        super.init()
    }
    
    override func ModelToItem(Item: inout BaseManagedObject) {
        if let item = Item as? BLEClone {
            
            item.appid = self.appid
            item.id = self.id
            item.url = self.url
            item.title = self.title
            item.username = self.username
            
            if let currentAttribute = self.attributes {
                if var attribute = NSEntityDescription.insertNewObject(forEntityName: Entity.LocalAttributes.rawValue, into: managedContext) as? LocalAttributes {
                    
                    currentAttribute.ModelToItem(Item: &attribute)
                    item.attributes = attribute
                }
            }
        }
    }
}

