//
//  WeatherData.swift
//  Clima
//
//  Created by Long Bảo on 09/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Decodable {
    var name: String
    var weather: [weather]
    var main: main
}

struct weather: Decodable {
    var description: String
    var id: Int
    var main: String
    var icon: String
}

struct main: Decodable {
    var temp: Double
}
