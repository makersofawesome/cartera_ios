//
//  User.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {

    var username: String?
    var id: String?
    
    init(object: PFObject){
        username = object["username"] as? String
        id = object["_id"] as? String
    }
    class func usersWithArray(array: [PFObject]) -> [User] {
        var users = [User]()
        
        for obj in array {
            users.append(User(object: obj))
        }
        return users
    }
}
