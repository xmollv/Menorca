//
//  Fiesta.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

struct Fiesta: JSONInitiable {
    
    let id: Int
    let name: String
    let location: String
    let startDate: String
    let endDate: String
    let headerImage: String
    
    init?(dict: JSONDictionary) {
        
        guard let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let location = dict["location"] as? String,
            let startDate = dict["startDate"] as? String,
            let endDate = dict["endDate"] as? String,
            let headerImage = dict["headerImage"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.headerImage = headerImage
    }
}
