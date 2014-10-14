//
//  UrlConnection.swift
//  RecentContest
//
//  Created by zhu peijun on 10/8/14.
//  Copyright (c) 2014 my. All rights reserved.
//

import UIKit

class UrlConnection: NSObject {
    var url: String
    
    init(url: String) {
        self.url = url
        super.init()
    }
    
    func getUrlData() -> NSData? {
        var request = NSURLRequest(URL: NSURL(string: url))
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var error: NSErrorPointer = nil
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)
        if(error == nil) {
            println("[ERROR] Can not get the data from the url.\(error)")
        }
        return data
    }
    
    func getJSONObject() -> NSDictionary? {
        var data = getUrlData()
        if (data != nil) {
            var error: NSErrorPointer = nil
            let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: error) as NSDictionary
            if(error == nil) {
                return jsonResult
            } else {
                println("[ERROR] Can not parse the JSON result to JSONObject. \(error)")
            }
        }
        return nil
    }
    
    func getJSONArray() -> NSArray? {
        var data = getUrlData()
        if (data != nil) {
            var error: NSErrorPointer = nil
            let jsonResult: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: error) as NSArray
            if(error == nil) {
                return jsonResult
            } else {
                println("[ERROR] Can not parse the JSON result to JSONArray. \(error)")
            }
        }
        return nil
    }
    
    func getJSONObjectAsync(callback: NSDictionary? -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var object = self.getJSONObject()
            dispatch_async(dispatch_get_main_queue(), {
                callback(object)
            })
        })
    }
    
    func getJSONArrayAsync(callback: NSArray? -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var array = self.getJSONArray()
            dispatch_async(dispatch_get_main_queue(), {
                callback(array)
            })
        })
    }
}
