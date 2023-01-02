//
//  WebService.swift
//  CoffeeOrderApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case DomainError
    case URLError
}

struct Resource<T: Codable> {
    var url: URL
    var body: Data?
    var httpMethod: HttpMethod = .get
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data, error == nil else {
                completion(Result<T, NetworkError>.failure(NetworkError.DomainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
