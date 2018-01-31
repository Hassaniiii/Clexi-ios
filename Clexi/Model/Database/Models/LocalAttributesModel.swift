//
//  LocalAttributesModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

class LocalAttributesModel: BaseModel {

    var popularity:     Int32!
    var lastused:       NSDate!
    
    override init() {
        super.init()
    }
    
    override func ModelToItem(Item: inout BaseManagedObject) {
        if var item = Item as? LocalAttributes {
            ModelToItem(Item: &item)
        }
    }
    func ModelToItem(Item: inout LocalAttributes) {
        Item.id = self.id
        Item.popularity = self.popularity
        Item.lastused = self.lastused
    }
}
