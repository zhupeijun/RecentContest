//
//  TimeSelectTableViewController.swift
//  RecentContest
//
//  Created by zhu peijun on 10/28/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

let kTimeCell = "TimeCell"

class TimeSelectTableViewController: UITableViewController {
    
    // Time in minutes
    let times = [0, 15, 30, 45, 60, 120, 180, 240, 300]
    var currentTimeValue = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        currentTimeValue = NotificationTime.getNotificationTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let kTimeTextViewTag = 1001
        let kCheckIconViewTag = 1002
        
        let row = indexPath.row
        
        var minutes = times[row]
        var timeText = TimeString.toString(minutes)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kTimeCell) as UITableViewCell
        
        var timeTextView = cell.viewWithTag(kTimeTextViewTag) as UILabel?
        timeTextView?.text = timeText
        
        var checkView = cell.viewWithTag(kCheckIconViewTag) as UIImageView?
        checkView?.hidden = !(currentTimeValue == times[row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row
        var minutes = times[row]
        NotificationTime.setNotificationTime(minutes)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
