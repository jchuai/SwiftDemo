//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Junna on 3/15/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RefreshViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var refreshView: RefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshView = RefreshView(frame: CGRect(x: 0, y: -200, width: self.view.bounds.width, height: 200), imageName: "sun", scrollView: tableView)
        refreshView?.delegate = self
        refreshView?.backgroundColor = UIColor.redColor()
        tableView.addSubview(refreshView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRefreshing() {
        
    }

}

