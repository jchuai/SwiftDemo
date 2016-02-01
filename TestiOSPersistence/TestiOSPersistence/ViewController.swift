//
//  ViewController.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/1/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testArchiveSave()
        testArchiveLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var testPath : String = {
        let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        let userFile = (documentDir! as NSString).stringByAppendingPathComponent("user.plist")
        return userFile
    }()
    
    func testArchiveSave() {
        let address = Address()
        address.country = "中国"
        address.city = "杭州"
        
        let address1 = Address()
        address1.country = "中国"
        address1.city = "衡水"
        
        let user = User()
        user.name = "Junna"
        user.password = "123456"
        user.address?.addObject(address)
        user.address?.addObject(address1)
        
        NSKeyedArchiver.archiveRootObject(user, toFile: testPath)
    }
    
    func testArchiveLoad() {
        if let object = NSKeyedUnarchiver.unarchiveObjectWithFile(testPath) as? User {
            print(object.dynamicType)
        }
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
}

class User: NSObject, NSCoding {
    var name : String
    var password: String
    var address : NSMutableArray?
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(address, forKey: "address")
    }
    
    override init() {
        name = ""
        password = ""
        address = NSMutableArray()
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String ?? ""
        self.address = aDecoder.decodeObjectForKey("address") as? NSMutableArray
        self.password = aDecoder.decodeObjectForKey("password") as? String ?? ""
    }
}