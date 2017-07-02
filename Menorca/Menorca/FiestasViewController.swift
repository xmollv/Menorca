//
//  FiestasViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 24/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class FiestasViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private var collectionView: UICollectionView!
    
    //MARK: Class properties
    var dataProvider: DataProvider!
    var fiestas: [Fiesta]?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .purple
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
        dataProvider.request(.fiestas) { [weak weakSelf = self] (result: Result<[Fiesta]>) in
            guard let weakSelf = weakSelf else { return }
            switch result {
            case .isSuccess(let fiestas):
                weakSelf.fiestas = fiestas
                weakSelf.collectionView.reloadData()
            case .isFailure(let error):
                dump(error)
            }
            weakSelf.refreshControl.endRefreshing()
        }
    }
}

//MARK: UICollectionViewDataSource
extension FiestasViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfFiestas = fiestas?.count else {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            activityIndicator.color = .purple
            collectionView.backgroundView = activityIndicator
            return 0
        }
        
        collectionView.backgroundView = nil
        return numberOfFiestas
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fiestas = fiestas else { return UICollectionViewCell() }
        let fiesta = fiestas[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiestasCell", for: indexPath) as! FiestasCell
        cell.configure(with: fiesta)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension FiestasViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let timelineViewController = EventsViewController.instantiateFrom(.events)
        timelineViewController.dataProvider = dataProvider
        timelineViewController.schedules = fiestas?[indexPath.row].schedules
        navigationController?.pushViewController(timelineViewController, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension FiestasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
