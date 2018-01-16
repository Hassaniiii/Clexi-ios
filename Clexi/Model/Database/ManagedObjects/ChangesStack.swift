//
//  ChangesStack+CoreDataClass.swift
//  Clexi
//
//  Created by Hassaniiii on 10/25/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//
//

import Foundation
import CoreData


class ChangesStack: BLEClone {
    @nonobjc public class func FetchRequest() -> NSFetchRequest<ChangesStack> {
        return NSFetchRequest<ChangesStack>(entityName: "ChangesStack")
    }
    
    @NSManaged public var password: String?
    @NSManaged public var changekey: Int16
    @NSManaged public var hashkey: String?
    
    override func ItemToModel() -> ChangesStackModel {
        let model = ChangesStackModel()
        
        model.appid = self.appid
        model.id = self.id
        model.title = self.title
        model.url = self.url
        model.username = self.username
        model.password = self.password
        model.changekey = ChangeKey(rawValue: self.changekey)
        model.hashKey = self.hashkey
        
        return model
    }
}
