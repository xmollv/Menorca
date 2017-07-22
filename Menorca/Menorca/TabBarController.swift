//
//  TabBarController.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: Class properties
    var dataProvider: DataProvider!
    
    lazy var navigationFiestasController: UINavigationController = {
        let fiestasViewController = FiestasViewController.instantiateFrom(.fiestas)
        fiestasViewController.dataProvider = self.dataProvider
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
    
    lazy var navigationBeachesController: UINavigationController = {
        let beachesViewController = BeachesViewController.instantiateFrom(.beaches)
        beachesViewController.dataProvider = self.dataProvider
        beachesViewController.tabBarItem.title = "Beaches"
        beachesViewController.tabBarItem.image = UIImage(named:"beach")
        beachesViewController.title = "Beaches"
        
        let navigationController = UINavigationController(rootViewController: beachesViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .purple
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        setViewControllers([navigationFiestasController, navigationBeachesController], animated: true)
    }

}
