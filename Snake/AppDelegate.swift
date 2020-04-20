//
//  AppDelegate.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Unit test mode
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            window?.rootViewController = UIViewController()
        }
        return true
    }
}

