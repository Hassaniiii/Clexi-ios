//
//  ChangesStackModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

enum ChangeKey: Int16 {
    case Insert = 0
    case Remove = 1
    case Update = 2
}

class ChangesStackModel: BaseModel {
    var appid:      String?
    var title:      String!
    var url:        String?
    var username:   String?
    var password:   String?
    var changekey:  ChangeKey!
    var hashKey:    String?
    
    override init() {
        super.init()
    }
    
    override func ModelToItem(Item: inout BaseManagedObject) {
        if let item = Item as? ChangesStack {
            item.appid = self.appid
            item.id = self.id
            item.url = self.url
            item.title = self.title
            item.username = self.username
            item.password = self.password
            item.changekey = self.changekey.rawValue
            item.hashkey = self.hashKey
        }
    }
}
