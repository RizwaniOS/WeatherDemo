//
//  HomeViewModel.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class HomeViewModel : NSObject {
    
    @objc dynamic var temperatureValue : String = ""
    @objc dynamic var cityNameValue : String = ""
    
    var currentTemperature:Double?
    var isCelsius = true
    var view: UIView?
    var controller: HomeViewController?
    
    override init() {
        
    }
    
    deinit {
        print("HomeViewModel deinit")
    }
    
    public func viewDidLoad() {
        
    }
    
    func fetchWeatherForLocation(latitude:String, longitude:String) {
        ActivityIndicator(view!)
        NetworkService.shared.getWeather(lat: latitude, long: longitude, onSuccess: { (response : WeatherResult) in
            DispatchQueue.main.async {
                ActivityIndicator(self.view!, startAnimate: false)
            }
            guard let temp = response.climateModel?.temp else { return }
            guard let cityName = response.cityName else { return }
            let tempValue = temp - 273.15
            self.temperatureValue = "\(String(format: "%0.2f", tempValue))°"
            self.currentTemperature = tempValue
            self.cityNameValue = cityName
        }) { (error) in
            DispatchQueue.main.async {
                ActivityIndicator(self.view!, startAnimate: false)
            }
            print(error)
        }
    }
    
    func barbuttonPressed() {
        let alert = UIAlertController(title: "Weather Data", message: "Choose action to be done", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let getListAction = UIAlertAction(title: "Get 10 days Temperature List", style: .default) { (action) in
            print(self.temperatureValue)
        }
        let convertAction = UIAlertAction(title: "Convert Celsius <-> Fahrenheit", style: .default) { (action) in
            guard let currentTemp = self.currentTemperature else {
                return
            }
            if self.isCelsius {
                self.temperatureValue = "\(String(format: "%0.2f", currentTemp.getCelsiusToFahrenheit()))°"
                self.currentTemperature = currentTemp.getCelsiusToFahrenheit()
                self.isCelsius = false
            } else {
                self.temperatureValue = "\(String(format: "%0.2f", currentTemp.getFahrenheitToCelsius()))°"
                self.currentTemperature = currentTemp.getFahrenheitToCelsius()
                self.isCelsius = true
            }
        }
        alert.addAction(getListAction)
        alert.addAction(convertAction)
        alert.addAction(cancelAction)
        controller?.present(alert, animated: true, completion: nil)
    }
}
