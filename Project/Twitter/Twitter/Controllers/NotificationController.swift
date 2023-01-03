//
//  NotificationController.swift
//  Twitter
//
//  Created by Long Bảo on 02/01/2023.
//

import UIKit

class NotificationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    func configureUI() {
        view.backgroundColor = .systemPink
        
        navigationItem.title = "Notifications"
        let appearanceNav = UINavigationBarAppearance()
        appearanceNav.backgroundColor = .white
   
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.compactAppearance = appearanceNav
        self.navigationController?.navigationBar.standardAppearance = appearanceNav
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearanceNav

    }

}
