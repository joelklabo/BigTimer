//
//  NotificationController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/15/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationController {
    
    static let instance = NotificationController()
    
    fileprivate let notificationCenter = NotificationCenter.default
    fileprivate let enterFore = NSNotification.Name.UIApplicationDidBecomeActive
    fileprivate let enterBack = NSNotification.Name.UIApplicationWillResignActive
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("notifications are enabled: \(granted)")
        }
        notificationCenter.addObserver(self, selector: #selector(enteringForeground), name: enterFore, object: nil)
    }
    
    func notifyDone(timeLeft: Double) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.body = "Timer Done"
        notificationContent.sound = UNNotificationSound(named: AlertSound.getPreference().fileName())
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeLeft, repeats: false)
        let notification = UNNotificationRequest(identifier: "timerDone", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notification) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    @objc func enteringForeground() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func setupNotification(timerState: TimerState) {
        let timeLeft = timerState.timerValue
        let timerDirection = timerState.direction
        let timerIsRunning = timerState.isRunning
        if ((timerDirection == .down) && (timeLeft > 0) && timerIsRunning) {
            NotificationController.instance.notifyDone(timeLeft: timeLeft)
        }
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}
