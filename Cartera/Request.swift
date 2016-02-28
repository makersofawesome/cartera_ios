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
        for x in object {
            let query = PFQuery(className:"_User")
            query.whereKey("_id", equalTo: x["requesterId"])
            query.getObjectInBackgroundWithId(x["requesterId"] as! String) { (user: PFObject?, error: NSError?) -> Void in
                if user != nil {
                    requestList.append(Request(
                        amount: x["amount"] as! Int,
                        lat: x["latitude"] as! Float,
                        long: x["longitude"] as! Float,
                        user: User(username: user!["username"] as! String,
                            id: (user?.objectId)!)))
                }
                else {
                    print(error?.localizedDescription)
                }
            }
        }
         return requestList
    }
   
}



