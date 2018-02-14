//
//  PacketStructure.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/6/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit
import BLEManager

enum PacketTypes: UInt8 {
    case Event              = 0xc3
    case Info               = 0xc0
    case PasswordManager    = 0xd0
}

enum Events: UInt8 {
    case SingleClick = 0x10
    case DoubleClick = 0x30
}

enum Instructions: UInt8 {
    case GET_VERSION            = 0x10
    case BATTERY_STATUS, AM_I_SYNCED         = 0x20
}

class Packet: NSObject {
    var PacketType: PacketTypes!
    internal let APDUPackage = APDU()
    internal let PacketLength = 20
    internal var PacketQueue: [[UInt8]] = [[UInt8]]()
    
    override init() {
        super.init()
    }
    
    internal func SendDataToTerminal(_ index: Int) {
        let packet = PacketQueue[index]
        let data = Data(bytes: packet, count: packet.count)
        CentralManager.sharedInstance().write(data)
    }
    
}



