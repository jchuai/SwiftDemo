//
//  ContactsViewModel.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/4/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

protocol ContactsDataModelDelegate: class {
    func fetchAllPerson() -> [Person]
    func insert(person: Person)
}

class ContactsViewModel {
    weak var delegate : ContactsDataModelDelegate?
    private var dataSource : [Person] = []
//    private var sqliteTool = SqlitePersonExample(dbName: "Contacts.sqlite")

    init(delegate: ContactsDataModelDelegate?) {
        self.delegate = delegate
    }
    func loadDataModel() {
        dataSource = delegate?.fetchAllPerson() ?? []
    }
    
    func getPerson(index: Int) -> Person {
        return dataSource[index]
    }
    
    func insertPerson(person: Person) {
        dataSource.append(person)
        delegate?.insert(person)
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