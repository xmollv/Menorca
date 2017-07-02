//
//  EventsCell.swift
//  Menorca
//
//  Created by Xavi Moll on 26/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class EventsCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private var startDate: UILabel!
    @IBOutlet var topVerticalLine: UIView!
    @IBOutlet var bottomVerticalLine: UIView!
    @IBOutlet private var eventTitle: UILabel!
    
    //MARK: Class properties
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
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
        startDate.text = nil
        topVerticalLine.isHidden = false
        bottomVerticalLine.isHidden = false
        eventTitle.text = nil
    }
    
    func configure(with event: Event) {
        startDate.text = dateFormatter.string(from: event.startDate)
        eventTitle.text = event.title
    }

}
