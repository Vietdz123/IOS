//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    var category: Results<Category>?
    
    override func viewDidLoad() {

        category =  realm.objects(Category.self)
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1                 //Chống Dead App đoạn gán cell.textLabel?.text, nếu chưa gán thì chống daed app
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantName.CategoryNameReusableShell, for: indexPath)
        cell.textLabel?.text = category?[indexPath.row].name ?? "No category added yet"
        print("HÂHHA: \(String(describing: category?[indexPath.row].name))")
        return cell
    }

    @IBAction func AddCategory(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { Action in
            if textField.text != "" {
                let newCategory = Category()
                newCategory.name = textField.text!
                print("textFiled: \(newCategory.name)")
                self.save(category: newCategory)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
        }
        
        alert.addTextField { text in
            textField = text
        }
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK: - Save Category
    func save(category: Category) {
        do {
            try realm.write {
                print(">>>>>>>>> \(category.name)")
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deleteCategory(indexPath: indexPath)
        self.performSegue(withIdentifier: ConstantName.gotoItems, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category?[indexPath.row]
        }
    }
    
    func deleteCategory(indexPath: IndexPath) {
        if let categoryForDeletion = category?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryForDeletion)
                    tableView.reloadData()
                }
            } catch {
                print("Error saving category \(error)")
            }
        }
    }
    
}

