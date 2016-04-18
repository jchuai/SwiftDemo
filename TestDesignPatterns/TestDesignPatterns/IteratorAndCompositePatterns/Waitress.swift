//
//  Waitress.swift
//  TestDesignPatterns
//
//  Created by Junna on 1/21/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class Waitress {
    private var menuList : [MenuProtocol]
    init() {
        menuList = []
        let breakfast = PancakeHouseMenu(desc: "Breakfast Menu:")
        let lunch = DinerMenu(desc: "Lunch Menu:")
        let dinner = CafeMenu(desc: "Dinner Menu:")
        
        let dessertMenu = Menu(desc: "Dessert Menu:")
        dessertMenu.addItem(MenuItem(name: "Apple Pie", description: "Apple pie with a flakey crust, topped with vanilla ice cream", vegetarian: true, price: 1.59))
        lunch.addItem(dessertMenu)
        
        menuList.append(breakfast)
        menuList.append(lunch)
        menuList.append(dinner)
    }
    
    func printMenu() {
        for item in menuList {
            item.printContent()
            print("\n")
        }
    }
}