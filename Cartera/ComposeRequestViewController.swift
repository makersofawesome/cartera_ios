//
//  ComposeRequestViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import MoneyFramework
import Parse

class ComposeRequestViewController: UIViewController {

 
    @IBOutlet weak var amountField: UITextField!
    var currentRequest: Request?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if amountField.editing {
//            amountField.text = nil
//            amountField.textColor = UIColor.whiteColor()
//            print("entered editing state")
//        } *not running

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func amountFieldValueBeginChange(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        print("entered editing")
    }
    
    @IBAction func amountFieldValueChanged(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        print("entered editing")
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        //need user and amount
        currentRequest = Request(params: composeParams())
        currentRequest!.postOpenRequest( withCompletion: {
            (success: Bool, error: NSError?) -> Void in
            if success {
                print("success posting")
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    func composeParams() -> NSDictionary {
        return [
            "user": _currentUser!,
            "amount": Int(amountField.text!)!
        ]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
