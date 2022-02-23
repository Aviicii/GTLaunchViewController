//
//  AppDelegate.swift
//  GT
//
//  Created by jekun on 2022/1/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow.init(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window.makeKeyAndVisible()
        self.window.rootViewController = BaseTabbarVC()
        return true
    }

}

