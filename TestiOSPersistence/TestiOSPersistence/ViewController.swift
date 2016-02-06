//
//  ViewController.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/1/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

let statusBarHeight : CGFloat = UIApplication.sharedApplication().statusBarFrame.height + 44

class ViewController: UIViewController {
    enum CellType {
        case Archive, Serialization, SQLite, Realm
    }
    
    private var dataSource : [(type:CellType, value:String)] = [
            (.Archive, "NSCoding&Archive Example"),
            (.Serialization, "Serialization Example"),
            (.SQLite, "SQLite Example"),
            (.Realm, "Realm Example")
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iOS Persistence Example"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
        /*
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

        print("\n\n")
        print("============testSQLite==============")
        sqliteExample = SqliteExample(dbName: "example.sqlite")
        */
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let frame = CGRectMake(0, statusBarHeight, self.view.bounds.height - statusBarHeight, self.view.bounds.width)
        tableView.frame = frame
    }

    private func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: .Grouped)
        table.backgroundColor = UIColor.whiteColor()
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var archiveExample : NSCodingArchiveExample = {
        let example = NSCodingArchiveExample()
        return example
    }()
    
    lazy var serializationExample : SerializationExample = {
        let example = SerializationExample()
        return example
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let type = dataSource[indexPath.row].type
        let title = dataSource[indexPath.row].value
        switch type {
        case .Archive:
            var message = "====testArchiveObject====\n"
            message += archiveExample.testArchiveObject()
            message += "\n====testArchiveList====\n"
            message += archiveExample.testArchiveList()
            showMessage(title, message: message)
        case .Serialization:
            var message = "====testNSPropertyListSerialization====\n"
            message += serializationExample.testNSPropertyListSerialization()
            message += "\n====testNSJSONSerialization====\n"
            message += serializationExample.testNSJSONSerialization()
            message += "\n====testNSUserDefaults====\n"
            message += serializationExample.testNSUserDefaults()
            showMessage(title, message: message)
        case .SQLite:
            let vc = ContactsViewController()
            vc.type = .SQLite
            self.navigationController?.pushViewController(vc, animated: true)
        case .Realm:
            let vc = ContactsViewController()
            vc.type = .Realm
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "tableViewCell")
        }
        cell?.textLabel?.text = dataSource[indexPath.row].value
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}

