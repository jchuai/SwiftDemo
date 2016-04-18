//
//  RefreshView.swift
//  PullToRefresh
//
//  Created by Junna on 3/15/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import UIKit

protocol RefreshViewDelegate: class {
    func startRefreshing()
}

class RefreshView: UIView, UIScrollViewDelegate {
    
    weak var delegate: RefreshViewDelegate?
    
    private let baseImageLayer  : CALayer = CALayer()
    private let maskLayer       : CAShapeLayer = CAShapeLayer()
    private var process         : CGFloat = 0.0
    private var isRefreshing    : Bool = false
    private let scrollView      : UIScrollView
    
    init(frame: CGRect, imageName: String, scrollView: UIScrollView) {
        
        self.scrollView = scrollView
        
        super.init(frame: frame)
        
        self.scrollView.delegate = self
        
        let image = UIImage(named: imageName)
        let size  = image?.size ?? CGSize(width: 20, height: 20)
        baseImageLayer.contents = image?.CGImage
        baseImageLayer.frame = CGRect(origin: CGPointZero, size: size)
        baseImageLayer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        let maskWidth = size.width / 2 * 0.2
        let radius = size.width / 2 - maskWidth / 2
        maskLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: radius, height: radius)).CGPath
        maskLayer.strokeColor = UIColor.whiteColor().CGColor
        baseImageLayer.mask = maskLayer
        
//        layer.addSublayer(baseImageLayer)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offSetY = max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0)
        process = max(offSetY / self.bounds.height, 0.0)
        if !isRefreshing {
            redrawFromProcess(process)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startRefreshing()
    }
    
    func redrawFromProcess(process: CGFloat) {
        if process <= 1.0 {
            maskLayer.strokeEnd = process
        } else {
            let transform = CATransform3DIdentity
            
            baseImageLayer.transform = CATransform3DRotate(transform, CGFloat(M_PI * 2.0) * (process - 1), 0, 0, 1)
        }
    }
    
    func startRefreshing() {
        isRefreshing = true
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            var newInsets = self.scrollView.contentInset
            newInsets.top += self.bounds.height
            self.scrollView.contentInset = newInsets
            }, completion: nil)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = M_PI * 2.0
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = .infinity
        baseImageLayer.addAnimation(rotationAnimation, forKey: "rotate")
        delegate?.startRefreshing()
    }
    
    func endRefreshing() {
        isRefreshing = false
        baseImageLayer.removeAnimationForKey("rotate")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            var newInsets = self.scrollView.contentInset
            newInsets.top -= self.bounds.height
            self.scrollView.contentInset = newInsets
            }, completion: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
