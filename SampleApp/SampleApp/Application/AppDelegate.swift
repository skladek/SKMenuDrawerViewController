//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Sean on 7/5/17.
//  Copyright © 2017 Sean. All rights reserved.
//

import SKMenuDrawerViewController
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = MenuDrawerViewController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}

