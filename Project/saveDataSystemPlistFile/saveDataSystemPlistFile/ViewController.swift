//
//  ViewController.swift
//  saveDataSystemPlistFile
//
//  Created by Long Bảo on 13/12/2022.
//

import UIKit

struct People: Codable {
    var name = ""
    var age = 0
}

class ViewController: UIViewController {

    let valuePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = valuePath?.appendingPathComponent("hello.plist")
        var decode = PropertyListDecoder()
        let data = try! Data(contentsOf: filePath!)
        var dataPeople = try! decode.decode([People].self, from: data)
        print("Data is: \(dataPeople)")

    }
    
    

}

