//
//  AddNewOrderViewModel.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

struct AddCoffeeViewModel {
    var name: String?
    var email: String?
    
    var selectedSize: String?
    var selectedType: String?
    
    var type: [String] {
        return FoodType.allCases.map { food in
            return food.rawValue.capitalized
        }
    }
    
    var size: [String] {
        return FoodSize.allCases.map { size in
            return size.rawValue.capitalized
        }
    }
}
