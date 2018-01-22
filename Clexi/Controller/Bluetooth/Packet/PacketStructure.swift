//
//  PacketStructure.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/6/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit
import BLEManager

class Packet: NSObject {
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



