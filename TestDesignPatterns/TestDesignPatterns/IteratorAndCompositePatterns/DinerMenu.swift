//
//  DinerMenu.swift
//  TestDesignPatterns
//
//  Created by Junna on 1/21/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class DinerMenu : MenuProtocol {
    private var menuItems: [MenuComponent]
    var desc : String 
    init(desc: String) {
        self.desc = desc
        menuItems = []
        addItem("Vegetarian BLT", desc: "(Fakin') Bacon with lettuce & tomato on whole wheat", vegetarian: true, price: 2.99)
        addItem("BLT", desc: "Bacon with lettuce & tomato on whole wheat", vegetarian: false, price: 2.99)
        addItem("Soup of the day", desc: "Soup of the day, with a side of potato salad", vegetarian: false, price: 3.29)
        addItem("Hotdog", desc: "A hot dog, with saurkraut, relish, onions, topped with cheese", vegetarian: false, price: 3.05)
        
    }
    
    func addItem(item: MenuComponent) {
        menuItems.append(item)
    }
    
    func addItem(name: String, desc: String, vegetarian: Bool, price: Double) {
        let item = MenuItem(name: name, description: desc, vegetarian: vegetarian, price: price)
        addItem(item)
    }
    
    func printDesc() {
        print(desc)
    }
    
    func createIterator() -> Iterator {
        return MenuComponentIterator(items: menuItems)
    }
}
