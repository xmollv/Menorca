//
//  TabBarController.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var fiestasViewController: FiestasViewController = {
        let fiestasViewController = FiestasViewController.instantiateFrom(.fiestas)
        fiestasViewController.tabBarItem.title = "Fiestas"
        return fiestasViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([fiestasViewController], animated: true)
    }

}
