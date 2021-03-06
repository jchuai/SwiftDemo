//: Playground - noun: a place where people can play

import UIKit
import Foundation

let calendar = NSCalendar.currentCalendar()
var today = calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate(timeIntervalSinceNow: 0), options: [])!

calendar.dateByAddingUnit(.Month, value: -1, toDate: today, options: [])

calendar.component(.Weekday, fromDate: today) - 2

calendar.startOfDayForDate(NSDate())

let time : NSTimeInterval = 123400
let formatter = NSDateComponentsFormatter()
formatter.allowedUnits = [.Hour, .Minute, .Second]
formatter.zeroFormattingBehavior = .Pad
formatter.stringFromTimeInterval(time)


NSDate(timeIntervalSinceNow: 12340)
