//
//  ViewController.swift
//  Bahama
//
//  Created by Junna on 3/2/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(heading)
        self.view.addSubview(username)
        self.view.addSubview(password)
        self.view.addSubview(login)
        
        self.view.addSubview(cloud1)
        self.view.addSubview(cloud2)
        self.view.addSubview(cloud3)
        self.view.addSubview(cloud4)
        login.addSubview(spinner)
        
        self.view.addSubview(status)
        status.hidden = true
        status.addSubview(label)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        heading.center.y = 100
        
        username.top = heading.bottom + 50
        
        password.top = username.bottom + 20
        
        login.centerX = self.view.width / 2
        spinner.centerY = login.height / 2
        spinner.left = 40
        /*
        cloud1.left = 20
        cloud1.top = 300
        
        cloud2.right = self.view.width - 20
        cloud2.top = 100
        
        cloud3.centerY = 50
        
        cloud4.left = 150
        cloud4.centerY = 200 */
        
        status.top = password.bottom + 10
        status.centerX = login.centerX
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /*
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0

        cloud3.right = 0.0
        cloud4.alpha = 0.0 */
        
        heading.center.x    = -0.5 * self.view.bounds.width
        username.center.x   = -0.5 * self.view.bounds.width
        password.center.x   = -0.5 * self.view.bounds.width
        
        login.alpha = 0.0
        
    }
    
    func showMessage(index: Int) {
        label.text = messages[index]
        label.sizeToFit()
        label.centerX = status.width / 2
        label.centerY = status.height / 2
        UIView.transitionWithView(status, duration: 0.33, options: [.CurveEaseOut, .TransitionCurlDown], animations: { () -> Void in
            self.status.hidden = false
            }, completion: { _ in
                self.delay(2.0, action: { () -> Void in
                    if index < self.messages.count - 1 {
                        self.removeMessage(index)
                    } else {
                        
                        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                            self.status.hidden = true
                            self.status.centerX = self.view.width / 2
                            var rect = self.login.frame
                            rect.width -= 80
                            rect.centerY -= 60
                            rect.centerX = self.login.centerX
                            self.login.frame = rect
                            self.login.backgroundColor = UIColor(red: 61/255, green: 190/255, blue: 48/255, alpha: 1.0)
                            self.spinner.stopAnimating()
                            }, completion: nil)
                        
                    }
                })
        })
    }
    
    func removeMessage(index: Int) {
        UIView.animateWithDuration(0.33, animations: { () -> Void in
            self.status.centerX += self.view.width
            }) { _ in
                self.status.hidden = true
                self.status.centerX = self.view.width / 2
                
                self.showMessage(index + 1)
        }
    }
    
    func loginAction() {
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            var rect = self.login.frame
            rect.width += 80
            rect.centerX = self.login.frame.centerX
            self.login.frame = rect
            }, completion: { (done: Bool) -> Void in
                self.showMessage(0)
        })
        
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.login.centerY += 60
            self.login.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            }, completion: { (done: Bool) -> Void in
                self.spinner.hidden = false
                self.spinner.startAnimating()
        })
    }
    
    func animateCloud(cloud: UIView) {
        let x = -self.view.width * CGFloat(drand48()) - cloud.width
        let y = self.view.height * CGFloat(drand48()) * 0.6
        cloud.top = y
        cloud.left = x
        
        let duration = Double((self.view.width - x) / 60)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
            cloud.left = self.view.width
            }) { _ in
                self.animateCloud(cloud)
        }
        
    }
    
    func delay(seconds: CGFloat, action: (() -> Void)?) {
        let sec = seconds * CGFloat(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(sec))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            action?()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.4, options: [.CurveEaseInOut], animations: { () -> Void in
            self.heading.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations: { () -> Void in
            self.username.center.x += self.view.bounds.width
            }, completion: nil)

        UIView.animateWithDuration(0.5, delay: 0.6, options: [], animations: { () -> Void in
            self.password.center.x += self.view.bounds.width
            }, completion: nil)
        
        /*
        UIView.animateWithDuration(1.0, delay: 0.5, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.cloud1.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.7, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.cloud2.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(5.0, delay: 0.9, options: [.Repeat, .CurveLinear], animations: { () -> Void in
            self.cloud3.left = self.view.width
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 1.1, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.cloud4.alpha = 1.0
            }, completion: nil)
        */
    
        UIView.animateWithDuration(0.7, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            self.login.top = self.password.bottom + 20
            self.login.alpha = 1.0
            }, completion: nil)
        
        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
        animateCloud(cloud4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var heading : UILabel = {
        let label = UILabel()
        label.text = "Bahama Login"
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        return label
    }()
    
    lazy var username: UITextField = {
        let username = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        username.placeholder = "Username"
        username.backgroundColor = UIColor.whiteColor()
        username.layer.cornerRadius = 4.0
        username.clipsToBounds = true
        username.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        return username
    }()
    
    lazy var password: UITextField = {
        let password = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        password.placeholder = "Password"
        password.backgroundColor = UIColor.whiteColor()
        password.layer.cornerRadius = 4.0
        password.clipsToBounds = true
        password.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        return password
    }()

    lazy var login: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        button.setTitle("Log In", forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
        let titleColor = UIColor(red: 28/255, green: 99/255, blue: 28/255, alpha: 1.0)
        button.setTitleColor(titleColor, forState: .Normal)
        let color = UIColor(red: 61/255, green: 190/255, blue: 48/255, alpha: 1.0)
        button.backgroundColor = color
        button.layer.cornerRadius = 4.0
        button.clipsToBounds = true
        button.addTarget(self, action: "loginAction", forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var cloud1: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg-sunny-cloud-1"))
        return image
    }()
    
    lazy var cloud2: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg-sunny-cloud-2"))
        return image
    }()
    
    lazy var cloud3: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg-sunny-cloud-3"))
        return image
    }()
    
    lazy var cloud4: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg-sunny-cloud-4"))
        return image
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .White)
        return view
    }()
    
    let status = UIImageView(image: UIImage(named: "banner"))
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orangeColor()
        return label
    }()
    
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
}

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}

