//
//  PancakeHouseMenu.swift
//  TestDesignPatterns
//
//  Created by Junna on 1/21/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class PancakeHouseMenu : MenuProtocol {
    private var menuItems: NSMutableArray
    private var desc: String
    init(desc: String) {
        self.desc = desc
        menuItems = NSMutableArray()
        addMenuItem("K & B's Pancake Breakfast", desc: "Pancakes with scrambled eggs, and toast", vegetarian: true, price: 2.99)
        addMenuItem("Regular Pancake Breakfast", desc: "Pancakes with fried eggs, sausage", vegetarian: false, price: 2.99)
        addMenuItem("Blueberry Pancakes", desc: "Pancakes with fresh blueberries", vegetarian: true, price: 3.49)
        addMenuItem("Wafles", desc: "Wafles, with your choice of blueberries or strawebrries", vegetarian: true, price: 3.59)
    }
    
    func addItem(item: MenuComponent) {
        menuItems.addObject(item)
    }
    
    func addMenuItem(name: String, desc: String, vegetarian: Bool, price: Double) {
        let item = MenuItem(name: name, description: desc, vegetarian: vegetarian, price: price)
        addItem(item)
    }
    
    func createIterator() -> Iterator {
        var items = [MenuComponent]()
        for item in menuItems {
            items.append(item as! MenuComponent)
        }
        return MenuComponentIterator(items: items)
    }
    
    func printDesc() {
        print(desc)
    }
}