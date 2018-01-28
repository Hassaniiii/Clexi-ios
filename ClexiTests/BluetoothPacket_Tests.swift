//
//  BluetoothPacket_Tests.swift
//  ClexiTests
//
//  Created by Hassaniiii on 11/2/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class BluetoothPacket_Tests: XCTestCase {
    let mockDataLength = 350
    let mockEventDataLength = 1
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    //MARK:- Request packets
    func tesst_01_RequestPacketQueue() {
        let packet = RequestPacket(For: 0x01)
        packet.CreateReqPacket(INS: 0x00, Data: CreateMockRequestData())
  
        let expectedNumber = RoundUp(number: mockDataLength) / packet.PacketLength
        XCTAssertEqual(packet.PacketQueue.count, expectedNumber)
    }
    func tests_02_RequestPacketAPDU_Initiate() {
        let packet = RequestPacket(For: 0x01)
        packet.CreateReqPacket(INS: 0x00, Data: CreateMockRequestData())

        let expectedNumber = RoundUp(number: mockDataLength) + 7
        XCTAssertEqual(packet.ReqData.count, expectedNumber)
    }
    func tests_03_RequestPacketAPDU() {
        let packet = RequestPacket(For: 0x01)
        packet.CreateReqPacket(INS: 0x10, Data: CreateMockRequestData())
        
        XCTAssertEqual(packet.APDUPackage.CLA, 0x00)    //CLA
        XCTAssertEqual(packet.APDUPackage.INS, 0x10)    //INS
        XCTAssertEqual(packet.APDUPackage.P1, 0x00)     //P1
        XCTAssertEqual(packet.APDUPackage.P2, 0x00)     //P2
        
        let length = packet.APDUPackage.Data.count
        XCTAssertEqual(packet.APDUPackage.LC1, UInt8((length & 0x00ff0000) >> 16))  //LC1
        XCTAssertEqual(packet.APDUPackage.LC2, UInt8((length & 0x0000ff00) >> 8))   //LC2
        XCTAssertEqual(packet.APDUPackage.LC3, UInt8(length & 0x000000ff))          //LC3
    }
    
    //MARK:- Response packets
    func tests_11_EventReceived() {
        let packet = ResponsePacket()
        let rawData = RoundUp(array: CreateMockEventData(INS: 0x10))
        let packetNumbers = rawData.count/packet.PacketLength
        
        packet.PacketType = PacketTypes.Event
        packet.AnalyzeData(rawData: [UInt8](rawData[0..<packet.PacketLength])) //Initiate packet
        for index in 1..<packetNumbers {
            //continoues packets
            var data = [UInt8]()
            data.append(UInt8(index))
            data.append(contentsOf: [UInt8](rawData[index * packet.PacketLength ..< (index + 1) * packet.PacketLength]))
            
            packet.AnalyzeData(rawData: data)
        }
        XCTAssertEqual(packet.ResType, 0xc3)
        XCTAssertEqual(packet.ResLength, mockEventDataLength + 7) //APDU Header count is 7
        XCTAssertEqual(packet.ResData.count, packet.ResLength)
    }
    func tests_12_EventReceived_APDU() {
        let packet = ResponsePacket()
        let rawData = RoundUp(array: CreateMockEventData(INS: 0x10))
        let packetNumbers = rawData.count/packet.PacketLength
        
        packet.PacketType = PacketTypes.Event
        packet.AnalyzeData(rawData: [UInt8](rawData[0..<packet.PacketLength])) //Initiate packet
        for index in 1..<packetNumbers {
            //continoues packets
            var data = [UInt8]()
            data.append(UInt8(index))
            data.append(contentsOf: [UInt8](rawData[index * packet.PacketLength ..< (index + 1) * packet.PacketLength]))
            
            packet.AnalyzeData(rawData: data)
        }
        
        XCTAssertEqual(packet.APDUPackage.CLA, 0x00) //CLA
        XCTAssertEqual(packet.APDUPackage.INS, 0x10) //INS
        XCTAssertEqual(packet.APDUPackage.P1, 0x00) //P1
        XCTAssertEqual(packet.APDUPackage.P2, 0x00) //P2
        
        let length = packet.APDUPackage.Data.count
        XCTAssertEqual(packet.APDUPackage.LC1, UInt8((length & 0x00ff0000) >> 16)) //LC1
        XCTAssertEqual(packet.APDUPackage.LC2, UInt8((length & 0x0000ff00) >> 8)) //LC2
        XCTAssertEqual(packet.APDUPackage.LC3, UInt8(length & 0x000000ff)) //LC3
    }
    func tests_13_InvalidEventReceived() {
        let packet = ResponsePacket()
        let rawData = RoundUp(array: CreateMockEventData(Type: 0x00, INS: 0x10))
        let packetNumbers = rawData.count/packet.PacketLength
        
        packet.PacketType = PacketTypes.Event
        packet.AnalyzeData(rawData: [UInt8](rawData[0..<packet.PacketLength])) //Initiate packet
        for index in 1..<packetNumbers {
            //continoues packets
            var data = [UInt8]()
            data.append(UInt8(index))
            data.append(contentsOf: [UInt8](rawData[index * packet.PacketLength ..< (index + 1) * packet.PacketLength]))
            
            packet.AnalyzeData(rawData: data)
        }
        
        XCTAssertEqual(packet.APDUPackage.CLA, 0) //CLA
        XCTAssertNil(packet.APDUPackage.INS) //INS
        XCTAssertNil(packet.APDUPackage.P1) //P1
        XCTAssertNil(packet.APDUPackage.P2) //P2
        XCTAssertEqual(packet.APDUPackage.Data.count, 0) //Data
    }
}

extension BluetoothPacket_Tests {
    func RoundUp(array: [UInt8]) -> [UInt8] {
        let packet = Packet()
        var array = array
        array.append(contentsOf: Array(repeating: 0, count: packet.PacketLength - (array.count % packet.PacketLength)))
        return array
    }
    func RoundUp(number: Int) -> Int {
        let packet = Packet()
        return number + (number%packet.PacketLength)
    }

    func CreateMockRequestData() -> [UInt8] {
        var mockData = [UInt8]()
        for data in 0..<mockDataLength {
            mockData.append(UInt8(data%256))
        }
        return mockData
    }
    func CreateMockEventData(Type: UInt8 = 0xc3, INS: UInt8) -> [UInt8] {
        var mockData = [UInt8]()
        mockData.append(Type)
        mockData.append(UInt8(((mockEventDataLength + 7) & 0x00ff0000) >> 16))
        mockData.append(UInt8(((mockEventDataLength + 7) & 0x0000ff00) >> 8))
        mockData.append(UInt8((mockEventDataLength + 7) & 0x000000ff))
        
        //set apdu data headers
        mockData.append(0x00)
        mockData.append(INS)
        mockData.append(0x00)
        mockData.append(0x00)
        mockData.append(UInt8((mockEventDataLength & 0x00ff0000) >> 16))
        mockData.append(UInt8((mockEventDataLength & 0x0000ff00) >> 8))
        mockData.append(UInt8(mockEventDataLength & 0x000000ff))
        
        mockData.append(UInt8(0x00))
        return mockData
    }
}
