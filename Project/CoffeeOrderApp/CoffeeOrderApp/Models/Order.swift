//
//  Order.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

enum FoodType: String, Codable, CaseIterable {
    case bimbim
    case sucxich
    case quay
    case mitom
    case capuchino
}

enum FoodSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    var name: String
    var email: String
    var type: FoodType
    var size: FoodSize
}

extension Order {
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("ALL Error")
        }
        
        return Resource<[Order]>(url: url)
    }()             //Closure
    
    
    static func create(vm: AddCoffeeViewModel) -> Resource<Order?> {
        let order = Order(vm)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL Wrong >>>>>>>>")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("ENCODE Error >>>>>>")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        return resource
    }
}

extension Order {
    init?(_ vm :AddCoffeeViewModel) {                      //INIT?
        guard let name = vm.name, let email = vm.email,
              let type = FoodType(rawValue: vm.selectedType!.lowercased()),
              let size = FoodSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
    }
}
