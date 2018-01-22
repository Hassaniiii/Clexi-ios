//
//  ChangesStackModel.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

enum ChangeKey: Int16 {
    case Insert
    case Remove
    case Update
    var desciption: Int16 {
        switch self {
            case .Insert: return 0
            case .Remove: return 1
            case .Update: return 2
        }
    }
}

class ChangesStackModel: BaseModel {
    var appid:      String?
    var id:         Int16!
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
            item.changekey = self.changekey.desciption
            item.hashkey = self.hashKey
        }
    }
}
