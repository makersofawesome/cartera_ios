//
//  MainViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

var locationManager: CLLocationManager!
let reloadNotification = "reloadNotification"

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var locationManager: CLLocationManager!
    var lastLocation : CLLocationCoordinate2D!
    var users: [User]?
    var requests: [Request]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        self.navigationItem.setHidesBackButton(true, animated:false)
        tableView.delegate = self
        tableView.dataSource = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        loadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableView", name: reloadNotification, object: nil)
    }
    func loadData() {
        var query = PFQuery(className: "Request")
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.requests = Request.requestsWithArray(media)
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
    
    func reloadTableView() {
        print("reloading data")
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = requests {
            print(data.count)
            return data.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Main Cell", forIndexPath: indexPath) as! MainCell
        let request = requests![indexPath.row]
        cell.request = request
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeSegue" {
            let vc = segue.destinationViewController as! ComposeRequestViewController
            vc.location = lastLocation
            
        }
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations.first! as CLLocation
        lastLocation = location.coordinate
    }
    
    
    @IBAction func logOutButton(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
    }
    
    
    
}
