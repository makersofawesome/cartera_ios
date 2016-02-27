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
    @IBOutlet var composeView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    let backButton = UIImage(named: "cancelButton")
    
    var currentRequest: Request?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if amountField.editing {
//            amountField.text = nil
//            amountField.textColor = UIColor.whiteColor()
//            print("entered editing state")
//        } *not running
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 63, green: 81, blue: 181, alpha: 255)
        self.navigationItem.backBarButtonItem?.image = UIImage(named: "cancelButton")
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: backButton, style: .Plain, target: self, action: nil)
//        self.navigationItem.leftBarButtonItem =
//            UIBarButtonItem(image:backButton, style:.Plain, target:self, action:"backButtonPressed:")

        print("button should be changed")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func amountFieldValueBeginChange(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        amountField.text! += "$"

        print("entered editing")
    }
    
    @IBAction func amountFieldValueChanged(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        amountField.placeholder = nil
        print("entered editing")
        formatCurrency(amountField.text!)
    }
    
    func formatCurrency(string: String) {
        print("format \(string)")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
//        var numberFromField = (NSString(string: string).doubleValue)/100
//        print(numberFromField)
//        amountField.text = formatter.stringFromNumber(numberFromField)
        print(amountField.text)
    }
    
//    func returnToMainVC(){
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 1], animated: true)
//    }
    
    func backButtonPressed(sender:UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func toMainVC(sender: UIButton) {
        backButtonPressed(cancelButton)
    }
    


    @IBAction func onCompose(sender: AnyObject) {
        //need user and amount
        currentRequest = Request(params: composeParams())
        currentRequest!.postOpenRequest( withCompletion: {
            (success: Bool, error: NSError?) -> Void in
            if success {
                print("success requesting for \(self.currentRequest?.amount)")
            } else {
                print(error!.localizedDescription)
            }
        })
    }
//    func composeParams() -> NSDictionary {
//        return [
//            "user": _currentUser!,
//            "amount": Int(amountField.text!)!
//        ]
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
