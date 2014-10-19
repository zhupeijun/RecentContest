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

    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var tipView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysView.layer.cornerRadius = 10
        hoursView.layer.cornerRadius = 10
        minutesView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideBarValueChanged(sender: AnyObject) {
        var sliderBar = sender as UISlider
        var width = sliderBar.frame.size.width
        var percent = CGFloat(((sliderBar.value - sliderBar.minimumValue) / (sliderBar.maximumValue - sliderBar.minimumValue)))
        var x = width * percent + sliderBar.frame.origin.x
        var y = sliderBar.frame.origin.y + 50
        
        tipView.frame.origin = CGPointMake(x, y)
    }
}
