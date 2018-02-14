//
//  SendRequestState.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-01-28.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SendRequestState: State {
    private var PacketManager: RequestPacket!
    
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {
        Manager.setState(Manager.ListenForResponse)
    }
    override func SendRequest(Type: PacketTypes, INS: Instructions, Data: [UInt8]) {
        PacketManager = RequestPacket(For: Type.rawValue)
        PacketManager.PacketType = Type
        PacketManager.CreateReqPacket(INS: INS.rawValue, Data: Data)
    }
    override func Receive(Data: [UInt8]) {}
}
