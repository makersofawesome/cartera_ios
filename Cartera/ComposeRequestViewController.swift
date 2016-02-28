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
import SwiftyJSON

class ComposeRequestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet var composeView: UIView!
    var currentString = ""
    let backButton = UIImage(named: "cancelButton")
    var location: CLLocationCoordinate2D?
    var currentRequest: Request?
    override func viewDidLoad() {
        super.viewDidLoad()
        amountField.textColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 63, green: 81, blue: 181, alpha: 255)
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "submitRequest")
        amountField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func amountFieldValueBeginChange(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        amountField.placeholder = "0.00"
        amountField.text! += "$"
        print("entered editing")
    }
    
    @IBAction func amountFieldValueChanged(sender: AnyObject) {
        amountField.placeholder = nil
    }
     func backButtonPressed(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func displayAlert(text: String) {
        let alertController = UIAlertController(title: "Cortera", message:
            text, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    func getBalance(){
        let json = Client.sharedClient.getAccountById(_currentUser!.accountId!)
    }
    @IBAction func onCompose(sender: AnyObject) {

        let amount = (String(amountField.text!.characters.dropFirst()))
        if amount.characters.count > 0 //&& Int(amount) <= getBalance() 
        {
            currentRequest = Request(
                amount:Float(amount)!,
                lat: Float((location?.latitude)!),
                long: Float((location?.longitude)!),
                requesterId:  _currentUser!.id!)
            currentRequest!.postOpenRequest( withCompletion: {
                (success: Bool, error: NSError?) -> Void in
                if success {
                    print("success requesting for \(self.currentRequest?.amount)")
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
       else {
            displayAlert("Error posting Cartera request")
        }
    }
}
