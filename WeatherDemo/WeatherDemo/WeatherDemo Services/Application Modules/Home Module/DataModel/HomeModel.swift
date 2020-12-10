//
//  HomeModel.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

struct CoordinateModel : Codable {
    let lon : Double?
    let lat : Double?
}
struct WindModel : Codable {
    let speed : Double?
    let deg : Int?
}
struct CloudModel : Codable {
    let all : Int?
}

struct SystemModel : Codable {
    let type : Int?
    let id : Int?
    let country : String?
    let sunrise : Int?
    let sunset : Int?
}

struct WeatherResult : Codable {
    let coordinate : CoordinateModel?
    let weather : [Weather]?
    let climateModel : ClimateModel?
    let visibility : Int?
    let dateStamp : Int?
    let cityName : String?
    let timezone: Int?
    let cod : Int?
    let wind : WindModel?
    let clouds : CloudModel?
    let sys : SystemModel?
    
    enum CodingKeys : String, CodingKey {
        case timezone, visibility, weather, cod, wind, clouds, sys
        case cityName = "name"
        case dateStamp = "dt"
        case climateModel = "main"
        case coordinate = "coord"
    }
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct ClimateModel : Codable {
    let temp : Double?
    let feelLikeTemp : Double?
    let tempMax : Double?
    let tempMin : Double?
    let pressure : Int?
    let humidity : Int?
    
    enum CodingKeys : String, CodingKey {
        case temp, pressure, humidity
        case feelLikeTemp = "feels_like"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}
