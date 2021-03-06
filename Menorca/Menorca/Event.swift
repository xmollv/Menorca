//
//  Event.swift
//  Menorca
//
//  Created by Xavi Moll on 26/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

struct Event: Codable {
    let startDate: Date
    let title: String
}

extension Event : Equatable {
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.startDate == rhs.startDate
    }
}
