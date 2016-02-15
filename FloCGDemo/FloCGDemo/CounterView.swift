//
//  CounterView.swift
//  FloCGDemo
//
//  Created by Junna on 2/15/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import Foundation
import UIKit

class CounterView: UIView {
    
    var counter : Int {
        didSet {
            if counter > maxCount {
                counter = maxCount
                return
            }
            
            if counter < 0 {
                counter = 0
                return
            }
            
            label.text = "\(counter)"
            var plusAngel = CGFloat(counter) * 1.5 * PI / 8
            plusAngel = plusAngel < minAngel ? minAngel : plusAngel
            outlineEndAngle = outlineStartAngle + plusAngel
            setNeedsDisplay()
        }
    }
    
    private let maxCount: Int = 8
    private let minAngel: CGFloat = 0.01
    private let PI : CGFloat = CGFloat(M_PI)
    private let arcColor = UIColor(red: 69.0/255, green: 169.0/255, blue: 165.0/255, alpha: 1.0)
    private let outlineColor = UIColor(red: 34.0/255, green: 110.0/255, blue: 100.0/255, alpha: 1.0)
    
    private var outlineStartAngle : CGFloat
    private var outlineEndAngle : CGFloat
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let center = rect.center
        let radius = min(rect.width, rect.height) / 2
        let arcWidth: CGFloat = 76
        let startAngle : CGFloat = 3 * PI / 4
        let endAngle : CGFloat = PI / 4
        let arcPath = UIBezierPath(arcCenter: center, radius: radius - arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        arcPath.lineWidth = arcWidth
        arcColor.setStroke()
        arcPath.stroke()
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - 2.5, startAngle: outlineStartAngle, endAngle: outlineEndAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: radius - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: outlineStartAngle, clockwise: false)
        outlinePath.lineWidth = 5.0
        outlinePath.closePath()
        outlineColor.setStroke()
        outlinePath.stroke()
    }
    
    override init(frame: CGRect) {
        counter = 0
        outlineStartAngle = 3 * PI / 4
        outlineEndAngle = outlineStartAngle + minAngel
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.center = CGPointMake(self.width / 2, self.height / 2)
    }
    
    lazy var label : UILabel = {
        let label = UILabel(frame: CGRectMake(0, 0, 44, 44))
        label.font = UIFont.systemFontOfSize(18)
        label.textAlignment = .Center
        label.text = "0"
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}