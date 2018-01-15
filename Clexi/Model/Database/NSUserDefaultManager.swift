//
//  NSUserDefaultManager.swift
//  Clexi
//
//  Created by Hassaniiii on 10/24/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit

//App messages
let Error               = "Error"
let OK                  = "OK"
let Reinstallation      = "Reinstall Application"

//Keys
let App_Key             = "ClexiApp"

class NSUserDefaultManager: NSObject {
    class func SaveItem(_ item: Any, key: String) {
        UserDefaults(suiteName: App_Key)?.set(item, forKey: key)
    }
    
    class func LoadItem(_ key: String) -> Any? {
        return UserDefaults(suiteName: App_Key)?.value(forKey: key)
    }
    
    class func RemoveItem(_ key: String) {
        if let _ = LoadItem(key) {
            UserDefaults(suiteName: App_Key)?.removeObject(forKey: key)
        }
    }
}
