//
//  EventsCell.swift
//  Menorca
//
//  Created by Xavi Moll on 26/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class EventsCell: UITableViewCell {

    @IBOutlet private var startDate: UILabel!
    @IBOutlet var topVerticalLine: UIView!
    @IBOutlet var bottomVerticalLine: UIView!
    @IBOutlet private var eventTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    private func clearCell() {
        startDate.text = "08:00"
        topVerticalLine.isHidden = false
        bottomVerticalLine.isHidden = false
        eventTitle.text = "Primer toc de fabiol"
    }
    
    func configure(with event: Event) {
        
    }

}
