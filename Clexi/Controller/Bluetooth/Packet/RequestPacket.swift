//
//  RequestPacket.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/11/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit
import BLEManager

class RequestPacket: Packet {
    private var PacketLastIndex = 0
    
    internal var ReqData =  [UInt8]()
    internal var ReqType:   UInt8!
    internal var ReqSeq:    UInt8!
    
    init(For type: UInt8? = nil) {
        super.init()
        
        self.PacketLastIndex = 0
        self.ReqType = type ?? 0x01
    }
    
    func CreateReqPacket(INS: UInt8, Data: [UInt8]) {
        var Data = Data
        SizePacket(&Data)

        APDUPackage.INS = INS
        APDUPackage.P1 = 0x00
        APDUPackage.P2 = 0x00
        APDUPackage.Data = Data
        ReqData = APDUPackage.CreateAPDU()
        
        PacketQueue.append(InitiatePacket())
        for index in 1..<ReqData.count / PacketLength {
            PacketQueue.append(ContinuesPacket(index))
        }
        SendDataToTerminal(PacketLastIndex)
    }
    
    private func SizePacket(_ rawData: inout [UInt8]) {
        rawData.append(contentsOf: Array(repeating: 0, count: PacketLength - (rawData.count % PacketLength)))
    }
    
    //MARK:- Preparing data for BLE Interface communication
    private func InitiatePacket() -> [UInt8] {
        var data = [UInt8]()
        
        data.append(ReqType)
        data.append(UInt8((ReqData.count & 0x00ff0000) >> 16))
        data.append(UInt8((ReqData.count & 0x0000ff00) >> 8))
        data.append(UInt8(ReqData.count & 0x000000ff))
        for index in 0..<PacketLength {
            data.append(ReqData[index])
        }
        return data
    }
    private func ContinuesPacket(_ index: Int) -> [UInt8] {
        var data = [UInt8]()
        
        data.append(UInt8(index-1))
        for byte in (PacketLength * index ..< PacketLength * (index + 1)) {
            data.append(ReqData[byte])
        }
        return data
    }
}
