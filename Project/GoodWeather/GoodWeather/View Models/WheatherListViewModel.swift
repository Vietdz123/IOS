//
//  WheatherListViewModel.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import Foundation

struct WeatherListViewModel {
    var weatherList = [WeatherViewModel]()
    
    var numberOfRow: Int {
        weatherList.count
    }
    
    func weatherAtIndex(at Index: Int) -> WeatherViewModel {
        return weatherList[Index]
    }
    
    mutating func addWeather(weather: WeatherViewModel) {
        weatherList.append(weather)
    }
}

struct WeatherViewModel {
    var weather: WeatherResponce
    
    init(weather: WeatherResponce) {
        self.weather = weather
    }
}
