/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import QuartzCore

@IBDesignable

class AnimatedMaskLabel: UIView {
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            UIColor.blackColor().CGColor,
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        gradientLayer.colors = colors
        let locations = [
            0.1, 0.25, 0.4, 0.55, 0.7, 0.85
        ]
        gradientLayer.locations = locations
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: self.bounds.origin.y, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        return gradientLayer
    }()
    
    @IBInspectable var text: String! {
        didSet {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            let context = UIGraphicsGetCurrentContext()
            (text as NSString).drawInRect(bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let maskLayer = CALayer()
            maskLayer.opacity = 1
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            gradientLayer.mask = maskLayer
        }
    }
    
    lazy var textAttributes: [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Center

        return [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!, NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: UIColor.yellowColor()]
    }()
    
    
    override func layoutSubviews() {
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
    }
    
}