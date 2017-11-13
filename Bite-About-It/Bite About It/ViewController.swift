//
//  ViewController.swift
//  Bite About It
//
//  Created by Hector Matos on 8/2/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import UIKit
import CoreLocation

/**
 This class is dedicated to the badass EdLopez83. Thanks for the sub!!!
 */
class ViewController: UIViewController {
    @IBOutlet weak var restaurantLabel: UILabel!
    let locationManager = CLLocationManager()
    var buttonWasTapped = false

    override final func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 6009.69;
    }

    // This is a function that fetches restaurants closest to you when you press the "Let's Try Something New" Button
    @IBAction func didTapFetchRestaurantButton() {
        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {
            buttonWasTapped = true
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if let location = locationManager.location {
            startBusinessFetch(with: location.coordinate)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func startBusinessFetch(with location: CLLocationCoordinate2D) {
        BusinessSearchOperation(coordinate: location).start { result in
            guard case .success(let businesses) = result, !businesses.isEmpty else { return }
            var highestRated: [Business] = []
            for (index, business) in businesses.enumerated() {
                guard index < 25 else { break }
                highestRated.append(business)
            }
            let randomIndex = Int(arc4random_uniform(UInt32(highestRated.count)))
            let chosenBusiness = highestRated[randomIndex]
            DispatchQueue.main.async {
                self.restaurantLabel.text = chosenBusiness.name
            }
        }
    }
}

// MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse && buttonWasTapped else { return }
        didTapFetchRestaurantButton()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        startBusinessFetch(with: locations.last?.coordinate ?? CLLocationCoordinate2D())
        manager.stopUpdatingLocation()
    }
}
