//
//  CafeMenu.swift
//  TestDesignPatterns
//
//  Created by Junna on 1/21/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class CafeMenu: MenuProtocol {
    private var menuItems : Set<MenuItem>
    private var desc: String
    init(desc: String) {
        self.desc = desc
        menuItems = Set<MenuItem>()
        addItem("Veggie Burger and Air Fries", desc: "Veggie burger on a whole wheat bun, lettuce, tomato, and fries", vegetarian: true, price: 3.99)
        addItem("Soup of the day", desc: "A cup of the soup of the day, with a side salad", vegetarian: false, price: 3.69)
        addItem("Burrito", desc: "A large burrito, with whole pinto beans, salsa, guacamole", vegetarian: true, price: 4.29)
    }
    
    func addItem(item: MenuComponent) {
        if let menuItem = item as? MenuItem {
            menuItems.insert(menuItem)
        } else {
            print("Can only add MenuItem!!")
        }
    }
    
    func addItem(name: String, desc: String, vegetarian: Bool, price: Double) {
        let item = MenuItem(name: name, description: desc, vegetarian: vegetarian, price: price)
        addItem(item)
    }
    
    func createIterator() -> Iterator {
        var items : [MenuComponent] = []
        var generator = menuItems.generate()
        while let item = generator.next() {
            items.append(item)
        }
        return MenuComponentIterator(items: items)
    }
    
    func printDesc() {
        print(desc)
    }
}


