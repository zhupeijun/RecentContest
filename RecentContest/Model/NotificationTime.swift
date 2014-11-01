//
//  NotificationTime.swift
//  RecentContest
//
//  Created by zhu peijun on 11/1/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

let kUserDefaultNotificationTime = "NotificationTime"

class NotificationTime: NSObject {
    class func getNotificationTime() -> NSInteger {
        return NSUserDefaults.standardUserDefaults().integerForKey(kUserDefaultNotificationTime)
    }
    
    class func setNotificationTime(minutes: NSInteger) {
        NSUserDefaults.standardUserDefaults().setInteger(minutes, forKey: kUserDefaultNotificationTime)
    }
}
