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
        print("============testArchiveObject==============")
        archiveExample.testArchiveObject()
        print("============testArchiveList==============")
        archiveExample.testArchiveList()
        
        print("\n\n")
        
        print("============testNSPropertyListSerialization==============")
        serializationExample.testNSPropertyListSerialization()
        print("============testNSJSONSerialization==============")
        serializationExample.testNSJSONSerialization()
        print("============testNSUserDefaults==============")
        serializationExample.testNSUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var archiveExample : NSCodingArchiveExample = {
        let example = NSCodingArchiveExample()
        return example
    }()
    
    lazy var serializationExample : SerializationExample = {
        let example = SerializationExample()
        return example
    }()
    
    

}

