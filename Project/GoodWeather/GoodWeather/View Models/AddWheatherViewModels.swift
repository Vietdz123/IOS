//
//  AddWheatherViewModels.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import Foundation

protocol AddWeatherDelegate {
    func didSaveWeather(weather: WeatherViewModel)
}

class AddWeatherViewModel {
    var delegate: AddWeatherDelegate?
    
    func addWeather(city: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=aa2f48e0e86619adbad1117d58ffd103&q=\(city)&units=metric") else {
            fatalError("URL Wrong >>>>>>>>>>>>>>>>>")
        }
        let resource = Resource<WeatherResponce>(url: url) { data in
            let dataDecoded = try? JSONDecoder().decode(WeatherResponce.self, from: data)
            print(dataDecoded!)
            return dataDecoded
        }
        Webservice().load(resource: resource) { data in
            if let data = data {
                let weather = WeatherViewModel(weather: data)
                self.delegate?.didSaveWeather(weather: weather)
            }
            
        }
    }
}
