//
//  HomeViewController.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var locationManager : LocationManager {
        return LocationManager.shared
    }
    
    var temperatureObserver : NSObjectProtocol?
    var cityNameObserver : NSObjectProtocol?
    var imageNameObserver : NSObjectProtocol?
    lazy var homeViewModel : HomeViewModel? = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        observeViewModel()
        setupNavigationController()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestLocationAtOnce()
    }
    
    private func setupNavigationController() {
        self.title = "Weather Demo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(barButtonPressed))
    }
    
    private func observeViewModel() {
        homeViewModel?.view = self.view
        homeViewModel?.controller = self
        self.temperatureObserver = homeViewModel?.observe(\HomeViewModel.temperatureValue,options: [.initial, .new], changeHandler: { (_, change) in
            DispatchQueue.main.async {
                self.temperatureLabel.text = change.newValue ?? ""
            }
        })
        
        self.cityNameObserver = homeViewModel?.observe(\HomeViewModel.cityNameValue,options: [.initial, .new], changeHandler: { (_, change) in
            DispatchQueue.main.async {
                self.cityLabel.text = change.newValue ?? ""
            }
        })
        
        self.imageNameObserver = homeViewModel?.observe(\HomeViewModel.imageName,options: [.initial, .new], changeHandler: { (_, change) in
            DispatchQueue.main.async {
                self.weatherIcon.image = UIImage(named: change.newValue ?? "")
            }
        })
    }
    
    @objc func barButtonPressed() {
        homeViewModel?.barbuttonPressed()
    }
}

extension HomeViewController : LocationManagerDelegate {
    func getCurrentLocation(coordinate: CLLocationCoordinate2D) {
        let latitude = String(coordinate.latitude)
        let longitude = String(coordinate.longitude)
//        ActivityIndicator(self.view)
        homeViewModel?.fetchWeatherForLocation(latitude: latitude, longitude: longitude)
    }
}

//extension HomeViewController : CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location =  locations[locations.count - 1]
//        if location.horizontalAccuracy > 0 {
//            locationManager.stopUpdatingLocation()
//            print(location.coordinate.latitude)
//            getCurrentLocation(coordinate: location.coordinate)
//            let latitude = String(location.coordinate.latitude)
//            let longitude = String(location.coordinate.longitude)
//            let param : [String : String] = ["lat" : latitude,"lon" : longitude, "appid" : ""]
//        }
//    }
//}
