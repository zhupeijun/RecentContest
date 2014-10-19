//
//  HomeViewController.swift
//  RecentContest
//
//  Created by zhu peijun on 9/7/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ShowDetailSegureIdentifier = "ShowContestDetail"
    let url = "http://contests.acmicpc.info/contests.json"
    var contests: NSMutableArray = []
    var selectedRow = -1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentWeekLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContestInformation()
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var row = indexPath.row
        var contest = contests[row] as Contest
        var cell = tableView.dequeueReusableCellWithIdentifier("ConestInfoRow") as UITableViewCell
        
        
        var nameLabel = cell.viewWithTag(1001) as UILabel
        nameLabel.text = contest.name
        
        var timeLabel = cell.viewWithTag(1002) as UILabel
        timeLabel.text = contest.startTime
        
        var ojLabel = cell.viewWithTag(1003) as UILabel
        ojLabel.text = contest.oj
        
        var accessLabel = cell.viewWithTag(1004) as UILabel
        accessLabel.text = contest.access
        
        var weekLabel = cell.viewWithTag(1005) as UILabel
        weekLabel.text = contest.week
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contests.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath.row
        self.performSegueWithIdentifier(ShowDetailSegureIdentifier, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func loadContestInformation() {
        var connection = UrlConnection(url: url)
        connection.getJSONArrayAsync({ result in
            if(result != nil) {
                let array = result!
                let n = array.count
                self.contests.removeAllObjects()
                for i in 0..<n {
                    var contest = Contest.createWithDictionary(array[i] as NSDictionary)
                    self.contests.addObject(contest)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender:sender)
        if(segue.identifier == ShowDetailSegureIdentifier) {
            var detailVC = segue.destinationViewController as DetailViewController
            detailVC.contest = contests[self.selectedRow] as? Contest
        }
    }
    
    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(0.5,
            target: self,
            selector: "refreshTimeLabel",
            userInfo: nil,
            repeats: true)
    }
    
    func refreshTimeLabel () {
        let today = NSDate()
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let dateString = dateFormater.stringFromDate(today)
        
        
        
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let dateComponents = calendar.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: today)
        let weekDay = dateComponents.weekday
        
        let weekName = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SAN"]
        let weekString = weekName[weekDay - 1]
        
        self.currentTimeLabel.text = dateString
        self.currentWeekLabel.text = weekString
    }
}
