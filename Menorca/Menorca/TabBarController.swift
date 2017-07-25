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
        fiestasViewController.tabBarItem.image = #imageLiteral(resourceName: "horse")
        fiestasViewController.title = "Fiestas"
        
        let navigationController = UINavigationController(rootViewController: fiestasViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        return navigationController
    }()
    
    lazy var navigationBeachesController: UINavigationController = {
        let beachesViewController = BeachesViewController.instantiateFrom(.beaches)
        beachesViewController.dataProvider = self.dataProvider
        beachesViewController.tabBarItem.title = "Beaches"
        beachesViewController.tabBarItem.image = #imageLiteral(resourceName: "beach")
        beachesViewController.title = "Beaches"
        
        let navigationController = UINavigationController(rootViewController: beachesViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        return navigationController
    }()
    
    lazy var navigationCamiDeCavallsController: UINavigationController = {
        let camiDeCavallsViewController = CamiDeCavallsViewController.instantiateFrom(.camiDeCavalls)
        camiDeCavallsViewController.dataProvider = self.dataProvider
        camiDeCavallsViewController.tabBarItem.title = "Camí de Cavalls"
        camiDeCavallsViewController.tabBarItem.image = #imageLiteral(resourceName: "trek")
        camiDeCavallsViewController.title = "Camí de Cavalls"
        
        let navigationController = UINavigationController(rootViewController: camiDeCavallsViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        return navigationController
    }()
    
    lazy var navigationAboutController: UINavigationController = {
        let aboutViewController = AboutViewController.instantiateFrom(.about)
        aboutViewController.dataProvider = self.dataProvider
        aboutViewController.tabBarItem.title = "About"
        aboutViewController.tabBarItem.image = #imageLiteral(resourceName: "about")
        aboutViewController.title = "About"
        
        let navigationController = UINavigationController(rootViewController: aboutViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .purple
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        return navigationController
    }()
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .purple
        self.tabBar.tintColor = .white
        self.setViewControllers([navigationFiestasController,
                            navigationBeachesController,
                            navigationCamiDeCavallsController,
                            navigationAboutController], animated: false)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let viewToBetransformed: UIView
        
        if viewController == navigationFiestasController {
            viewToBetransformed = self.tabBar.subviews[1]
        } else if viewController == navigationBeachesController {
            viewToBetransformed = self.tabBar.subviews[2]
        } else if viewController == navigationCamiDeCavallsController {
            viewToBetransformed = self.tabBar.subviews[3]
        } else if viewController == navigationAboutController {
            viewToBetransformed = self.tabBar.subviews[4]
        } else {
            return
        }
        
        viewToBetransformed.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 10,
                       options: [],
                       animations: {
                        viewToBetransformed.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: nil)

    }
}
