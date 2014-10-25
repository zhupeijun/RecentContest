//
//  Contest.swift
//  RecentContest
//
//  Created by zhu peijun on 10/15/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit


class Contest: NSObject {
    
    var access: String = ""
    var id: String = ""
    var link: String = ""
    var name: String = ""
    var oj: String = ""
    var startTime: String = ""
    var week: String = ""
    
    override init() {
        super.init()
    }

    init (dic: NSDictionary) {
        access = dic[kAccess] as String
        id = dic[kId] as String
        link = dic[kLink] as String
        name = dic[kName] as String
        oj = dic[kOj] as String
        startTime = dic[kStartTime] as String
        week = dic[kWeek] as String
        if(access == "") {
            access = "Public"
        }
    }
    
    func toUserInfo() -> NSDictionary {
        var userInfo = NSMutableDictionary()
        userInfo.setValue(access, forKey: kAccess)
        userInfo.setValue(id, forKey: kId)
        userInfo.setValue(link, forKey: kLink)
        userInfo.setValue(name, forKey: kName)
        userInfo.setValue(oj, forKey: kOj)
        userInfo.setValue(startTime, forKey: kStartTime)
        userInfo.setValue(week, forKey: kWeek)
        return userInfo
    }
}

let kAccess = "access"
let kId = "id"
let kLink = "link"
let kName = "name"
let kOj = "oj"
let kStartTime = "start_time"
let kWeek = "week"
