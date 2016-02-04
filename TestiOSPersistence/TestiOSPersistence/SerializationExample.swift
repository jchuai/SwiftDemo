//
//  SerializationExample.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/1/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation

class SerializationExample {
    func testNSPropertyListSerialization() -> String {
        let testPath = rootDir.stringByAppendingPathComponent("SerializationExample_PropertyList.plist")
        var testObject : [String: AnyObject] = [:]
        testObject["string"] = "Hi, I'm a String"
        testObject["number"] = 23
        testObject["boolean"] = true
        testObject["date"] = NSDate(timeIntervalSince1970: 0)
        testObject["array"] = ["I", "seem", "to", "be", "a", "array"]
        testObject["dict"] = ["Ack": "Oop", "Bill the Cat": "It's"]
        /* only object that .plist can support works
        let add = Address()
        add.country = "中国"
        add.city = "HZ"
        testObject["object"] = add */
        var message = ""
        do {
            let testData = try NSPropertyListSerialization.dataWithPropertyList(testObject, format: .XMLFormat_v1_0, options: 0)
            let succeed = testData.writeToFile(testPath, atomically: true)
            if succeed {
                print("Save Succeed!")
                message += "Save Succeed!\n"
            } else {
                print("Save Fail!")
                message += "Save Fail!\n"
            }
        } catch {
            print("序列化失败")
            message += "序列化失败\n"
        }
        
        do {
            var format : NSPropertyListFormat = .XMLFormat_v1_0
            let data = try NSData(contentsOfFile: testPath, options: .DataReadingMapped)
            let object = try NSPropertyListSerialization.propertyListWithData(data, options: .Immutable, format: &format) as? [String: AnyObject]
            print(object)
            message += "\(object)\n"
        } catch {
            print("反序列化失败")
            message += "反序列化失败\n"
        }
        return message
    }
    
    func testNSJSONSerialization() -> String {
        let testPath = rootDir.stringByAppendingPathComponent("SerializationExample_JSON.txt")
        var testObject : [String: AnyObject] = [:]
        testObject["string"] = "Hi, I'm a String"
        testObject["number"] = 23
        testObject["boolean"] = true
        // NSDate can't be serializated as JSON object
//        testObject["date"] = NSDate(timeIntervalSince1970: 0)
        testObject["array"] = ["I", "seem", "to", "be", "a", "array"]
        testObject["dict"] = ["Ack": "Oop", "Bill the Cat": "It's"]
        var message = ""
        do {
            let testData = try NSJSONSerialization.dataWithJSONObject(testObject, options: .PrettyPrinted)
            let succeed = testData.writeToFile(testPath, atomically: true)
            if succeed {
                print("Save Succeed!")
                message += "Save Succeed!\n"
            } else {
                print("Save Fail!")
                message += "Save Fail!\n"
            }
        } catch {
            print("序列化失败")
            message += "序列化失败\n"
        }
        
        do {
            let data = try NSData(contentsOfFile: testPath, options: .DataReadingMapped)
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            print(object)
        } catch {
            print("反序列化失败")
            message += "反序列化失败\n"
        }
        return message
    }
    
    func testNSUserDefaults() -> String {
        var message = ""
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let version = userDefaults.objectForKey("appVersion") {
            print("current app version: \(version)")
            message += "current app version: \(version)\n"
        } else {
            userDefaults.setObject("2.8.1", forKey: "appVersion")
            print("set app version: 2.8.1")
            message += "set app version: 2.8.1"
        }
        return message
    }
}