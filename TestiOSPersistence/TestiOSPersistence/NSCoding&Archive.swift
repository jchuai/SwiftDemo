//
//  NSCoding&Archive.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/1/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
let rootDir : NSString = {
    let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
    return documentDir!
}()

class NSCodingArchiveExample {
    
    
    func testArchiveObject() -> String {
        let testPath = rootDir.stringByAppendingPathComponent("NSCodingArchiveExample_testArchiveObject.plist")

        let address = Address()
        address.country = "中国"
        address.city = "杭州"
        
        let address1 = Address()
        address1.country = "中国"
        address1.city = "衡水"
        
        let user = User()
        user.name = "Junna"
        user.password = "123456"
        user.address = [address, address1]
        
        NSKeyedArchiver.archiveRootObject(user, toFile: testPath)
        
        if let object = NSKeyedUnarchiver.unarchiveObjectWithFile(testPath) as? User {
            print(object.description)
            return object.description
        }
        return ""
    }
    
    func testArchiveList() -> String {
        let testPath = rootDir.stringByAppendingPathComponent("NSCodingArchiveExample_testArchiveList.plist")

        let address = Address()
        address.country = "中国"
        address.city = "杭州"
        
        let address1 = Address()
        address1.country = "中国"
        address1.city = "衡水"
        
        NSKeyedArchiver.archiveRootObject([address, address1], toFile: testPath)

        var result = ""
        if let object = NSKeyedUnarchiver.unarchiveObjectWithFile(testPath) as? [Address] {
            for add in object {
                print(add.description)
                result += "\(add.description)\n"
            }
        }
        return result
    }
}

class Address : NSObject, NSCoding {
    var country : String
    var city : String
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(country, forKey: "country")
        aCoder.encodeObject(city, forKey: "city")
    }
    
    override init() {
        country = ""
        city = ""
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.country = aDecoder.decodeObjectForKey("country") as? String ?? ""
        self.city = aDecoder.decodeObjectForKey("city") as? String ?? ""
    }
    
    override var description : String {
        return "\(country), \(city)"
    }
}

class User: NSObject, NSCoding {
    var name : String
    var password: String
    var address : [Address]
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(address, forKey: "address")
    }
    
    override init() {
        name = ""
        password = ""
        address = []
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String ?? ""
        self.address = aDecoder.decodeObjectForKey("address") as? [Address] ?? []
        self.password = aDecoder.decodeObjectForKey("password") as? String ?? ""
    }
    
    override var description : String {
        var str = "name: \(name)  password: \(password) \naddress:"
        for add in address {
            str += "\n\(add.description)"
        }
        return str
    }
}