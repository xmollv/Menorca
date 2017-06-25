//
//  FiestasViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class FiestasViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        DataProvider.shared.requestMultiple(HTTPMethod.get, Endpoint.fiestas) { (result: Result<[Fiesta]>) in
            switch result {
            case .isSuccess(let fiestas):
                dump(fiestas)
            case .isFailure(let error):
                dump(error)
            }
        }
        
    }

}

extension FiestasViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "FiestasCell", for: indexPath)
    }
}

extension FiestasViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped: \(indexPath.row)")
        let timelineViewController = TimelineViewController.instantiateFrom(.timeline)
        navigationController?.pushViewController(timelineViewController, animated: true)
    }
}

extension FiestasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
