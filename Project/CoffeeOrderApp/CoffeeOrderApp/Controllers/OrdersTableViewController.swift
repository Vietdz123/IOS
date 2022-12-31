//
//  OrdersTableViewController.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddFoodOrderDelegate {
    func addFoodOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true)
        
        let order = OrderViewModel(order: order)
        self.orderList.orderListViewModel.append(order)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderList.orderListViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addFoodOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)

    }
    
    var orderList = ListOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrder()
        
    }
    
    private func populateOrder() {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL Error >>>>>>>>>>")
        }
        
        WebService().load(resource: Resource<[Order]>(url: url)) { result in
            switch result {
                case .success(let orders):
                        print(orders)
                    self.orderList.orderListViewModel = orders.map({ order in
                        return OrderViewModel(order: order)
                    })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addFoodOrderVC = navC.viewControllers.first as? AddNewOrderViewController else {
            fatalError("FALSE >>>>")
        }
        
        addFoodOrderVC.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderList.orderListViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOrder")
        cell?.textLabel?.text = orderList.orderViewModel(at: indexPath.row).name
        cell?.detailTextLabel?.text = orderList.orderViewModel(at: indexPath.row).email
        return cell!
    }

}
