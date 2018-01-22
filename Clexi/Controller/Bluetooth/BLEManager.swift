//
//  BLEManager.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/10/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

class BLEManager: NSObject {
    internal var PacketManager = ResponsePacket()
//    let package = BLEPackage()
    
    override init() {
        super.init()
    }
    
    func SendSyncRequest() {
//        package.SendRequest()
    }
    
    func DataReceived(_ data: [UInt8]) {
//        package.GetData(data)
        PacketManager.AnalyzeData(rawData: data)
    }
}
