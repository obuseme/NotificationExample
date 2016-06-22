//
//  NotificationManager.swift
//  NotificationExample
//
//  Created by Andy Obusek on 6/21/16.
//  Copyright © 2016 Clean Swifter. All rights reserved.
//

import UIKit
import UserNotifications

enum NotificationActions: String {
    case HighFive = "highfiveidentifier"
}

class NotificationManager: NSObject {

    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization([.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.setupAndGenerateLocalNotification()
            }
        }
    }

    func setupAndGenerateLocalNotification() {
        // Register an Actionable Notification
        let highFiveAction = UNNotificationAction(identifier: NotificationActions.HighFive.rawValue, title: "High Five", options: [])
        let category = UNNotificationCategory(identifier: "wassup", actions: [highFiveAction], minimalActions: [highFiveAction], intentIdentifiers: [], options: [.customDismissAction])
        UNUserNotificationCenter.current().setNotificationCategories([category])

        let highFiveContent = UNMutableNotificationContent()
        highFiveContent.title = "Wassup?"
        highFiveContent.body = "Can I get a high five?"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let highFiveRequestIdentifier = "sampleRequest"
        let highFiveRequest = UNNotificationRequest(identifier: highFiveRequestIdentifier, content: highFiveContent, trigger: trigger)
        UNUserNotificationCenter.current().add(highFiveRequest) { (error) in
            // handle the error if needed
            print(error)
        }
    }

}

extension NotificationManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {

        // Response has actionIdentifier, userText, Notification (which has Request, which has Trigger and Content)
        switch response.actionIdentifier {
        case NotificationActions.HighFive.rawValue:
            print("High Five Delivered!")
        default: break
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {

        // Delivers a notification to an app running in the foreground.
    }
}
