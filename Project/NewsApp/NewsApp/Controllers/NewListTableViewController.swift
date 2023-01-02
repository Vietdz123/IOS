//
//  NewListTableViewController.swift
//  NewsApp
//
//  Created by Bao Long on 27/12/2022.
//

import UIKit

class NewListTableViewController: UITableViewController {
    
    var articleList: ArticleListViewModel?   //!!!!!!! HAY ????????????????
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    
    func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1)
        
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        print("??CDE")
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-11-27&sortBy=publishedAt&apiKey=c18a14443e06455db637af1c376af045") else { print("URL FAILED")
            return
        }
        Service().getArtical(url: url) { articles in
            if let articles = articles {
                self.articleList = ArticleListViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(">>>>>>>>ABC")
        return articleList == nil ? 0 : articleList!.numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList!.numbeOfRowInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
        cell.titleLabel.text = articleList?.articleAtIndex(at: indexPath.row).title
        cell.descriptionLabel.text = articleList?.articleAtIndex(at: indexPath.row).description
        return cell
    }
}
