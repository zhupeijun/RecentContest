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
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        let error: NSErrorPointer = nil
        var data: NSData?
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
        } catch let error1 as NSError {
            error.memory = error1
            data = nil
        }
        if(error != nil) {
            print("[ERROR] Can not get the data from the url.\(error)")
        }
        return data
    }
    
    func getJSONObject() -> NSDictionary? {
        let data = getUrlData()
        if (data != nil) {
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                return jsonResult
            } catch {
                print("[ERROR] Can not parse the JSON result to JSONObject.")
            }
        }
        return nil
    }
    
    func getJSONArray() -> NSArray? {
        let data = getUrlData()
        if (data != nil) {
            do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                return jsonResult
            } catch {
                print("[ERROR] Can not parse the JSON result to JSONArray.")
            }
        }
        return nil
    }
    
    func getJSONObjectAsync(callback: NSDictionary? -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let object = self.getJSONObject()
            dispatch_async(dispatch_get_main_queue(), {
                callback(object)
            })
        })
    }
    
    func getJSONArrayAsync(callback: NSArray? -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let array = self.getJSONArray()
            dispatch_async(dispatch_get_main_queue(), {
                callback(array)
            })
        })
    }
}
