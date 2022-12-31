//
//  Artical.swift
//  NewsApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

struct Articles : Decodable {
    var articles: [Article]
    
}

struct Article: Decodable {
    var title: String
    var description: String
}
