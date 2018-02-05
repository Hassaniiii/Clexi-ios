//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Hassaniiii on 11/3/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import Clexi
import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var numbers: UIView!
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    @IBOutlet weak var SearchBox: UIView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var MatchSuggestion: UILabel!
    @IBOutlet weak var table: UITableView!
    private var tableItems = [BLECloneModel]()
    private var wholeItems = [BLECloneModel]()
    private var Keyboard: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 350, height: 180)
        
        #if DEBUG
            DBManager.isMock = true
            InsertMockBLEClone(Count: 10)
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.Keyboard = UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        self.Keyboard?.autoresizingMask = .flexibleBottomMargin
        becomeFirstResponder()
    }
    
    func didReceive(_ notification: UNNotification) {
        wholeItems = DBController.GetBLECloneList()
        tableItems = wholeItems
        GetSuggestion(firstLoading: true)
    }
    
    @IBAction func keyPressed(_ button: UIButton) {
        searchBar.insertText(button.titleLabel!.text!)
        textfieldDidChanged()
        AnimateClick(button)
    }
    
    @IBAction func backSpacePressed(_ button: UIButton) {
        searchBar.deleteBackward()
        textfieldDidChanged()
    }
    
    @IBAction func spacePressed(_ button: UIButton) {
        searchBar.insertText(" ")
        textfieldDidChanged()
    }
    
    @IBAction func CopyUsername(_ button: UIButton) {
        UIPasteboard.general.string = "hasan.shahbazi@rsa.ir"
        AnimateClick(button)
        self.searchBar.endEditing(true)
    }
    
    @IBAction func CopyPassword(_ button: UIButton) {
        UIPasteboard.general.string = "123456"
        AnimateClick(button)
    }
    
    private func AnimateClick(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = button.transform.scaledBy(x: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = button.transform.scaledBy(x: 0.5, y: 0.5)
        })
    }

    private func textfieldDidChanged() {
        tableItems = wholeItems.Search(for: searchBar.text!)
        GetSuggestion()
    }

    private func GetSuggestion(firstLoading initiate: Bool = false) {
        tableItems = tableItems.Sort(By: (initiate) ? .LastUsed : .Title)
        if let title = tableItems.first?.title {
            MatchSuggestion.text = title
        }
        else {
            tableItems = wholeItems
            MatchSuggestion.text = "There is nothing to show"
        }
        table.reloadData()
    }
}

extension NotificationViewController {
    override var inputView: UIView? {
        return Keyboard
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //Helper functions
    private func InsertMockBLEClone(Count: Int) {
        for counter in 0..<Count {
            let item = BLECloneModel()
            item.id = Int16(counter)
            item.title = "Title \(counter)"
            item.url = "URL"
            item.username = "Username"
            _ = DBController.InsertBLECloneItem(BLEItem: item)
        }
    }
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notification_cell") {
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = tableItems[indexPath.row].title
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}

