//
//  ViewController.swift
//  FloCGDemo
//
//  Created by Junna on 2/15/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(counterView)
        self.view.addSubview(plusButton)
        self.view.addSubview(subtractButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let centerX  = self.view.width / 2
        
        counterView.centerX = centerX
        counterView.centerY = 200
        
        plusButton.centerX = centerX
        plusButton.centerY = self.view.height / 2 + 100
        
        subtractButton.centerX = centerX
        subtractButton.centerY = plusButton.centerY + 100
    }
    
    func plus() {
        counterView.counter++
    }
    
    func subtract() {
        counterView.counter--
    }

    lazy var plusButton: PushButton = {
        let button = PushButton(frame: CGRectMake(0, 0, 100, 100))
        button.addTarget(self, action: "plus", forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var subtractButton: PushButton = {
        let button = PushButton(frame: CGRectMake(0, 0, 50, 50), type: .Subtract)
        button.addTarget(self, action: "subtract", forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var counterView: CounterView = {
        let view = CounterView(frame: CGRectMake(0, 0, 230, 230))
        return view
    }()
}

