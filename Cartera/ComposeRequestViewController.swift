//
//  ComposeRequestViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/27/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import MoneyFramework

class ComposeRequestViewController: UIViewController {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet var composeView: UIView!
    
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
    
    func formatCurrency(string: String) {
        print("format \(string)")
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var numberFromField = (NSString(string: string).doubleValue)/100
        amountField.text = formatter.stringFromNumber(numberFromField)
        print(amountField.text)
    }
    
//    func returnToMainVC(){
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 1], animated: true)
//    }
    
    @IBAction func toMainVC(sender: UIButton) {
//        returnToMainVC()
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
