//
//  Schedule.swift
//  Menorca
//
//  Created by Xavi Moll on 02/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    
    let day: Date
    let events: [Event]
    
}
