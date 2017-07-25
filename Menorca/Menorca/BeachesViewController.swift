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
        collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
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
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("The layout for the collection view was not a UICollectionViewFlowLayout")
        }
        
        // The number of cells changes based on the device orientation
        var cellsForRow: CGFloat = 1.0
        if collectionView.bounds.size.width > collectionView.bounds.size.height {
            cellsForRow = 2.0
        }
        
        let cellSpacing = flowLayout.minimumInteritemSpacing
        let collectionViewInsetsWidth = collectionView.contentInset.left + collectionView.contentInset.right
        
        let collectionViewWidthMinusInsets = collectionView.bounds.size.width - collectionViewInsetsWidth
        let collectionViewWidthMinusCellSpacing = collectionViewWidthMinusInsets - (cellSpacing * (cellsForRow - 1))
        let widthCell = collectionViewWidthMinusCellSpacing / cellsForRow
        
        let sizeToReturn = CGSize(width: widthCell, height: 150)
        return sizeToReturn
    }
}
