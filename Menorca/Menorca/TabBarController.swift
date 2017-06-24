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
        fiestasViewController.title = "Fiestas"
        
        let navigationController = UINavigationController(rootViewController: fiestasViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .mediumCandy
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .mediumCandy
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        
        setViewControllers([navigationFiestasController], animated: true)
    }

}
