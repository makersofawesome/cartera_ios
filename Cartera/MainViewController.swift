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


var lastLocation : CLLocationCoordinate2D!
class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var locationManager: CLLocationManager!
    var users: [User]?
    var requests: [Request]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        //self.navigationItem.setHidesBackButton(true, animated:false)
        //self.navigationItem.backBarButtonItem?.image = UIImage(named: "log out temp")
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        loadData()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadData()
    }
    func loadData() {
        if (lastLocation != nil){
            let currentLat = lastLocation.latitude
            let currentLong = lastLocation.longitude
            let maxLat = currentLat + 0.7//(360*5)/(24901*cos(currentLat))
            let minLat = currentLat - 0.7//(360*5)/(24901*cos(currentLat))
            let maxLong = currentLong + 0.7//(360*5)/(24901*sin(currentLong))
            let minLong = currentLong - 0.7//(360*5)/(24901*sin(currentLong))
            let query = PFQuery(className: "Request")
            query.whereKey("latitude", greaterThanOrEqualTo: maxLat)
            query.whereKey("latitude", lessThanOrEqualTo: minLat)
            query.whereKey("longitude", greaterThanOrEqualTo: maxLong)
            query.whereKey("longitude", lessThanOrEqualTo: minLong)
            query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
                if let media = media {
                    print(media)
                    self.requests = Request.requestsWithArray(media)
                    self.tableView.reloadData()
                } else {
                    print(error)
                }
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
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first! as CLLocation
        lastLocation = location.coordinate
        print(lastLocation)
        loadData()
    }
    
    @IBAction func logOutButton(sender: AnyObject) {
        PFUser.logOut()
    }
    
    
    
}
