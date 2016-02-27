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
    class func usersWithArray(users: [PFObject]) -> [User] { // calls function, gets info, without making actual user objects
        var usersList = [User]()
        
        for user in users {
            usersList.append(User(object: user))
        }
        return usersList
    }
}
