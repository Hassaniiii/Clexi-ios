//
//  LocalAttributesModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

class LocalAttributesModel: BaseModel {

    var id:             Int16!
    var popularity:     Int32!
    var lastused:       NSDate!
    
    override init() {
        super.init()
    }
    
    override func ModelToItem(Item: inout BaseManagedObject) {
        if let item = Item as? LocalAttributes {
            item.id = self.id
            item.popularity = self.popularity
            item.lastused = self.lastused
        }
    }
}
