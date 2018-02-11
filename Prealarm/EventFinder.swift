//
//  EventFinder.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit

final class EventFinder {
    // MARK: - Inputs
    
    private let store: EKEventStore
    private let calendar: Calendar

    // MARK: - Initialization
    
    init(store: EKEventStore, calendar: Calendar) {
        self.store = store
        self.calendar = calendar
    }
    
    // MARK: - Public
    
    func find(configuration: Configuration) -> [EKEvent] {
        let events = store
            .events(matching: alarmWorthyEventsPredicate(configuration: configuration))
            .filter({ event in
                // TODO: Filter weekends based on configuration
                !event.isAllDay
            })
        
        return events
    }
    
    // MARK: - Private
    
    private func alarmWorthyEventsPredicate(configuration: Configuration) -> NSPredicate {
        // TODO: Error handling
        
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let start = calendar.date(bySettingHour: configuration.startHour, minute: 0, second: 0, of: tomorrow)!
        let end = calendar.date(bySettingHour: configuration.endHour, minute: 0, second: 0, of: tomorrow)!
        
        return store.predicateForEvents(withStart: start, end: end, calendars: configuration.calendars)
    }
}
