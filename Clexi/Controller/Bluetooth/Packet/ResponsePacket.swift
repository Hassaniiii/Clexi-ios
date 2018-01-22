//
//  ResponsePacket.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/11/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

class ResponsePacket: Packet {
    private var ReceivedLastIndex = 0
    
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
        if ResLength == 0 {
            GetInitiatePacket(rawData: rawData)
        }
        else {
            GetContinouesPacket(rawData: rawData)
        }
        if self.ResData.count == self.ResLength {
            CreateAPDU()
        }
    }
    
    private func GetInitiatePacket(rawData: [UInt8]) {
        //Initiate packet received
        ResType = rawData[0]
        ResLength = GetLengthOf(firstByte: rawData[1], secondByte: rawData[2], thirdByte: rawData[3])
        
        var index = 4
        while(ResData.count != ResLength && index < rawData.count) {
            ResData.append(rawData[index])
            index += 1
        }
    }
    
    private func GetContinouesPacket(rawData: [UInt8]) {
        //continues packets
        var index = 1
        
        ResSeq = Int(rawData[0])
        while(ResData.count != ResLength && index < rawData.count) {
            ResData.append(rawData[index])
            index += 1
        }
    }
    
    private func CreateAPDU() {
        APDUPackage.ExtractAPDU(from: ResData)
    }
    
    private func GetLengthOf(firstByte: UInt8, secondByte: UInt8, thirdByte: UInt8) -> Int {
        let array : [UInt8] = [0x00, firstByte, secondByte, thirdByte]
        var value : Int = 0
        for byte in array {
            value = value << 8
            value = value | Int(byte)
        }
        return value
    }
}


