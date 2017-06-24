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
        navigationController.navigationBar.tintColor = .white
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([navigationFiestasController], animated: true)
    }

}
