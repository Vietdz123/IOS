//
//  Service.swift
//  NewsApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

class Service {
    func getArtical(url: URL, completion:  @escaping([Article]?) -> ()) {       //TẠI SAO LẠI CÓ ?
        URLSession.shared.dataTask(with: url) { [self] data, responce, err in
            if err != nil {
                print(err!)
                completion(nil)
            } else {
                
                print(">>>>>>>>>>>HA")
                if let safeData = data {
                    let articleDecoded = self.parseData(data: safeData)
                    completion(articleDecoded)
                }
            }
        }.resume()
        
    }
    
    func parseData(data: Data) -> [Article]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Articles.self, from: data)
            return decodeData.articles
        } catch {
            print(">>>>>>>>>>>>PARSE FAILED")
            return nil
        }

    }
}
