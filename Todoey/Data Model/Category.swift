//
//  Category.swift
//  Todoey
//
//  Created by MacBookPro on 14.12.18.
//  Copyright © 2018 Gregor Mangelsdorf. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
    let items = List<Item>()
}
