//
//  Request.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class Request: NSObject {
    
    var requesterId: String?
    var amount: Float?
    var latitude: Float?
    var longitude: Float?
    var createdAt: NSDate?
    /*
     * Pass in params to initialize
     * needs user, amount, and geocode
     */
    init(amount: Float, lat: Float, long: Float, requesterId: String, timestamp: String){
        
        self.amount = amount
        self.latitude = lat
        self.longitude = long
        self.requesterId = requesterId
        let formatter = NSDateFormatter()
        //"2016-02-28T07:42:50.075Z"
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        let date = formatter.dateFromString(timestamp)
        self.createdAt = date
    
    }
    init(amount: Float, lat: Float, long: Float, requesterId: String, time: NSDate){
        self.amount = amount
        self.latitude = lat
        self.longitude = long
        self.requesterId = requesterId
        self.createdAt = time
    }
    init(amount: Float, lat: Float, long: Float, requesterId: String){
        
        self.amount = amount
        self.latitude = lat
        self.longitude = long
        self.requesterId = requesterId
    }
    func postOpenRequest(withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Request")
        if requesterId != nil {
            post.setObject(requesterId!, forKey: "requesterId")
            post.setObject(amount!, forKey: "amount")
            post.setObject(latitude!, forKey: "latitude")
            post.setObject(longitude!, forKey: "longitude")
            post.saveInBackgroundWithBlock(completion)
        }
    }
    class func requestsWithArray(object: [PFObject]) -> [Request]{
        var requestList = [Request]()
        for x in object {
           // print(x)
            requestList.append(Request(
                amount:        x["amount"] as! Float,
                lat:           x["latitude"] as! Float,
                long:          x["longitude"] as! Float,
                requesterId:   x["requesterId"] as! String,
                time:          x.createdAt!))
        }
        return requestList
        
    }
    
}