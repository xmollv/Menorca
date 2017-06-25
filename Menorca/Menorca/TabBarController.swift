//
//  TabBarController.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var navigationFiestasController: UINavigationController = {
        let fiestasViewController = FiestasViewController.instantiateFrom(.fiestas)
        fiestasViewController.tabBarItem.title = "Fiestas"
        fiestasViewController.tabBarItem.image = UIImage(named:"horse")
        fiestasViewController.title = "Fiestas"
        
        let navigationController = UINavigationController(rootViewController: fiestasViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .purple
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        
        setViewControllers([navigationFiestasController], animated: true)
    }

}
