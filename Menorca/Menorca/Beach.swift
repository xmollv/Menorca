//
//  Beach.swift
//  Menorca
//
//  Created by Xavi Moll on 23/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation
import CoreLocation

struct Beach: Codable {
    let name: String
    let belongsTo: String
    let latitude: Double
    let longitude: Double
    let location: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case belongsTo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        belongsTo = try container.decode(String.self, forKey: .belongsTo)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(belongsTo, forKey: .belongsTo)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
