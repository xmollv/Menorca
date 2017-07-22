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
        fiestasViewController.tabBarItem.image = UIImage(named: "horse")
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
        beachesViewController.tabBarItem.image = UIImage(named: "beach")
        beachesViewController.title = "Beaches"
        
        let navigationController = UINavigationController(rootViewController: beachesViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()
    
    lazy var navigationCamiDeCavallsController: UINavigationController = {
        let camiDeCavallsViewController = CamiDeCavallsViewController.instantiateFrom(.camiDeCavalls)
        camiDeCavallsViewController.dataProvider = self.dataProvider
        camiDeCavallsViewController.tabBarItem.title = "Camí de Cavalls"
        camiDeCavallsViewController.tabBarItem.image = UIImage(named: "trek")
        camiDeCavallsViewController.title = "Camí de Cavalls"
        
        let navigationController = UINavigationController(rootViewController: camiDeCavallsViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()
    
    lazy var navigationAboutController: UINavigationController = {
        let aboutViewController = AboutViewController.instantiateFrom(.about)
        aboutViewController.dataProvider = self.dataProvider
        aboutViewController.tabBarItem.title = "About"
        aboutViewController.tabBarItem.image = UIImage(named: "about")
        aboutViewController.title = "About"
        
        let navigationController = UINavigationController(rootViewController: aboutViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        return navigationController
    }()
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.barTintColor = .purple
        tabBar.tintColor = .white
        setViewControllers([navigationFiestasController,
                            navigationBeachesController,
                            navigationCamiDeCavallsController,
                            navigationAboutController], animated: false)
    }

}
