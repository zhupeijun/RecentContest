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
        let currentNotificationTime = NotificationTime.getNotificationTime()
        let timeText = TimeString.toString(currentNotificationTime)
        timeLabel.text = timeText as String
        
        // Setup version number
        let versionName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
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
        
        let section = indexPath.section
        let row = indexPath.row
        if(section == 1 && row == 1) { // Review the app
            UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/app/id887773275")!)
        }
    }
}
