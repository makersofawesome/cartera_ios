//
//  MainViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var image = UIImage(named: "composeButton")
//        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Main Cell", forIndexPath: indexPath) as! MainCell
        

        return cell
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        Client.sharedClient.createTransfersWithParams("56c66be6a73e492741507e12", params: NSDictionary())
    }

}
