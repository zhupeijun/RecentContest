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
    var contest: Contest? = nil
    var refreshControl: UIRefreshControl?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentWeekLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        loadContestInformation()
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "localNotificationUpdate:", name: kLocalNotificationUpdate, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let contest = contests[row] as! Contest
        let cell = tableView.dequeueReusableCellWithIdentifier("ConestInfoRow")!
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        nameLabel.text = contest.name
        
        let timeLabel = cell.viewWithTag(1002) as! UILabel
        timeLabel.text = contest.startTime
        
        let ojLabel = cell.viewWithTag(1003) as! UILabel
        ojLabel.text = contest.oj
        
        let accessLabel = cell.viewWithTag(1004) as! UILabel
        accessLabel.text = contest.access
        
        let weekLabel = cell.viewWithTag(1005) as! UILabel
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
        let connection = UrlConnection(url: url)
        connection.getJSONArrayAsync({ result in
            if(result != nil) {
                let array = result!
                let n = array.count
                self.contests.removeAllObjects()
                for i in 0..<n {
                    let contest = Contest(dic: array[i] as! NSDictionary)
                    self.contests.addObject(contest)
                }
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender:sender)
        if(segue.identifier == ShowDetailSegureIdentifier) {
            let detailVC = segue.destinationViewController as! DetailViewController
            if(self.contest == nil) {
                detailVC.contest = contests[self.selectedRow] as? Contest
            } else {
                detailVC.contest = self.contest
                self.contest = nil
            }
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
        
        
        
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let dateComponents = calendar.components(NSCalendarUnit.Weekday, fromDate: today)
        let weekDay = dateComponents.weekday
        
        let weekName = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        let weekString = weekName[weekDay - 1]
        
        self.currentTimeLabel.text = dateString
        self.currentWeekLabel.text = weekString
    }
    
    func localNotificationUpdate(notification: NSNotification) {
        let userInfo = notification.object as! NSDictionary?
        if(userInfo != nil) {
            self.contest = Contest(dic: userInfo!)
            self.performSegueWithIdentifier(ShowDetailSegureIdentifier, sender: self)
        }
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func refreshTableView() {
        loadContestInformation()
    }
}
