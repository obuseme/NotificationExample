//
//  ViewController.swift
//  NotificationExample
//
//  Created by Andy Obusek on 6/21/16.
//  Copyright © 2016 Clean Swifter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func deliverHighFiveTapped(_ sender: AnyObject) {
        let notificationManger = NotificationManager()
        notificationManger.registerForNotifications()
    }

}

