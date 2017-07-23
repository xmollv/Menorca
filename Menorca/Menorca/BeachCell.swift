//
//  BeachCell.swift
//  Menorca
//
//  Created by Xavi Moll on 23/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation
import UIKit

class BeachCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private var beachName: UILabel!
    
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
    }
    
    func configure(with beach: Beach) {
        beachName.text = beach.name
    }
    
}
