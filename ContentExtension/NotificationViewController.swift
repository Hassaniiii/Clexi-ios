//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Hassaniiii on 11/3/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    private var tableItems = [String]()
    private let iconboard = Iconboard()
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 350, height: 20)
        searchBar.delegate = self
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
//                                     repeats: true,
//                                     block: { _ in
//                                        let text = self.searchBar.text
//                                        self.searchBar.text = text!.appending("a")
//                                        self.searchBar(self.searchBar,
//                                                       textDidChange: self.searchBar.text!)
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }
    
    func didReceive(_ notification: UNNotification) {
        tableItems = ["First item", "Second item", "Third item", "Final item"]
        table.reloadData()
    }
}

extension NotificationViewController {
    override var inputView: UIView? {
        return iconboard
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
}

extension NotificationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if tableItems.count > 0 {
            tableItems.removeLast()
            table.reloadData()
        }
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello world")
    }
}
extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notification_cell") {
            if let titleLabel = cell.viewWithTag(1) as? UILabel {
                titleLabel.text = tableItems[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}

