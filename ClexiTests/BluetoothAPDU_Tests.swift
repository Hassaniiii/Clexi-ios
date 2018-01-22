//
//  BluetoothAPDU_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 11/2/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class BluetoothAPDU_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tests_01_ExtractAPDU() {
        let packet = APDU()
        packet.ExtractAPDU(from: MockAPDUData())
        
        XCTAssertNotNil(packet)
        XCTAssertEqual(packet.CLA, 0x00)
        XCTAssertEqual(packet.INS, 0x01)
        XCTAssertEqual(packet.P1, 0x02)
        XCTAssertEqual(packet.P2, 0x03)
        XCTAssertEqual(packet.LC1, 0x04)
        XCTAssertEqual(packet.LC2, 0x05)
        XCTAssertEqual(packet.LC3, 0x06)
        XCTAssertEqual(packet.Data.count, 64)
    }
    
    func tests_02_CreateAPDU() {
        let result = MockRawData().CreateAPDU()
        
        XCTAssertEqual(result.count, 71)
        XCTAssertEqual(result[0], 0x00) //CLA
        XCTAssertEqual(result[1], 0x01) //INS
        XCTAssertEqual(result[2], 0x02) //P1
        XCTAssertEqual(result[3], 0x03) //P2
        XCTAssertEqual(result[4], 0x00) //LC1
        XCTAssertEqual(result[5], 0x00) //LC2
        XCTAssertEqual(result[6], 0x40) //LC3
    }
}


extension BluetoothAPDU_Tests {
    func MockAPDUData() -> [UInt8] {
        var APDU = [UInt8]()
        APDU.append(0x00) //CLA
        APDU.append(0x01) //INS
        APDU.append(0x02) //P1
        APDU.append(0x03) //P2
        APDU.append(0x04) //LC1
        APDU.append(0x05) //LC2
        APDU.append(0x06) //LC3
        for _ in 0..<64 {
            APDU.append(0x7)
        }
        return APDU
    }
    func MockRawData() -> APDU {
        let packet = APDU()
        packet.INS = 0x01
        packet.P1 = 0x02
        packet.P2 = 0x03
        
        var data = [UInt8]()
        for _ in 0..<64 {
            data.append(0x07)
        }
        packet.Data = data
        return packet
    }
}
