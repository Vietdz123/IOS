//
//  WeSservices.swift
//  GoodWeather
//
//  Created by Bao Long on 28/12/2022.
//

import Foundation

struct Resource<T> {
    var url : URL
    var parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, responce, err in
            if let data = data, err == nil {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
}
