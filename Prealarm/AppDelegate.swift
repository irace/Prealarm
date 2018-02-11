//
//  AppDelegate.swift
//  Prealarm
//
//  Created by Bryan Irace on 2/10/18.
//  Copyright © 2018 Bryan Irace. All rights reserved.
//

import UIKit

let container = DependencyContainer()

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow()
    
    private var coordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        application.setMinimumBackgroundFetchInterval(container.backgroundFetchInterval)
        
        coordinator = AppCoordinator()
        
        window?.rootViewController = coordinator.viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        coordinator.performFetchWithCompletionHandler(completionHandler: completionHandler)
    }
}
