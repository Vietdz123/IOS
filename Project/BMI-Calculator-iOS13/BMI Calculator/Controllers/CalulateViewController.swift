//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalulateViewController: UIViewController {
    var kqBMI:Float = 0.0
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var valueHeightLabel: UILabel!
    @IBOutlet weak var valueWeightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeHeightSlider(_ sender: UISlider) {
        let valueHeight = String(format: "%@%.2f%@", "value: ",sender.value, "m")
        valueHeightLabel.text = valueHeight
    }
    
    
    @IBAction func changeWeightSlider(_ sender: UISlider) {
        let valueHeight = String(format: "%@%.2f%@", "value: ",sender.value, "m")
        valueWeightLabel.text = valueHeight
    }
    @IBAction func calculateValueBMI(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        kqBMI = weight / pow(height, 2)
        
        self.performSegue(withIdentifier: "gotoResult", sender: self)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "gotoResult" {
            let destinationVC = segue.destination as! ResultBMIController
            destinationVC.BMIvalue = String(format: "%.1f", kqBMI)
        }
    }
    
}

