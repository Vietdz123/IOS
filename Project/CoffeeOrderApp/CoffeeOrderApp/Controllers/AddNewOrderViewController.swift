//
//  AddNewOrderViewController.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import UIKit

protocol AddFoodOrderDelegate {
    func addFoodOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addFoodOrderViewControllerDidClose(controller: UIViewController)
}


class AddNewOrderViewController: UIViewController {
    var addNewOrder: AddCoffeeViewModel = AddCoffeeViewModel()
    var delegate: AddFoodOrderDelegate?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addOrderTableView: UITableView!
    @IBOutlet weak var sizeOrderSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addOrderTableView.delegate = self
        self.addOrderTableView.dataSource = self
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        addNewOrder.name = nameTextField.text
        addNewOrder.email = emailTextField.text
        addNewOrder.selectedSize = self.sizeOrderSegment.titleForSegment(at: self.sizeOrderSegment.selectedSegmentIndex)
        
        guard let indexPath = self.addOrderTableView.indexPathForSelectedRow else {
            fatalError("GET FAILED INDEXPATH >>>>>>")
        }
        
        addNewOrder.selectedType = addOrderTableView.cellForRow(at: indexPath)?.textLabel?.text

        
        WebService().load(resource: Order.create(vm: self.addNewOrder)) { result in
            switch result {
                case .success(let orders):

                if let orders = orders, let delegate = self.delegate {
                    //DispatchQueue.main.async {
                        delegate.addFoodOrderViewControllerDidSave(order: orders, controller: self)
                    //}
                }
                        
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        if let delegate = delegate {
            delegate.addFoodOrderViewControllerDidClose(controller: self)
        }
    }
    
    
}

extension AddNewOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addNewOrder.type.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addOrderTableView.dequeueReusableCell(withIdentifier: "AddNewOrderCell")
        cell?.textLabel?.text = addNewOrder.type[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
