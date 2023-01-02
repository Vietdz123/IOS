//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Long Bảo on 18/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArr = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - Press Button Add
    @IBAction func ButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        var alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        
        var action = UIAlertAction(title: "Add New Category", style: .default) { (action) in
            if textField.text! != "" {
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categoryArr.append((newCategory))
                self.tableView.reloadData()
                self.saveContext()
            }
        }
        
        alert.addTextField { UITextField in
            UITextField.placeholder = "Create new Item"
            textField = UITextField
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Did selcect row, goto Item
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ConstantNameTodoey.segueIdentifier, sender: self)
//        context.delete(categoryArr[indexPath.row])
//        categoryArr.remove(at: indexPath.row)
//        saveContext()
//        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArr[indexPath.row]
        }
    }
    
    
    //MARK: - Load TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantNameTodoey.categoryReusableShell, for: indexPath)
        cell.textLabel?.text = categoryArr[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: - SaveContext
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Load Data
        func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
            do {
             categoryArr =  try context.fetch(request)
             tableView.reloadData()
            } catch {
                print("Fetching failed........")
            }
        }
}
