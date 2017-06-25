//
//  FiestasCell.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class FiestasCell: UICollectionViewCell {
    
    @IBOutlet private var fiestaName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    private func clearCell() {
        fiestaName.text = nil
    }
    
    func configure(with fiesta: Fiesta) {
        fiestaName.text = fiesta.name
    }
    
}
