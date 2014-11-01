//
//  TimeString.swift
//  RecentContest
//
//  Created by zhu peijun on 11/1/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class TimeString: NSObject {
    class func toString(minutes: NSInteger) -> NSString {
        var hours = minutes / 60
        var minutes = minutes - hours * 60
        var result = ""
        if(hours != 0) {
            result += "\(hours) Hour"
            if(hours > 1) {
                result += "s"
            }
        }
        if(minutes != 0 || (hours == 0 && minutes == 0)) {
            if(hours != 0) {
                result += " "
            }
            result += "\(minutes) Minute"
            if (minutes > 1) {
                result += "s"
            }
        }
        return result
    }
}
