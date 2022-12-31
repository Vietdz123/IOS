//
//  WeatherResponce.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import Foundation

struct WeatherResponce: Decodable {
    var main: Weather
    var name: String
}

struct Weather: Decodable {
    var temp: Double
    var humidity: Double
}
