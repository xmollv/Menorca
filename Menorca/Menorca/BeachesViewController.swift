//
//  BeachesViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 22/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class BeachesViewController: UIViewController {

    //MARK: Class properties
    var dataProvider: DataProvider!
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.request(.beaches) { (result: Result<[Beach]>) in
            dump(result)
        }
    }

}
