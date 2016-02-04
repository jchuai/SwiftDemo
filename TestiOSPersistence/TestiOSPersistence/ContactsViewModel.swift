//
//  ContactsViewModel.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/4/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class ContactsViewModel {
    private var dataSource : [Person] = []
    private var sqliteTool = SqlitePersonExample(dbName: "Contacts.sqlite")
    
    func loadDataModel() {
        dataSource = sqliteTool?.fetchAllPerson() ?? []
    }
    
    func getPerson(index: Int) -> Person {
        return dataSource[index]
    }
    
    func insertPerson(person: Person) {
        dataSource.append(person)
        sqliteTool?.insert(person)
    }
    
    func personCount() -> Int {
        return dataSource.count
    }
    
}

class Person {
    var name : String = ""
    var city : String = ""
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}