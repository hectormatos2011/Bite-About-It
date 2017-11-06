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
    var currentCoordinate = CLLocationCoordinate2D()
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
        BusinessSearchOperation(coordinate: currentCoordinate).start { result in
            guard case .success(let businesses) = result else { return }
            print(businesses)
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
        currentCoordinate = locations.last?.coordinate ?? currentCoordinate
        startBusinessFetch(with: currentCoordinate)
        manager.stopUpdatingLocation()
    }
}
