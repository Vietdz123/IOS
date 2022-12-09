//
//  WeatherManager.swift
//  Clima
//
//  Created by Long Bảo on 09/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
protocol weatherDelegate {
    func didUpdateWeather(weather: WeatherData)
}

struct WeatherManager {
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=aa2f48e0e86619adbad1117d58ffd103&units=metric"
    var delegate: weatherDelegate?
    
     func fetchWeatherCityName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeatherLonAndLat(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=lat&lon=lon"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create a URRL
        if let url = URL(string: urlString) {
        
            //2. Create a URL Session
        let session = URLSession(configuration: .default)
        //3.Give a session a task
            let task = session.dataTask(with: url, completionHandler: handle)
                //4. start task
            task.resume()
        }
        
        func handle(data: Data?, response: URLResponse?, error: Error?) {
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                if let encodeWeather = parseJson(weatherData: safeData) {
                    delegate?.didUpdateWeather(weather: encodeWeather)
                }
            }
        }
        
        func parseJson(weatherData: Data) -> WeatherData? {
            let decoder = JSONDecoder()
            do {
               let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
                return decodeData
                
            } catch {
                print("****errror")
                print(error)
                return nil
            }
        }
        
    }
}

