//
//  APDU.swift
//  Vancopass
//
//  Created by Hassan Shahbazi on 9/11/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

import UIKit

class APDU: NSObject {
    var CLA:    UInt8! = 0x00
    var INS:    UInt8!
    var P1:     UInt8!
    var P2:     UInt8!
    var LC1:    UInt8!
    var LC2:    UInt8!
    var LC3:    UInt8!
    var Data =  [UInt8]()
    
    override init() {
        super.init()
    }
    
    func CreateAPDU() -> [UInt8] {
        self.LC1 = UInt8((self.Data.count & 0x0000ff00) >> 16)
        self.LC2 = UInt8((self.Data.count & 0x0000ff00) >> 8)
        self.LC3 = UInt8(self.Data.count & 0x000000ff)
        
        var APDUPackage = [UInt8]()
        APDUPackage.append(self.CLA)
        APDUPackage.append(self.INS)
        APDUPackage.append(self.P1)
        APDUPackage.append(self.P2)
        APDUPackage.append(self.LC1)
        APDUPackage.append(self.LC2)
        APDUPackage.append(self.LC3)
        APDUPackage.append(contentsOf: Data)
        
        return APDUPackage
    }
    
    func ExtractAPDU(from rawData: [UInt8]) {
        self.CLA = rawData[0]
        self.INS = rawData[1]
        self.P1 = rawData[2]
        self.P2 = rawData[3]
        self.LC1 = rawData[4]
        self.LC2 = rawData[5]
        self.LC3 = rawData[6]
        self.Data = [UInt8](rawData[7..<rawData.count])
    }
}
