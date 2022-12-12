//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = ""
        makeAnimatedTitleFlashChap()
        navigationItem.title = ConstantNameFlashChat.titleFlashChat
        
    }
    
    func makeAnimatedTitleFlashChap() {
        let title = ConstantNameFlashChat.titleFlashChat
        var timeDelay = 0.1
        for c in title {
            Timer.scheduledTimer(withTimeInterval: timeDelay, repeats: false) { timer in
                self.titleLabel.text?.append(c)
            }
            timeDelay = timeDelay + 0.1
        }
    }
    
    

}
