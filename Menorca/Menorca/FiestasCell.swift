//
//  FiestasCell.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class FiestasCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private var fiestaBackgroundImage: UIImageView!
    @IBOutlet private var fiestaName: UILabel!
    @IBOutlet private var fiestaLocation: UILabel!
    @IBOutlet private var fiestaDates: UILabel!
    
    //MARK: Class properties
    lazy var dateIntervalFormatter: DateIntervalFormatter = {
        let dateIntervalFormatter = DateIntervalFormatter()
        dateIntervalFormatter.dateTemplate = "dd MMMM"
        dateIntervalFormatter.calendar = Calendar.current
        dateIntervalFormatter.locale = Locale.current
        dateIntervalFormatter.timeZone = TimeZone.current
        return dateIntervalFormatter
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
        fiestaBackgroundImage.image = nil
        fiestaName.text = nil
        fiestaLocation.text = nil
        fiestaDates.text = nil
    }
    
    func configure(with fiesta: Fiesta) {
        fiestaBackgroundImage.sd_setImage(with: fiesta.headerImage)
        fiestaName.text = fiesta.name
        fiestaLocation.text = fiesta.location
        fiestaDates.text = dateIntervalFormatter.string(from: fiesta.startDate, to: fiesta.endDate)
    }
    
}
