//
//  ListenForEventState.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-01-28.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class ListenForEventState: State {
    private let Events = [0x10, 0x30]
    private var PacketManager: ResponsePacket!
    
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {}
    override func SendRequest() {}
    override func Receive(Data: [UInt8]) {
        PacketManager = ResponsePacket()
        PacketManager.PacketType = PacketTypes.Event
        PacketManager.AnalyzeData(rawData: Data)
        if PacketManager.APDUPackage.INS == 0x10 {
            print("Single Click event is recieved")
        }
        if PacketManager.APDUPackage.INS == 0x30 {
            print("Double Click event is recieved")
        }
    }
}
