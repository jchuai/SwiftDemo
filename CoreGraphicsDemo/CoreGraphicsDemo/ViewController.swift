//
//  ViewController.swift
//  CoreGraphicsDemo
//
//  Created by Junna on 2/14/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var ellipseDemoView: EllipseDemoView?
    private var lineDemoView: LineDemoView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ellipseDemoView = EllipseDemoView(frame: CGRectMake(50,50,200,200))
        self.view.addSubview(ellipseDemoView!)
        
        lineDemoView = LineDemoView(frame: CGRectMake(50,260,200,200))
        self.view.addSubview(lineDemoView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


