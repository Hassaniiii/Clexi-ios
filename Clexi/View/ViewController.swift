//
//  ViewController.swift
//  Clexi
//
//  Created by Hassaniiii on 10/23/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import BLEManager

class ViewController: UIViewController {

    internal let bleManager = BLEManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitiateBLE()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func InitiateBLE() {
        if CentralManager.sharedInstance().serviceUUIDs == nil {
            CentralManager.sharedInstance().serviceUUIDs = HID_ServiceUUID
            CentralManager.sharedInstance().serviceCharacteristic = HID_Characterstic
            CentralManager.sharedInstance().serviceNotifyCharacteristic = HID_NotifyCharacterstic
            
            CentralManager.sharedInstance().delegate = self
            CentralManager.sharedInstance().getPairedList()
        }
    }
}

extension ViewController: BLECentralManagerDelegate {
    func centralStateChanged(_ state: CBManagerState) {
        DispatchQueue.main.async {
            if state == .poweredOn {
                CentralManager.sharedInstance().connect()
            }
        }
    }
    func dongleFound(_ macAddress: String!) {
        DispatchQueue.main.async {
        }
    }
    func dongleConnected() {
        DispatchQueue.main.async {
        }
    }
    func dongleDisconnected() {
        DispatchQueue.main.async {
            CentralManager.sharedInstance().connect()
        }
    }
    func error(_ error: Error!) {
        DispatchQueue.main.async {
        }
    }
    func pairedDongles(_ pairedList: [Any]!) {
        DispatchQueue.main.async {
            if let _ = pairedList.first as? CBPeripheral {
                CentralManager.sharedInstance().connect()
            }
        }
    }
    func dongleRecived(_ data: Data!) {
        DispatchQueue.main.sync {
            let count = data.count / MemoryLayout<UInt8>.size
            var array = [UInt8](repeating: 0, count: count)
            data.copyBytes(to: &array, count:count * MemoryLayout<UInt8>.size)
            bleManager.DataReceived(array)
        }
    }
}
