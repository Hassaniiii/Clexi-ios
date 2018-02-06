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

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var connectionStatus: UILabel!
    private let bleManager = BLEManager()
    private var tableItems = [BLECloneModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitiateBLE()
        self.LoadData()
        self.SetColors()
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

    private func SetColors() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.608858645, green: 0.1503358185, blue: 0.05381280929, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3442009687, green: 0.3491482139, blue: 0.3533577919, alpha: 1)
    }
    
    private func LoadData() {
        tableItems = DBController.GetBLECloneList().Sort(By: .Title, Order: .orderedDescending)
        #if DEBUG
            if tableItems.count == 0 {
                InsertMockBLEClone()
                tableItems = DBController.GetBLECloneList().Sort(By: .Title, Order: .orderedDescending)
            }
        #endif
        table.reloadData()
    }
    
    @IBAction func Reconnect(_ sender: UIButton) {
        CentralManager.sharedInstance().getPairedList()
    }
    
    //Helper functions
    private func InsertMockBLEClone() {
        var idCounter = 0
        let item = BLECloneModel()
        
        //LinkedIn
        item.id = Int16(idCounter)
        item.title = "linkedIn"
        item.url = "https://www.linkedin.com"
        item.username = "hassan.shahbazi70@gmail.com"
        _ = DBController.InsertBLECloneItem(BLEItem: item)
        NSUserDefaultManager.SaveItem("e@!\"4)b*4U7}:MDb", key: item.title)
        idCounter += 1
        
        //Changal
        item.id = Int16(idCounter)
        item.title = "Changal"
        item.url = "http://www.changal.com"
        item.username = "09368852532"
        _ = DBController.InsertBLECloneItem(BLEItem: item)
        NSUserDefaultManager.SaveItem("09368852532", key: item.title)
        idCounter += 1
        
        //Spotify
        item.id = Int16(idCounter)
        item.title = "spotify"
        item.url = "https://www.spotify.com"
        item.username = "h-shahbazi@hotmail.com"
        _ = DBController.InsertBLECloneItem(BLEItem: item)
        NSUserDefaultManager.SaveItem("Hassan$09368852532", key: item.title)
        idCounter += 1
        
        //Cinema Ticket
        item.id = Int16(idCounter)
        item.title = "cinema ticket"
        item.url = "https://cinematicket.org"
        item.username = "h-shahbazi@hotmail.com"
        _ = DBController.InsertBLECloneItem(BLEItem: item)
        NSUserDefaultManager.SaveItem("45324714", key: item.title)
        idCounter += 1
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
            self.connectionStatus.text = "Connected"
        }
    }
    func dongleDisconnected() {
        DispatchQueue.main.async {
            self.connectionStatus.text = "Disonnected"
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? MainListTableViewCell {
            cell.title.text = tableItems[indexPath.row].title
            cell.username.text = tableItems[indexPath.row].username
            cell.url.text = tableItems[indexPath.row].url
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
