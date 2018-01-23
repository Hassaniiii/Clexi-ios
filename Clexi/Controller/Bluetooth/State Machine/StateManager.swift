//
//  BLEState.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/6/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

protocol BLEState {
    var Manager: StateManager {get set}
    
    func NextState()
    func SendRequest()
    func Receive(Data: [UInt8])
}

class StateManager: NSObject {
    var ListenForEvent:     BLEState!
    var SendRequest:        BLEState!
    var ListenForResponse:  BLEState!
    var SendSync:           BLEState!
    
    var state:              BLEState!
    var timer =             Timer()
    
    override init() {
        super.init()
        
        ListenForEvent      = ListenForEventState(Manager: self)
        SendRequest         = SendRequestState(Manager: self)
        ListenForResponse   = ListenForResponseState(Manager: self)
        SendSync            = SendSyncState(Manager: self)
        setState(ListenForEvent)
    }
    
    func setState(_ state: BLEState) {
        self.state = state
    }
    func getState() -> BLEState {
        return self.state
    }
    
    func sendRequest() {
        setState(SendRequest)
        state.SendRequest()
        startTimeOut()
    }
    func sendSync() {
        setState(SendSync)
        state.SendRequest()
        startTimeOut()
    }
    func receive(data: [UInt8]) {
        state.Receive(Data: data)
    }
    
    func startTimeOut() {
        //wait for response ....
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                     selector: #selector(self.timedOut),
                                     userInfo: nil, repeats: false)
    }
    
    @objc func timedOut() {
        //Time out.
        timer.invalidate()
        setState(ListenForEvent)
    }
}
