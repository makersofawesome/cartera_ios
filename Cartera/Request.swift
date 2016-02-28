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
    /*
     * Pass in params to initialize
     * needs user, amount, and geocode
     */
    init(amount: Float, lat: Float, long: Float, requesterId: String){
        
        self.amount = amount
        self.latitude = lat
        self.longitude = long
        self.requesterId = requesterId
        
    }
    
    
    func postOpenRequest(withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Request")
        if requesterId != nil {
            //print("requester id \(requesterId)")
            post.setObject(requesterId!, forKey: "requesterId")
            post.setObject(amount!, forKey: "amount")
            post.setObject(latitude!, forKey: "latitude")
            post.setObject(longitude!, forKey: "longitude")
            post.saveInBackgroundWithBlock(completion)
        }
    }
    func requesterObject(completion: (PFObject) -> ()) {
        let query = PFQuery(className: "_User")
        query.getObjectInBackgroundWithId(requesterId!) { (object, error) -> Void in
            if error != nil && object != nil{
                completion(object!)
            } else {
                print(error)
            }
        }
    
    }
    func requester(completion: (User) -> ()){
        var userObject: PFObject?
         requesterObject{(object) -> () in
            completion(User(object: object))
        }
        
    }
    class func requestsWithArray(object: [PFObject]) -> [Request]{
        var requestList = [Request]()
        for x in object {
            requestList.append(Request(
                amount:        x["amount"] as! Float,
                lat:           x["latitude"] as! Float,
                long:          x["longitude"] as! Float,
                requesterId:   x["requesterId"] as! String))
        }
        return requestList
        
    }
    
}