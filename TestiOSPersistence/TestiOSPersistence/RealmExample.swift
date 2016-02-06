//
//  RealmExample.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/6/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import RealmSwift

class RealmExample: ContactsDataModelDelegate {
    
    private let realm = try! Realm()
    
    func fetchAllPerson() -> [Person] {
        let realmPeople = realm.objects(RealmPerson)
        var result = [Person]()
        for realmPerson in realmPeople {
            result.append(realmPerson.convertToPerson())
        }
        return result
    }
    
    func insert(person: Person) {
        try! realm.write({ () -> Void in
            realm.add(RealmPerson(value: person))
        })
    }
}

class RealmPerson: Object {
    dynamic var name: String = ""
    dynamic var city: String = ""
    func convertToPerson() -> Person {
        return Person(name: name, city: city)
    }
    
    override init(value: AnyObject) {
        super.init(value: value)
        if let person = value as? Person {
            name = person.name
            city = person.city
        }
    }

    required init() {
        super.init()
    }
    
}