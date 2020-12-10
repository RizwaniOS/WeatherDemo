//
//  NetworkServices.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    let apiKey = "ac1afa5a08f1d74b277b7b24b57f7e5e"
    let baseURL = "https://api.openweathermap.org/data/2.5"
    
    let session = URLSession(configuration: .default)
    
    func buildLocationURL(lat:String,long:String) -> String {
        let pathUrl = "/weather?lat=\(lat)" + "&lon=\(long)" + "&appid=\(apiKey)"
        return baseURL + pathUrl
    }
    
    func getWeather<T: Decodable>(lat:String, long:String ,onSuccess: @escaping (T) -> (), onError: @escaping (String) -> Void) {
        guard NetworkConnectivityManager.isConnectedToNetwork() else {
            onError("Please connect, Internet is offline")
            return
        }
        guard let url = URL(string: buildLocationURL(lat: lat, long: long)) else {
            onError("Error building URL")
            return
        }
        let task = session.dataTask(with: url) { (result) in
            switch result {
            case .success(let data):
                let str = String(decoding: data, as: UTF8.self)
                print(str)
                do {
                    let resultantResponse = try JSONDecoder().decode(T.self, from: data)
                    onSuccess(resultantResponse)
                } catch {
                    onError(error.localizedDescription)
                }
                break
            case .failure(let error):
                onError(error.localizedDescription)
                break
            }
        }
        task.resume()
    }
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(Data), Error>) -> Void) -> URLSessionDataTask {
    return dataTask(with: url) { (data, response, error) in
        if let error = error {
            result(.failure(error))
            return
        }
        guard let data = data else {
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            result(.failure(error))
            return
        }
        result(.success((data)))
    }
}
}
