//
//  SqliteExample.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/4/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class SqlitePersonExample {
    lazy var documentDir : String = {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
    }()
    
    private var db : COpaquePointer = nil
    private var dbName: String
    init?(dbName: String) {
        self.dbName = dbName
        if !open() {
            return nil
        }
    }
    
    private func open() -> Bool{
        let dbPath = (documentDir as NSString).stringByAppendingPathComponent(dbName)
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Fail to open DB!")
            return false
        }
        
        if sqlite3_exec(db, "create table if not exists person (name text, city text)", nil, nil, nil) != SQLITE_OK {
            print("Fail to create table! \(String.fromCString(sqlite3_errmsg(db)))")
            return false
        }
        return true
    }
    
    deinit {
        if sqlite3_close_v2(db) != SQLITE_OK {
            print(("Fail to close DB! \(String.fromCString(sqlite3_errmsg(db)))"))
        }
        db = nil
    }
    
    func insert(person: Person) {
        if sqlite3_exec(db, "insert into person (name, city) values (\"\(person.name)\",\"\(person.city)\")", nil, nil, nil) != SQLITE_OK {
            print("Fail to insert new entity! \(String.fromCString(sqlite3_errmsg(db)))")
        }
    }
    
    func fetchAllPerson() -> [Person] {
        var people = [Person]()
        var statement: COpaquePointer = nil
        if sqlite3_prepare(db, "select name, city from person", -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let nameChars = sqlite3_column_text(statement, 0)
                let name = String.fromCString(UnsafePointer<CChar>(nameChars)) ?? ""
                let cityChars = sqlite3_column_text(statement, 1)
                let city = String.fromCString(UnsafePointer<CChar>(cityChars)) ?? ""
                let person = Person(name: name, city: city)
                people.append(person)
            }
        }
        return people
    }
}