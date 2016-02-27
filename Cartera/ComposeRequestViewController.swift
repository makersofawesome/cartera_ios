//
//  ComposeRequestViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit

class ComposeRequestViewController: UIViewController {

    @IBOutlet weak var amountField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if amountField.editing {
            amountField.text = nil
            amountField.textColor = UIColor.whiteColor()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func onEditChanged(sender: AnyObject) {
//        if amountField.textColor == UIColor.lightGrayColor() {
//            amountField.text = nil
//            amountField.textColor = UIColor.whiteColor()
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
