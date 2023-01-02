//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArr = [Item]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory : Category? {
        didSet {
            loadData()
        }
    }
    
    //MARK: - Press Button Add
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "Hello ae wibu", preferredStyle: .alert)

        alert.addTextField { UITextField in
            UITextField.placeholder = "Create new Item"
            textField = UITextField
        }


        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text! != "" {
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.flagCheck = false
                newItem.parentCategory = self.selectedCategory
                self.itemArr.append(newItem)
                self.tableView.reloadData()
                self.saveContext()
            }
        }

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello viewDidLoad************")
        searchBar.delegate = self
        //loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantNameTodoey.nameReusableShell, for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    
//MARK: - DidSelect Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemArr[indexPath.row].flagCheck != false {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            itemArr[indexPath.row].flagCheck = false
            print(indexPath.row)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            itemArr[indexPath.row].flagCheck = true
            print(indexPath.row)
        }
                context.delete(itemArr[indexPath.row])
                itemArr.remove(at: indexPath.row)
                saveContext()
                tableView.reloadData()
        saveContext()
    }
    
//MARK: - Save Context
    
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
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name as! CVarArg )
                
                if let addtionalPredicate = predicate {
                    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
                } else {
                    request.predicate = categoryPredicate
                }

                
                do {
                    itemArr = try context.fetch(request)
                } catch {
                    print("Error fetching data from context \(error)")
                }
                
                tableView.reloadData()
                
            }

    func loadAllData(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArr = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    @IBAction func ButtonLoadAllPressed(_ sender: UIButton) {
        print("load all*********")
        loadAllData()
        tableView.reloadData()
    }
}

//MARK: - Delegate SearchBar
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //cd là case: chữ thường và chữ hoa và drima
        let sortDescrip = NSSortDescriptor(key: "title", ascending: false)
        request.predicate = predicate
        request.sortDescriptors = [sortDescrip] //Cần truyền 1 mảng vào nên ta dùng trick này
        loadData(with: request, predicate: predicate)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()  //Làm mất keyboard bên dưới
            }
        }
    }
}
