//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weather = WeatherManager()
    var location = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weather.delegate = self
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        //print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    

}


//MARK-Viet:  - WeatherViewController delegate UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text! != "" {
            weather.fetchWeatherCityName(cityName: searchTextField.text!)
            return true
        } else {
            searchTextField.placeholder = "please enter something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchTextField.text = ""
    }
}

//MARK-Viet: - viet


extension WeatherViewController: weatherDelegate {
        func didUpdateWeather(weather: WeatherData) {
            DispatchQueue.main.async {
            self.temperatureLabel.text = String(format: "%.2f", weather.main.temp)
                self.cityLabel.text = weather.name
        }
        
        
    }
}

//MARK-Viet: - delegate CCLLocation
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("\(lat) and \(lon)")
            weather.fetchWeatherLonAndLat(lat: lat, lon: lon)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("hello error******")
        print(error)
    }
}

