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
        PacketManager.AnalyzeData(rawData: Data)
        if PacketManager.APDUPackage.INS == 0x10 {
            print("Single Click event is recieved")
            NotificationManager.AddLocalNotification(Message: "Manager")
        }
        if PacketManager.APDUPackage.INS == 0x30 {
            #if DEBUG
                let items = DBController.GetBLECloneList().Sort(By: .LastUsed, Order: .orderedDescending)
                if let lastItem = items.first {
                    UIPasteboard.general.string = NSUserDefaultManager.LoadItem(lastItem.title) as? String ?? ""
                    _ = DBController.ItemIsUsed(With: Int(lastItem.id))
                    
                }
            #endif
            print("Double Click event is recieved")
        }
    }
}

class SendRequestState: State {
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {
        Manager.setState(Manager.ListenForResponse)
    }
    override func SendRequest() {}
    override func Receive(Data: [UInt8]) {}
}

class ListenForResponseState: State {
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {
        Manager.setState(Manager.ListenForEvent)
    }
    override func SendRequest() {}
    override func Receive(Data: [UInt8]) {}
}

class SendSyncState: State {
    override init(Manager: StateManager) {
        super.init(Manager: Manager)
    }
    override func NextState() {
        Manager.setState(Manager.ListenForResponse)
    }
    override func SendRequest() {}
    override func Receive(Data: [UInt8]) {}
}


