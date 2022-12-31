//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit


class ItemTableViewController: UITableViewController {
    let realm = try! Realm()
    var item: Results<Item>?
    
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedCategory: Category? {
        didSet {
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.rowHeight = 82.0
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("item?.count \(item?.count)")
        return item?.count ?? 1                 //Chống Dead App đoạn gán cell.textLabel?.text, nếu chưa gán thì chống daed app
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("KAKAKA \(item?[indexPath.row].name ?? "No category added yet")")
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantName.iTemNameReusableShell, for: indexPath)  as! SwipeTableViewCell
        cell.textLabel?.text = item?[indexPath.row].name ?? "No category added yet"
        cell.delegate = self
        
        return cell
    }
    
    @IBAction func AddCategory(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { Action in
            if textField.text != "" {
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.name = textField.text!
                            currentCategory.item.append(newItem)
                        }
                    } catch {
                        print("Error saving new items, \(error)")
                    }
                }
            }
            self.tableView.reloadData()
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
        }
        
        alert.addTextField { text in
            text.placeholder = "Add items"
            textField = text
        }
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK: - Save Category
    func save(item: Item) {
        do {
            try realm.write {
                realm.add(item)
                tableView.reloadData()
            }
        } catch {
            print("Error saving category \(error)")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deleteCategory(indexPath: indexPath)
        //self.performSegue(withIdentifier: ConstantName.gotoItems, sender: self)
    }
    

    
    func deleteCategory(indexPath: IndexPath) {
        if let itemDeletion = item?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(itemDeletion)
                    //tableView.reloadData()
                    print("RELOAD")
                }
            } catch {
                print("Error saving category \(error)")
            }
            tableView.reloadData()
        }
    }
    
    func loadItem() {
        item = selectedCategory?.item.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
    
}

extension ItemTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        item = item?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        print("GOTO SEARCH")
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            item = item?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
            self.tableView.reloadData()
        }
    }
}

extension ItemTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        print("DELETE0 >>>>>>>>>>>>>>>>")
        guard orientation == .right else { return nil }
        print("DELETE1 >>>>>>>>>>>>>>>>")
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteCategory(indexPath: indexPath)
            self.tableView.reloadData()
            print("DELETE2 >>>>>>>>>>>>>>>>")
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "Delete-icon")

        return [deleteAction]
    }
  
    
    //MARK: - FUNC này failed khi nhét vào app, đel hiểu
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        print("CACCCCCCCCCC")
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        //self.tableView.reloadData()
        return options
    }
}
