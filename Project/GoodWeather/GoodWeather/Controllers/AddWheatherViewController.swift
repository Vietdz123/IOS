//
//  AddWheatherViewController.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import UIKit

class AddWheatherViewController: UIViewController {
    var addWWeather = AddWeatherViewModel()
    
    @IBOutlet weak var cityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveCityButton(_ sender: UIButton) {
        if let city = cityTextField.text {
            addWWeather.addWeather(city: city)
            dismiss(animated: true)
        }

    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
