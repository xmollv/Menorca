//
//  Fiesta.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

struct Fiesta: Codable {
    
    let id: Int
    let name: String
    let location: String
    let startDate: Date
    let endDate: Date
    let headerImage: URL
    let schedules: [Schedule]

}
