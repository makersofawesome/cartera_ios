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
        loadUsers()
    }
    func loadUsers() {
        var query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.users = User.usersWithArray(media)
                self.requests = Request.requestsWithArray(self.users!)
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
        if let data = requests {
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "composeSegue" {
//            print("modal segue activated")
////            let compose = ComposeRequestViewController()
////            compose.composeView.backgroundColor = UIColor(red: 63, green: 81, blue: 181, alpha: 255)
//        }
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeSegue" {
            print("modal segue activated")
        }
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("change authorization satuttas")
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            print("change authorization satuttas")
            manager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations.first! as CLLocation
        lastLocation = location.coordinate
        print(lastLocation)
    }
}
