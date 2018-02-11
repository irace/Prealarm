//
//  DependencyContainer.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit
import UserNotifications

final class DependencyContainer {
    var backgroundFetchInterval: TimeInterval {
        return 3600 * 4
    }
    
    var eventStore: EKEventStore {
        return EKEventStore()
    }
    
    var eventFinder: EventFinder {
        return EventFinder(store: eventStore, calendar: calendar)
    }
    
    var notificationCenter: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }
    
    var notificationScheduler: NotificationScheduler {
        return NotificationScheduler(notificationCenter: notificationCenter, calendar: calendar)
    }
    
    var calendar: Calendar {
        return Calendar.current
    }
}
