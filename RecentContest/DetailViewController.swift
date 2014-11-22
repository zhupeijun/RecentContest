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
    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var gotoWebPageButton: UIButton!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var notifyTextLabel: UILabel!
    @IBOutlet weak var promoteTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gotoWebPageButton.layer.cornerRadius = 5
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
            let link = contest!.link
            if(link != "") {
                UIApplication.sharedApplication().openURL(NSURL(string: contest!.link)!)
            }
        }
    }
    @IBAction func enableNotification(sender: AnyObject) {
        if(switcher.on == true) {
            if(!scheduleNotification()) {
                switcher.on = false
            }
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
            
            let startTime = contest!.getStartDateTime()
            if(startTime != nil) {
                var current = NSDate()
                var interval = Int(startTime!.timeIntervalSinceDate(current))
                var days = 0
                var hours = 0
                var minutes = 0
                
                let notificationTime = NotificationTime.getNotificationTime() * 60
                if (interval < notificationTime) {
                    // if the contes tis expired or less then the notification time,
                    // then disable the notification switcher
                    disableSwitcher()
                }
                
                if (interval > 0) {
                    days = interval / 86400
                    interval = interval - days * 86400
                    hours = interval / 3600
                    interval = interval - hours * 3600
                    minutes = interval / 60
                }
                
                self.daysLabel.text = String(days)
                self.hoursLabel.text = String(hours)
                self.minutesLabel.text = String(minutes)
            }
        }
    }
    
    func scheduleNotification() -> Bool {
        if(contest != nil) {
            let startDateTime = contest!.getStartDateTime()
            if(startDateTime != nil) {
                var delay = NotificationTime.getNotificationTime() * -60
                startDateTime!.dateByAddingTimeInterval(NSTimeInterval(delay))
                var current = NSDate()
                if(startDateTime!.timeIntervalSinceDate(current) > 0) {
                    var notification = UILocalNotification()
                    notification.fireDate = startDateTime
                    notification.timeZone = NSTimeZone.localTimeZone()
                    notification.alertBody = contest!.name
                    notification.alertAction = "Open"
                    notification.soundName = UILocalNotificationDefaultSoundName
                    notification.userInfo = contest!.toUserInfo()
                    println(notification.userInfo)
                    UIApplication.sharedApplication().scheduleLocalNotification(notification)
                    return true
                }
            }
        }
        return false
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
    
    func disableSwitcher() {
        switcher.enabled = false
        switcher.alpha = 0.2
        notifyTextLabel.alpha = 0.2
        promoteTextLabel.alpha = 0.2
        daysView.alpha = 0.2
        hoursView.alpha = 0.2
        minutesView.alpha = 0.2
    }
}
