//
//  BeachesViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 22/07/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit
import CoreLocation

class BeachesViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: Class properties
    var dataProvider: DataProvider!
    var beaches: [Beach]?
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation? = nil {
        didSet {
            guard let currentLocation = currentLocation, let _ = beaches else { return }
            beaches?.sort(by: { (beach1, beach2) -> Bool in
                let beach1Distance = currentLocation.distance(from: beach1.location)
                let beach2Distance = currentLocation.distance(from: beach2.location)
                return beach1Distance < beach2Distance
            })
            collectionView.reloadData()
        }
    }
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.startUpdatingLocation()
        }
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
            case .isFailure(let error):
                dump(error)
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension BeachesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfBeaches = beaches?.count else { return 0 }
        collectionView.backgroundView = nil
        return numberOfBeaches
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let beaches = beaches else { return UICollectionViewCell() }
        let beach = beaches[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeachCell", for: indexPath) as! BeachCell
        cell.configure(with: beach, currentLocation: currentLocation)
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

extension BeachesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            //FIXME: Change this to something more friendly with a button to settings
            beaches = nil
            collectionView.reloadData()
            createErrorMessageOnCollectionView(nil)
        case .authorizedAlways, .authorizedWhenInUse:
            fetchData()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = locations.last {
            currentLocation = latestLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //FIXME: Change this to something more friendly with a button to settings
        createErrorMessageOnCollectionView(error)
    }
    
    private func createErrorMessageOnCollectionView(_ error: Error?) {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = error?.localizedDescription
        collectionView.backgroundView = label
    }
}
