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
    
    class func createWithDictionary(var dic: NSDictionary) -> Contest {
        var contest = Contest()
        contest.access = dic["access"] as String
        contest.id = dic["id"] as String
        contest.link = dic["link"] as String
        contest.name = dic["name"] as String
        contest.oj = dic["oj"] as String
        contest.startTime = dic["start_time"] as String
        contest.week = dic["week"] as String
        if(contest.access == "") {
            contest.access = "Public"
        }
        return contest
    }
}
