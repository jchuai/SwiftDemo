//
//  Person.swift
//  TestCoreData
//
//  Created by Junna on 2/4/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import CoreData

@objc(Person)

class Person: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var city: String?
}
