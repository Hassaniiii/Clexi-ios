//
//  SendRequestState.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-01-28.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

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
