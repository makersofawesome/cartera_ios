//
//  DetailsViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var requesterName: UILabel!
    var request: Request?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        let user = User(id: (request?.requesterId)!)
        let amt = String(format: "%\(0.2)f", request!.amount!)
        amountLabel.text = "$\(amt)"
        requesterName.text = "\(user.firstName!) \(user.lastName!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onOpenMap(sender: AnyObject) {
        
        var lat: CLLocationDegrees?
        var long: CLLocationDegrees?
        lat = Double((request?.latitude)!)
        long = Double((request?.longitude)!)
        let regionDistance:CLLocationDistance = 10000
        
        var coordinates = CLLocationCoordinate2DMake(lat!,long!)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        var options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        var placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "\(self.venueName)"
        mapItem.openInMapsWithLaunchOptions(options)
    }

    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

  

}
