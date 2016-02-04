//
//  ViewController.swift
//  TestCoreData
//
//  Created by Junna on 2/3/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit
import CoreData

private let statusBarHeight : CGFloat = UIApplication.sharedApplication().statusBarFrame.height + 44

class ViewController: UIViewController {
    
    var people: [Person] = []
    
    private var citys: Set<String> {
        var list = Set<String>()
        for person in people {
            if let city = person.valueForKey("city") as? String {
                list.insert(city)
            }
        }
        return list
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "AddFriend", style: .Plain, target: self, action: "addFriends")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "筛选", style: .Plain, target: self, action: "shift")
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "CoreData Test"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequst = NSFetchRequest(entityName: "Person")
        do {
            if let results = try managedContext?.executeFetchRequest(fetchRequst) as? [Person] {
                people = results
            }
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let frame = CGRectMake(0, statusBarHeight, self.view.bounds.width, self.view.bounds.height)
        tableView.frame = frame
    }
    
    // MARK:- 添加好友
    func addFriends() {
        let alert = UIAlertController(title: "增加好友", message: "请输入姓名和城市", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "请输入姓名"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "请输入城市"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { [weak self](action) -> Void in
            let name = alert.textFields?.first?.text ?? ""
            let city = alert.textFields?.last?.text ?? ""
            self?.addFriendsWith(name, city: city)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func addFriendsWith(name: String, city: String) {
        if let entity = self.personEntity {
            let person = NSManagedObject(entity: entity, insertIntoManagedObjectContext: self.managedContext) as! Person
            person.city = city
            person.name = name
//            person.setValue(name, forKey: "name")
//            person.setValue(city, forKey: "city")
            self.people.append(person)
            self.tableView.reloadData()
            do {
                try self.managedContext?.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK:- 筛选
    func shift() {
        let alert = UIAlertController(title: "筛选", message: "请选择城市", preferredStyle: .ActionSheet)
        for city in citys {
            let action = UIAlertAction(title: city, style: .Default, handler: { [weak self](action) -> Void in
                if let selectedCity = action.title {
                    let request = NSFetchRequest(entityName: "Person")
                    let predicate = NSPredicate(format: "%K == %@", "city", selectedCity)
                    request.predicate = predicate
                    do {
                        if let results = try self?.managedContext?.executeFetchRequest(request) as? [Person] {
                            self?.people = results
                        }
                        self?.tableView.reloadData()
                    } catch let error as NSError {
                        print("Could not fetch \(error), \(error.userInfo)")
                    }
                }
            })
            alert.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "全部", style: .Cancel, handler: { [weak self](action) -> Void in
            let request = NSFetchRequest(entityName: "Person")
            do {
                if let results = try self?.managedContext?.executeFetchRequest(request) as? [Person] {
                    self?.people = results
                }
                self?.tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            })
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: .Grouped)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.whiteColor()
        return table
    }()
    
    lazy var managedContext: NSManagedObjectContext? = {
        if let del = UIApplication.sharedApplication().delegate as? AppDelegate {
            return del.managedObjectContext
        }
        return nil
    }()
    
    lazy var personEntity: NSEntityDescription? = {
        if let context = self.managedContext {
            return NSEntityDescription.entityForName("Person", inManagedObjectContext: context)
        }
        return nil
    }()
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CoreDataTestCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "CoreDataTestCell")
        }
        cell?.textLabel?.text = people[indexPath.row].name
        cell?.detailTextLabel?.text = people[indexPath.row].city
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

