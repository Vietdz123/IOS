//
//  KqQBmiController.swift
//  BMI Calculator
//
//  Created by Long Bảo on 08/12/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//
import UIKit

class KqBmiController: UIViewController {
    var kqBMI: String = "0.0"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        //view.backgroundColor = .blue      cach 2
         let label: UILabel = UILabel()
        label.text = kqBMI
        label.numberOfLines = 0
        
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.addSubview(label)  //labeL: UIlabel ke thua UIView, view: UIView, kieu bien truyen vao la UIview, ma class con cung la class cha, nen dc chap nhan
    }

}
