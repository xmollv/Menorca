//
//  UIViewController Extensions.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard: String {
    case tabBar
    case fiestas
    case events
    case beaches
    case about
}

extension UIViewController {
    
    class func instantiateFrom(_ storyboard: Storyboard) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboard.rawValue.capitalized)
    }
    
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type.self)) as! T
    }
}
