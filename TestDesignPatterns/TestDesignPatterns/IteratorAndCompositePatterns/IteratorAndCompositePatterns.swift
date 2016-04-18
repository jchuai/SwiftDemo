//
//  IteratorAndCompositePatterns.swift
//  TestDesignPatterns
//
//  Created by Junna on 1/19/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

protocol Iterator {
    func hasNext() -> Bool
    func next() -> AnyObject
}

protocol MenuComponent : class {
    func printContent()
}

protocol MenuProtocol: MenuComponent {
    func addItem(item: MenuComponent)
    func createIterator() -> Iterator
    func printDesc()
}
extension MenuProtocol {
    func printContent() {
        printDesc()
        let iterator = createIterator()
        while iterator.hasNext() {
            let item = iterator.next() as? MenuComponent
            item?.printContent()
        }
    }
}


class Menu: MenuProtocol {
    private var items: [MenuComponent]
    private var desc : String
    init(desc: String) {
        self.desc = desc
        items = []
    }
    func addItem(item: MenuComponent) {
        items.append(item)
    }
    
    func createIterator() -> Iterator {
        return MenuComponentIterator(items: items)
    }
    
    func printDesc() {
        print(desc)
    }
}


func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class MenuItem : Hashable, MenuComponent {
    var name        : String
    var description : String
    var vegetarian  : Bool
    var price       : Double
    init(name: String, description: String, vegetarian: Bool, price: Double) {
        self.name           = name
        self.description    = description
        self.vegetarian     = vegetarian
        self.price          = price
    }
    
    var hashValue: Int {
        get {
            return "\(name)\(description)\(vegetarian)".hashValue
        }
    }
    
    func printContent() {
        print("\(self.name), \(self.price) -- \(self.description)")
    }

}

class MenuComponentIterator : Iterator {
    private var items   : [MenuComponent]
    private var position: Int
    init(items: [MenuComponent]) {
        self.items = items
        position = 0
    }
    
    func hasNext() -> Bool {
        return position < items.count
    }
    
    func next() -> AnyObject {
        return items[position++]
    }
}



