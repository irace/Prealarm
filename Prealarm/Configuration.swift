//
//  Configuration.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit

struct Configuration {
    let startHour: Int = 7
    let endHour: Int = 11
    let triggerHour: Int = 20
    let calendars: [EKCalendar]? = nil
}
