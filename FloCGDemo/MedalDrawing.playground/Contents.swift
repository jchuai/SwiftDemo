//: Playground - noun: a place where people can play

import UIKit

let size = CGSize(width: 120, height: 200)
let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)

let beltWidth   : CGFloat = 40
let beltHeight  : CGFloat = 70
let beltSlope   : CGFloat = 38

let radius : CGFloat = 50
let roundX : CGFloat = beltSlope + beltWidth/2 - radius
let roundY : CGFloat = beltHeight + 10

UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
let context = UIGraphicsGetCurrentContext()

let path1 = UIBezierPath()
path1.moveToPoint(CGPoint(x: 0, y: 0))
path1.addLineToPoint(CGPoint(x: beltWidth, y: 0))
path1.addLineToPoint(CGPoint(x: beltSlope + beltWidth, y: beltHeight))
path1.addLineToPoint(CGPoint(x: beltSlope, y: beltHeight))
path1.closePath()
UIColor.redColor().setFill()
path1.fill()


let path2 = UIBezierPath(ovalInRect: CGRect(x: roundX, y: roundY, width: radius * 2, height: radius * 2))
let colors = [darkGoldColor.CGColor, midGoldColor.CGColor, lightGoldColor.CGColor]
let space = CGColorSpaceCreateDeviceRGB()
let stops : [CGFloat] = [0.0, 1.0]
let gradient = CGGradientCreateWithColors(space, colors, stops)
CGContextDrawLinearGradient(context, gradient, CGPoint(x: roundX, y: roundY), CGPoint(x: roundX + 50, y: roundY + radius * 2), .DrawsBeforeStartLocation)



let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()