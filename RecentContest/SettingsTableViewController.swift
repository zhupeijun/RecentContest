//
//  SettingsTableViewController.swift
//  RecentContest
//
//  Created by zhu peijun on 10/27/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        var currentNotificationTime = NotificationTime.getNotificationTime()
        var timeText = TimeString.toString(currentNotificationTime)
        timeLabel.text = timeText
        
        // Setup version number
        var versionName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as NSString
        versionLabel.text = versionName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
