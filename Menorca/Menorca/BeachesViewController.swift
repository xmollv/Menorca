//
//  BeachesViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 22/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class BeachesViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: Class properties
    var dataProvider: DataProvider!
    var beaches: [Beach]?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.fetchData), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        fetchData()
    }
    
    //MARK: Class methods
    @objc private func fetchData() {
        dataProvider.request(.beaches) { [weak weakSelf = self] (result: Result<[Beach]>) in
            guard let weakSelf = weakSelf else { return }
            switch result {
            case .isSuccess(let beaches):
                weakSelf.beaches = beaches
                weakSelf.collectionView.reloadData()
            case .isFailure(let error):
                dump(error)
            }
            weakSelf.refreshControl.endRefreshing()
        }
    }
}

//MARK: UICollectionViewDataSource
extension BeachesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfBeaches = beaches?.count else {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            collectionView.backgroundView = activityIndicator
            return 0
        }
        
        collectionView.backgroundView = nil
        return numberOfBeaches
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let beaches = beaches else { return UICollectionViewCell() }
        let beach = beaches[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeachCell", for: indexPath) as! BeachCell
        cell.configure(with: beach)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension BeachesViewController: UICollectionViewDelegate {
}

//MARK: UICollectionViewDelegateFlowLayout
extension BeachesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
