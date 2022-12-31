//
//  Data.swift
//  Todoey
//
//  Created by Bao Long on 23/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
//   @Persisted(primaryKey: true) var _id: ObjectId
   @objc dynamic var name: String = "123"
   @objc  dynamic var age: Int = 0
    let item = List<Item>()
}
