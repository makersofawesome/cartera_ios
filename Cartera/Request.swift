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
    
    var requester: User!
    var amount: Int?
    var latitude: Float?
    var longitude: Float?
    var id: Int?
    
    /*
     * Pass in params to initialize
     * needs user, amount, and geocode
     */
    init(amount: Int, lat: Float, long: Float, user: User){
        
        self.amount = amount
        self.latitude = lat
        self.longitude = long
        self.requester = user
        
    }
    
    func postOpenRequest(withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Request")
        if requester != nil {
            print("requester id \(requester.id)")
            post.setObject(requester.id!, forKey: "requesterId")
            post.setObject(amount!, forKey: "amount")
            post.setObject(latitude!, forKey: "latitude")
            post.setObject(longitude!, forKey: "longitude")
            post.saveInBackgroundWithBlock(completion)
        }
    }
    
    class func requestsWithArray(object: [PFObject]) -> [Request] {
        var requestList = [Request]()
        var requester: User?
        var length = object.count, count = 0;
        print("length = \(length)")
        for x in object {
            var query = PFQuery(className:"_User")
            do {
            let user = try query.getObjectWithId(x["requesterId"] as! String)
            requester = User(object: user)
            requestList.append(Request(
                amount: x["amount"] as! Int,
                lat: x["latitude"] as! Float,
                long: x["longitude"] as! Float,
                user: requester as! User!))
            } catch let error as NSError {
                print("error populating data \(error)")
            }            /* query.getObjectInBackgroundWithId(x["requesterId"] as! String) {
            (user: PFObject?, error: NSError?) -> Void in
            if error == nil && user != nil {
            requester = User(object: user!)
            requestList.append(Request(
            amount: x["amount"] as! Int,
            lat: lat,
            long: long,
            user: requester as! User!))
            print("count = \(count)")
            
            NSNotificationCenter.defaultCenter().postNotificationName(reloadNotification, object: nil)
            
            } else {
            print("\(error)")
            }
            }
            count++
            */
        }
        return requestList
    }
    
    
}
