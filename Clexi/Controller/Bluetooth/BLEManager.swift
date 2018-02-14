//
//  BLEManager.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/10/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit
import CoreBluetooth

let HID_ServiceUUID         = [CBUUID(string: "1812"),
                               CBUUID(string: "B36E1E00-4B56-3886-4C48-F903401B31F8")]
let HID_Characterstic       = CBUUID(string: "B36E1E01-4B56-3886-4C48-F903401B31F8")
let HID_NotifyCharacterstic = CBUUID(string: "B36E1E02-4B56-3886-4C48-F903401B31F8")

class BLEManager: NSObject {
    let State = StateManager()
    
    override init() {
        super.init()
    }
    
    func SendRequest(Type: PacketTypes, INS: Instructions, Data: [UInt8] = []) {
        State.sendRequest(Type: Type, INS: INS, Data: Data)
    }
    
    func SendSync() {
        State.sendSync()
    }
    
    func DataReceived(_ data: [UInt8]) {
        State.receive(data: data)
    }
}
