//
//  DetailViewController.swift
//  RecentContest
//
//  Created by zhu peijun on 10/19/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contest: Contest? = nil

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ojLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var switcher: NSLayoutConstraint!
    @IBOutlet weak var gotoWebPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysView.layer.cornerRadius = 10
        hoursView.layer.cornerRadius = 10
        minutesView.layer.cornerRadius = 10
        
        if(contest != nil) {
            titleLabel.text = contest!.name
            ojLabel.text = contest!.oj
            accessLabel.text = contest!.access
            
            var dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var startTime = dateFormater.dateFromString(contest!.startTime)
            
            if(startTime != nil) {
                var current = NSDate()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
