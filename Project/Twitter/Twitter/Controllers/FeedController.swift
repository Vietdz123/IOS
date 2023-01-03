//
//  FeedController.swift
//  Twitter
//
//  Created by Long Bảo on 02/01/2023.
//

import UIKit

class FeedController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    func configureUI() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "New Feeds"
        let appearanceNav = UINavigationBarAppearance()
        appearanceNav.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
   
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.compactAppearance = appearanceNav
        self.navigationController?.navigationBar.standardAppearance = appearanceNav
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearanceNav
            
        
        let appearTabBar = UITabBarAppearance()
        appearTabBar.backgroundColor = .white
        tabBarController?.tabBar.standardAppearance = appearTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = appearTabBar
        
        
    }

}
