//
//  AppDelegate.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 02/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startScreen()
        return true
    }


}


extension AppDelegate {
    func startScreen() {
        window =  UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            let vc = MoviesListRouter.createModule()
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }

}
