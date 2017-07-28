//
//  BeachCell.swift
//  Menorca
//
//  Created by Xavi Moll on 23/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class BeachCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private var beachName: UILabel!
    @IBOutlet private var beachDistance: UILabel!
    
    //MARK: Class properties
    lazy var distanceFormatter: MKDistanceFormatter = {
        let distanceFormatter = MKDistanceFormatter()
        distanceFormatter.unitStyle = .default
        return distanceFormatter
    }()
    
    //MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    //MARK: Class methods
    private func clearCell() {
        beachName.text = nil
        beachDistance.text = nil
    }
    
    func configure(with beach: Beach, currentLocation: CLLocation?) {
        beachName.text = beach.name
        beachDistance.text = distanceBetween(beach.location, and: currentLocation)
    }
    
    private func distanceBetween(_ beachLocation: CLLocation, and userLocation: CLLocation?) -> String? {
        guard let userLocation = userLocation else { return nil }
        let distanceInMeters = beachLocation.distance(from: userLocation)
        let prettyString = distanceFormatter.string(fromDistance: distanceInMeters)
        return prettyString
    }
    
}
