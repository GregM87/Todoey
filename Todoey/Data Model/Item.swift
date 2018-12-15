//
//  Item.swift
//  Todoey
//
//  Created by MacBookPro on 14.12.18.
//  Copyright © 2018 Gregor Mangelsdorf. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title: String = ""
   @objc dynamic var done: Bool = false
   @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
