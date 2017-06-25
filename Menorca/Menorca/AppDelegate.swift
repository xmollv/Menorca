//
//  AppDelegate.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataProvider: DataProvider!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        dataProvider = DataProvider()
        
        let tabBarController = TabBarController.instantiateFrom(.tabBar)
        tabBarController.dataProvider = dataProvider
        window?.rootViewController = tabBarController
        
        return true
    }
}
