//
//  ViewController.swift
//  First App
//
//  Created by Long Bảo on 29/11/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sucSac1: UIImageView!
    @IBOutlet weak var sucSac2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func clickButtonFuckoff(_ sender: Any) {
        let arr_image = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive") , #imageLiteral(resourceName: "DiceSix")]
        sucSac1.image = arr_image.randomElement();
        sucSac2.image = arr_image.randomElement();
            
    }
    
}

