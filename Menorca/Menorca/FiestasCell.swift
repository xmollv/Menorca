//
//  FiestasCell.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class FiestasCell: UICollectionViewCell {
    
    @IBOutlet private var fiestaBackgroundImage: UIImageView!
    @IBOutlet private var fiestaName: UILabel!
    @IBOutlet private var fiestaLocation: UILabel!
    @IBOutlet private var fiestaDates: UILabel!
    
    lazy var dateFormatterFromServer: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter
    }()
    
    lazy var dateIntervalFormatter: DateIntervalFormatter = {
        let dateIntervalFormatter = DateIntervalFormatter()
        dateIntervalFormatter.dateTemplate = "dd MMMM"
        dateIntervalFormatter.calendar = Calendar.current
        dateIntervalFormatter.locale = Locale.current
        dateIntervalFormatter.timeZone = TimeZone.current
        return dateIntervalFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    private func clearCell() {
        fiestaBackgroundImage.image = nil
        fiestaName.text = nil
        fiestaLocation.text = nil
        fiestaDates.text = nil
    }
    
    func configure(with fiesta: Fiesta) {
        fiestaBackgroundImage.image = UIImage(named: "SantJoan")
        fiestaName.text = fiesta.name
        fiestaLocation.text = fiesta.location
        
        guard let startDate = dateFormatterFromServer.date(from: fiesta.startDate),
            let endDate = dateFormatterFromServer.date(from: fiesta.endDate) else { return }
        
        let interval = dateIntervalFormatter.string(from: startDate, to: endDate)
        fiestaDates.text = interval
    }
    
}
