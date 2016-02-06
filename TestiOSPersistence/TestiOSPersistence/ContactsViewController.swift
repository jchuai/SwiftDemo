//
//  ContactsViewController.swift
//  TestiOSPersistence
//
//  Created by Junna on 2/4/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController {
    enum StorageType {
        case SQLite, CoreData, Realm
    }
    
    var type: StorageType = .SQLite {
        didSet {
            switch type {
            case .SQLite:
                delegate = SqlitePersonExample(dbName: "Contacts.sqlite")
            case .Realm:
                delegate = RealmExample()
            default:
                break
            }
        }
    }
    private var delegate : ContactsDataModelDelegate?
    private lazy var viewModel: ContactsViewModel = {
        let viewModel = ContactsViewModel(delegate: self.delegate)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddFriend", style: .Plain, target: self, action: "addFriends")
        self.view.backgroundColor = UIColor.whiteColor()
        viewModel.loadDataModel()
        tableView.reloadData()
    }
    
    @objc private func addFriends() {
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
        let person = Person(name: name, city: city)
        viewModel.insertPerson(person)
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let frame = CGRectMake(0, statusBarHeight, self.view.bounds.height - statusBarHeight, self.view.bounds.width)
        tableView.frame = frame
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRectZero, style: .Grouped)
        table.backgroundColor = UIColor.whiteColor()
        table.dataSource = self
        table.delegate = self
        return table
    }()
}

extension ContactsViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.personCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "tableViewCell")
        }
        let person = viewModel.getPerson(indexPath.row)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.city
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
