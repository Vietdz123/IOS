//
//  OrderViewModel.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

class ListOrderViewModel {
    var orderListViewModel: [OrderViewModel]
    
    init() {
        self.orderListViewModel = [OrderViewModel]()
    }
}

extension ListOrderViewModel {
    func orderViewModel(at Index: Int) -> OrderViewModel {
        return orderListViewModel[Index]
    }
}

struct OrderViewModel {
     let order: Order
}

extension OrderViewModel {
    var name: String {
        return order.name
    }
    
    var email: String {
        return order.email
    }
    
    var type: String {
        return order.type.rawValue.capitalized
    }
    
    var size: String {
        return order.size.rawValue.capitalized
    }
}
