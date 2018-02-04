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

    var capsLockOn = true
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    @IBOutlet weak var row5: UIView!
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    private var tableItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 350, height: 180)
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }
    
    func didReceive(_ notification: UNNotification) {
        tableItems = ["First item", "Second item", "Third item", "Final item"]
        table.reloadData()
    }
    
    @IBAction func nextKeyboardPressed(_ button: UIButton) {
        //        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(_ button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
    }
    
    @IBAction func keyPressed(_ button: UIButton) {
        let string = button.titleLabel!.text
        (searchBar.value(forKey: "searchField") as! UIKeyInput).insertText("\(string!)")
        AnimateClick(button)
    }
    
    @IBAction func backSpacePressed(_ button: UIButton) {
        (searchBar.value(forKey: "searchField") as! UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(_ button: UIButton) {
        (searchBar.value(forKey: "searchField") as! UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(_ button: UIButton) {
        (searchBar.value(forKey: "searchField") as! UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(_ button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            charSet1.isHidden = true
            charSet2.isHidden = false
            button.setTitle("2/2", for: .normal)
        } else if button.titleLabel!.text == "2/2" {
            charSet1.isHidden = false
            charSet2.isHidden = true
            button.setTitle("1/2", for: .normal)
        }
    }
    
    @IBAction func CopyUsername(_ button: UIButton) {
        UIPasteboard.general.string = "hasan.shahbazi@rsa.ir"
        AnimateClick(button)
    }
    
    @IBAction func CopyPassword(_ button: UIButton) {
        UIPasteboard.general.string = "123456"
        AnimateClick(button)
    }
    
    func AnimateClick(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = button.transform.scaledBy(x: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = button.transform.scaledBy(x: 0.5, y: 0.5)
        })
    }
    
    func changeCaps(_ containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased()
                    button.setTitle("\(text)", for: .normal)
                } else {
                    let text = buttonTitle!.lowercased()
                    button.setTitle("\(text)", for: .normal)
                }
            }
        }
    }
}

extension NotificationViewController {
    override var inputView: UIView? {
        if let keyboard = UINib(nibName: "KeyboardView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView {
            charSet2.isHidden = true
            return keyboard
        }
        return UIView()
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

