//
//  LocationManager.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func getCurrentLocation(coordinate: CLLocationCoordinate2D)

}
class LocationManager: NSObject {
    private let locationManager: CLLocationManager = CLLocationManager()

    var currentLocation = CLLocation()
    static let shared = LocationManager()
    var delegate: LocationManagerDelegate?
    func requestLocationAtOnce() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func getPermission() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        default:
            return false
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            guard let currentLocation = locations.first?.coordinate else { return }
            delegate?.getCurrentLocation(coordinate: currentLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.requestLocation()
    }
}
