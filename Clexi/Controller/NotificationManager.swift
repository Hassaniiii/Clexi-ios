//
//  NotificationManager.swift
//  SimpleToDo
//
//  Created by Hassaniiii on 8/20/1396 AP.
//  Copyright © 1396 AP Hassan Shahbazi. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {

    class func AddLocalNotification(Message: String) {
        let notification = UNMutableNotificationContent()
        notification.sound = UNNotificationSound.default()
        notification.subtitle = Message
        notification.body = "Expand the notification for more options"
        notification.categoryIdentifier = "Event"
  
        let category = UNNotificationCategory(identifier: "Event",
                                              actions: [],
                                              intentIdentifiers: [],
                                              options: [])
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: GenerateFireDate(), repeats: false)
        let request = UNNotificationRequest(identifier: "Event",
                                            content: notification,
                                            trigger: notificationTrigger)
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    class func CancelLocalNotification(Index: Int) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(Index)"])
    }
    
    class private func GenerateFireDate() -> DateComponents {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        var component = calendar.dateComponents([.nanosecond], from: Date())
        component.nanosecond! += 10
        return component
    }
}

