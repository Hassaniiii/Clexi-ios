//
//  ListenForEventState.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-01-28.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class ListenForEventState: State {
    private var PacketManager: ResponsePacket!
    
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {}
    override func SendRequest(Type: PacketTypes, INS: Instructions, Data: [UInt8]) {}
    override func Receive(Data: [UInt8]) {
        PacketManager = ResponsePacket()
        PacketManager.PacketType = PacketTypes.Event
        PacketManager.AnalyzeData(rawData: Data)
        if PacketManager.APDUPackage.INS == Events.SingleClick.rawValue {
//            print("Single Click event is recieved")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Event_Received"), object: nil)
        }
        if PacketManager.APDUPackage.INS == Events.DoubleClick.rawValue {
//            print("Double Click event is recieved")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Event_Received"), object: nil)
        }
    }
}
