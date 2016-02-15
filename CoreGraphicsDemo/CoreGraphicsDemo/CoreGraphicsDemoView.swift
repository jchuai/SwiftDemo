//
//  CoreGraphicsDemo.swift
//  CoreGraphicsDemo
//
//  Created by Junna on 2/14/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import UIKit

class DemoView: UIView {
    internal weak var context: CGContextRef?
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0)
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(context, rect)
        CGContextStrokeRect(context, rect)
    }
    
    func saveState(drawContext: () -> ()) {
        CGContextSaveGState(context)
        drawContext()
        CGContextRestoreGState(context)
    }
}

class EllipseDemoView: DemoView {
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawEllipse(rect)
    }
    
    func drawEllipse(rect: CGRect) {
        saveState { [weak self]() -> () in
            let innerRect = CGRectInset(rect, 20, 20)
            CGContextSetRGBFillColor(self?.context, 0.0, 1.0, 0.0, 1.0)
            CGContextFillEllipseInRect(self?.context, innerRect)
            CGContextSetRGBStrokeColor(self?.context, 0.0, 0.0, 1.0, 1.0)
            CGContextSetLineWidth(self?.context, 6.0)
            CGContextStrokeEllipseInRect(self?.context, innerRect)
        }
    }
}

class LineDemoView: DemoView {
    private var dash : [CGFloat] = [12.0, 8.0, 6.0, 14.0, 16.0, 7.0]
    private var points: [CGPoint] = []
    private var point : (CGFloat, CGFloat)?
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if point == nil {
            point = (rect.width / 2, rect.height / 2)
        }
        points = [(0,rect.height / 2),  point!, (rect.width, rect.height / 2), (0,rect.height / 2)].map({ (x, y) -> CGPoint in
            return CGPointMake(x, y)
        })
        
        saveState { [weak self]() -> () in
            if let strongSelf = self {
                CGContextSetRGBStrokeColor(strongSelf.context, 0.0, 0.0, 1.0, 1.0)
                CGContextSetLineWidth(strongSelf.context, 6.0)
                CGContextSetLineDash(strongSelf.context, 0.0, strongSelf.dash, strongSelf.points.count)
                let path = CGPathCreateMutable()
                CGPathAddLines(path, nil, strongSelf.points, strongSelf.points.count)
                CGPathCloseSubpath(path)
                CGContextAddPath(strongSelf.context, path)
                CGContextStrokePath(strongSelf.context)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let p = touches.first!.locationInView(self)
        point = (p.x, p.y)
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        let p = touches.first!.locationInView(self)
        point = (p.x, p.y)
        setNeedsDisplay()
    }
}

