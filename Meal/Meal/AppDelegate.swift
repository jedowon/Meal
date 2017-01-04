//
//  AppDelegate.swift
//  Meal
//
//  Created by sunrin software10 on 2016. 12. 26..
//  Copyright © 2016년 sunrin software10. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        let mealListViewController = MealListViewController()
        let navigationController = UINavigationController(
            rootViewController: mealListViewController
            )
        self.window?.rootViewController = navigationController
        
        return true
    }
    
}
