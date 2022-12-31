//
//  \TableViewController.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import UIKit

class WheatherListTableViewController: UITableViewController, AddWeatherDelegate {
    var weatherList = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func didSaveWeather(weather: WeatherViewModel) {
        for wt in weatherList.weatherList {
            if wt.weather.name == weather.weather.name {
                return
            }
        }
        weatherList.addWeather(weather: weather)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherList.numberOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWeather") as! WeatherCellTableViewCell
        cell.temperatureLabel.text = String(weatherList.weatherAtIndex(at: indexPath.row).weather.main.temp)
        cell.cityLabel.text = weatherList.weatherAtIndex(at: indexPath.row).weather.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoNavigationAddWWeatherViewController" {
            if let navc = segue.destination as? UINavigationController, let addVC = navc.viewControllers.first as? AddWheatherViewController {
                addVC.addWWeather.delegate = self
                dismiss(animated: true)
            }
        }
    }
    
}
