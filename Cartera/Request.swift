//
//  Request.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse

class Request: NSObject {
    
    var user: User!
    
    init(user: User){
        self.user = user
    }
    
    class func requestsWithArray(users: [User]) -> [Request] {
        var requestList = [Request]()
        
        for user in users {
            requestList.append(Request(user: user))
        }
        return requestList
    }

    
}
