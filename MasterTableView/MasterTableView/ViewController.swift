//
//  ViewController.swift
//  MasterTableView
//
//  Created by Bao Long on 24/12/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var arrName = ["Viet", "Linh", "Huy", "Tuan"]
    let cellSpacingHeight: CGFloat = 30
    var element = ["cat", "bird", "cow", "dog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = UIColor.clear
        myTableView.register(UINib(nibName: "ReusableViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CellXib")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName.count
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellXib") as! ReusableViewCellTableViewCell
        cell.animalsLbl.text = element[indexPath.row]
        cell.avatarImg.image = UIImage(named: element[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section " + String(section)
    }
	
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//      if let headerView = view as? UITableViewHeaderFooterView {
//          headerView.contentView.backgroundColor = .red
//          headerView.backgroundView?.backgroundColor = .purple
//          headerView.textLabel?.textColor = .black
//      }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }
    
    
    
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


