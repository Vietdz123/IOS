//
//  ResultBMIController.swift
//  BMI Calculator
//
//  Created by Long Bảo on 08/12/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultBMIController: UIViewController {
    var BMIvalue:String = "0.0"
    @IBOutlet weak var KqLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KqLabel.text = BMIvalue
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameBackMainScreen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
