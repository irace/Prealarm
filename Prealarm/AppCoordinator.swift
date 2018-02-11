//
//  AppCoordinator.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import EventKit
import UIKit
import UserNotifications

final class AppCoordinator {
    // MARK: - Dependenceis
    
    private let eventStore = container.eventStore
    private let eventFinder = container.eventFinder
    private let notificationCenter = container.notificationCenter
    private let notificationScheduler = container.notificationScheduler
    
    // MARK: - UIViewController
    
    let viewController = ViewController()
    
    // MARK: - Mutable state
    
    let configuration = Configuration()
    
    // MARK: - Public
    
    func start() {
        // TODO: Error handling
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            self.notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                self.scheduleNotifications()
            }
        }
    }
    
    func performFetchWithCompletionHandler(completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        scheduleNotifications()
        
        // TODO: What value should be passed here?
        completionHandler(.newData)
    }
    
    // MARK: - Private
    
    private func scheduleNotifications() {
        notificationScheduler.schedule(
            events: eventFinder.find(configuration: configuration),
            configuration: configuration
        )
    }
}
