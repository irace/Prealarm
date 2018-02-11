//
//  NotificationScheduler.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit
import UserNotifications

final class NotificationScheduler {
    // MARK: - Inputs
    
    private let calendar: Calendar
    private let notificationCenter: UNUserNotificationCenter

    // MARK: - Initialization
    
    init(notificationCenter: UNUserNotificationCenter, calendar: Calendar) {
        self.notificationCenter = notificationCenter
        self.calendar = calendar
    }
    
    // MARK: - Public
    
    func schedule(events: [EKEvent], configuration: Configuration) {
        notificationCenter.removeAllPendingNotificationRequests()
        
        if !events.isEmpty {
            let request = UNNotificationRequest(
                identifier: "PrealarmNotification",
                content: content(events: events),
                trigger: trigger(configuration: configuration)
            )
            
            notificationCenter.add(request, withCompletionHandler: { (error) in
                // TODO: Error handling
            })
            
            print("Scheduled notification request: \(request)")
        }
    }
    
    // MARK: - Private
    
    private func content(events: [EKEvent]) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Hey! You may need a special alarm"
        content.body = EventsViewModel(events: events).description
        content.sound = UNNotificationSound.`default`()
        
        return content
    }
    
    private func trigger(configuration: Configuration) -> UNNotificationTrigger {
        // TODO: Error handling
        
        let date = calendar.date(bySettingHour: configuration.triggerHour, minute: 0, second: 0, of: Date())!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        return UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    }
}
