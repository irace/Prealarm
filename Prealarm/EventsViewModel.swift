//
//  EventsViewModel.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit

struct EventViewModel: CustomStringConvertible {
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    // MARK: - CustomStringConvertible
    
    let description: String

    // MARK: - Initialization
    
    init(event: EKEvent) {
        let formattedDate = EventViewModel.dateFormatter.string(from: event.startDate)
        
        let title = event.title ?? "Event"
        
        if let location = event.location, location.count > 0 {
            description = "\(title) (\(formattedDate) at \(location))"
        }
        else {
            description = "\(title) (\(formattedDate))"
        }
    }
}

struct EventsViewModel: CustomStringConvertible {
    let eventViewModels: [EventViewModel]
    
    // MARK: - CustomStringConvertible
    
    let description: String
    
    // MARK: - Initialization
    
    init(events: [EKEvent]) {
        eventViewModels = events.map(EventViewModel.init)
        
        description = eventViewModels
            .map({
                $0.description
            })
            .joined(separator: ", ")
    }
}
