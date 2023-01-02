//
//  Item.swift
//  Todoey
//
//  Created by Bao Long on 23/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
//   @Persisted(primaryKey: true) var _id: ObjectId
   @objc dynamic var name: String = ""
   @objc dynamic var age: Int = 0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "item")
    
}
