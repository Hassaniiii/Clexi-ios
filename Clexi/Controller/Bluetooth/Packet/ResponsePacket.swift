//
//  ResponsePacket.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/11/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

class ResponsePacket: Packet {
    private var ReceivedLastIndex = -1
    
    internal var ResType:   UInt8!
    internal var ResLength: Int = 0
    internal var ResSeq:    Int = -1
    internal var ResData =  [UInt8]()
    
    override init() {
        super.init()
    }
    
    func AnalyzeData(rawData: [UInt8]) {
        ExtractRawData(rawData: rawData)
    }
    
    private func ExtractRawData(rawData: [UInt8]) {
        if CheckInitiatePacket(of: rawData) {
            GetInitiatePacket(rawData: rawData)
        }
        if CheckContinuesPacket(of: rawData) {
            GetContinouesPacket(rawData: rawData)
        }
        if CheckBadSEQ() {
            //Differ by request
        }
        if CheckCompletion() {
            CreateAPDU()
        }
    }
    
    private func GetInitiatePacket(rawData: [UInt8]) {
        //Initiate packet received
        ResType = rawData[0]
        ResLength = Aggregation(one: rawData[1], two: rawData[2], three: rawData[3])
        
        var index = 4
        while(ResData.count != ResLength && index < rawData.count) {
            ResData.append(rawData[index])
            index += 1
        }
    }
    
    private func GetContinouesPacket(rawData: [UInt8]) {
        //continues packets
        var index = 1
        ReceivedLastIndex += 1
        ResSeq = Aggregation(one: rawData[0], two: rawData[2], three: rawData[3])
        
        while(ResData.count != ResLength && index < rawData.count) {
            ResData.append(rawData[index])
            index += 1
        }
    }
    
    private func CreateAPDU() {
        APDUPackage.ExtractAPDU(from: ResData)
    }
    
    private func Aggregation(one: UInt8, two: UInt8, three: UInt8) -> Int {
        let array : [UInt8] = [0x00, one, two, three]
        var value : Int = 0
        for byte in array {
            value = value << 8
            value = value | Int(byte)
        }
        return value
    }
}

extension ResponsePacket {
    private func CheckInitiatePacket(of rawData: [UInt8]) -> Bool {
        return (ResLength == 0) //checkt current length
            && (PacketType.rawValue == rawData[0]) //check packet type
    }
    private func CheckContinuesPacket(of rawData: [UInt8]) -> Bool {
        return (ResLength > 0) //check current length
            && (rawData[0] == 0x00) //check SEQ most valuable byte
    }
    private func CheckBadSEQ() -> Bool {
        return ReceivedLastIndex != ResSeq //current SEQ is different from expected SEQ
    }
    private func CheckCompletion() -> Bool {
        return (ResData.count == ResLength)
            && (ResData.count > 6) //check for APDU headers
    }
}

