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
    
    /*
     * Pass in params to initialize
     * needs user, amount, and geocode
     */
    init(params: NSDictionary){
        self.requester = params["user"] as! User
        self.amount = params["amount"] as! Int
        self.latitude = params["latitude"] as! Float
        self.longitude = params["longitude"] as! Float
        
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
    
    class func requestsWithArray(users: [User]) -> [Request] {
        var requestList = [Request]()
        
        for user in users {
            let params = ["user":user, "amount":1, "latitude":1, "longitude":1]
            requestList.append(Request(params: params))
        }
        return requestList
    }

    
}
