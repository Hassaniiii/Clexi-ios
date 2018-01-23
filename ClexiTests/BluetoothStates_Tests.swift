//
//  BluetoothStates_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 11/3/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class BluetoothStates_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tests_01_StateInitiate() {
        let State = StateManager()
        XCTAssertTrue(State.getState() as AnyObject? === State.ListenForEvent as AnyObject?)
    }
    func tests_02_SendRequest() {
        let State = StateManager()
        State.sendRequest()
        XCTAssertTrue(State.getState() as AnyObject? === State.SendRequest as AnyObject?)
        
        State.getState().NextState()
        XCTAssertTrue(State.getState() as AnyObject? === State.ListenForResponse as AnyObject?)
    }
    func tests_03_SendSync() {
        let State = StateManager()
        State.sendSync()
        XCTAssertTrue(State.getState() as AnyObject? === State.SendSync as AnyObject?)
        
        State.getState().NextState()
        XCTAssertTrue(State.getState() as AnyObject? === State.ListenForResponse as AnyObject?)
    }
    func tests_04_RequestTimeOut() {
        let State = StateManager()
        State.sendRequest()
        
        wait(for: 5)
        XCTAssertTrue(State.getState() as AnyObject? === State.ListenForEvent as AnyObject?)
    }
    func tests_05_Event() {
        let State = StateManager()
        let MockEvent = BluetoothPacket_Tests().CreateMockEventData(INS: 0x00)
        
        State.sendRequest()
        wait(for: 5)
        
        State.receive(data: MockEvent)
        XCTAssertTrue(State.getState() as AnyObject? === State.ListenForEvent as AnyObject?)
    }
}

extension BluetoothStates_Tests {
    func wait(for second: Double) {
        let date = Date(timeIntervalSinceNow: second)
        RunLoop.current.run(until: date)
    }
}
