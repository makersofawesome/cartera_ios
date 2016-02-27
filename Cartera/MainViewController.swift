//
//  MainViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var users: [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        tableView.delegate = self
        tableView.dataSource = self
        //loadUsers()
    }
    func loadUsers() {
        var query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.users = User.usersWithArray(media)
                self.tableView.reloadData()
            } else {
                // handle error
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = users {
            return data.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Main Cell", forIndexPath: indexPath) as! MainCell
        

        return cell
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        Client.sharedClient.createTransferWithParams("56c66be6a73e492741507e0b")
       // Client.sharedClient.getTransfersFromAccountId("56c66be6a73e492741507e0a")
    }

}
