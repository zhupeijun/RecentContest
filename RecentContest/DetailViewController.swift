//
//  DetailViewController.swift
//  RecentContest
//
//  Created by zhu peijun on 10/19/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let kNotificationIdKey = "kNotificationIdKey"
    var contest: Contest? = nil
    var isFromLocalNotification: Bool = false

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ojLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var gotoWebPageButton: UIButton!
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysView.layer.cornerRadius = 10
        hoursView.layer.cornerRadius = 10
        minutesView.layer.cornerRadius = 10
        
        updateContestInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "localNotificationUpdate:", name: kLocalNotificationUpdate, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func openOfficialSite(sender: UIButton) {
        if(contest != nil) {
            UIApplication.sharedApplication().openURL(NSURL(string: contest!.link)!)
        }
    }
    @IBAction func enableNotification(sender: AnyObject) {
        if(switcher.on == true) {
            scheduleNotification()
        } else {
            cancelNotification()
        }
    }
    
    func localNotificationUpdate(notification: NSNotification) {
        let userInfo = notification.object as NSDictionary?
        if(userInfo != nil) {
            contest = Contest(dic: userInfo!)
            updateContestInfo()
        }
    }
    
    func updateContestInfo() {
        if(contest != nil) {
            titleLabel.text = contest!.name
            ojLabel.text = contest!.oj
            accessLabel.text = contest!.access
            
            var dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var startTime = dateFormater.dateFromString(contest!.startTime)
            
            if(startTime != nil) {
                var current = NSDate()
                //Fix me: when the contest is expired.
                var interval = UInt(startTime!.timeIntervalSinceDate(current))
                var days = interval / 86400
                interval = interval - days * 86400
                var hours = interval / 3600
                interval = interval - hours * 3600
                var minutes = interval / 60
                
                self.daysLabel.text = String(days)
                self.hoursLabel.text = String(hours)
                self.minutesLabel.text = String(minutes)
            }
        }
    }
    
    func scheduleNotification() {
        if(contest != nil) {
            var notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 10)
            notification.timeZone = NSTimeZone.localTimeZone()
            notification.alertBody = contest!.name
            notification.alertAction = "Open"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = contest!.toUserInfo()
            println(notification.userInfo)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func cancelNotification() {
        let notifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for item in notifications {
            let notification = item as UILocalNotification
            let userInfo = notification.userInfo
            if(userInfo != nil) {
                let contest = Contest(dic: userInfo!)
                if(self.contest != nil && self.contest!.id == contest.id) {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                }
            }
        }
    }
}
