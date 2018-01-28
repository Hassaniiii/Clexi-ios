//
//  BLEContext.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/6/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

class State: NSObject, BLEState {
    var Manager: StateManager
    init(Manager: StateManager) {
        self.Manager = Manager
        super.init()
    }
    
    func NextState() {}
    func SendRequest() {}
    func Receive(Data: [UInt8]) {}
}


