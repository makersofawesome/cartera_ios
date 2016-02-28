//
//  User.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse

var _currentUser: User?
class User: NSObject {

    var username: String?
    var id: String?
    var firstName: String?
    var lastName: String?
    var accountId: String?
    
    
    init(object: PFObject) {
        username = object["username"] as? String
        id = object.objectId
        accountId = object["account_id"] as? String
    }
    init (username: String, id: String, account: String) {
        self.username = username
        self.id = id
        accountId = account
    }
    init (id: String) {
        super.init()
        self.id = id
        let query = PFQuery(className: "_User")
        do {
            let object = try query.getObjectWithId(id)
            self.username = object["username"] as! String
            self.accountId = object["account_id"] as! String
        } catch {
            print("error querying for user")
        }
        
    }
    class func usersWithArray(users: [PFObject]) -> [User] { // calls function, gets info, without making actual user objects
        var usersList = [User]()
        
        for user in users {
            usersList.append(User(object: user))
        }
        return usersList
    }

}
