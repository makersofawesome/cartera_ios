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

class ComposeRequestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet var composeView: UIView!
    var currentString = ""
    let backButton = UIImage(named: "cancelButton")
    var location: CLLocationCoordinate2D?
    var currentRequest: Request?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 63, green: 81, blue: 181, alpha: 255)
        //self.navigationItem.backBarButtonItem?.image = UIImage(named: "cancelButton")
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "submitRequest")
        amountField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            print(currentString)
            formatCurrency(currentString)
        default:
            var array = Array(arrayLiteral: string)
            var currentStringArray = Array(arrayLiteral: currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(currentString)
            }
        }
        return false
    }
    
    
    @IBAction func amountFieldValueBeginChange(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        amountField.placeholder = "0.00"
        amountField.text! += "$"
        print("entered editing")
    }
    
    @IBAction func amountFieldValueChanged(sender: AnyObject) {
        amountField.textColor = UIColor.whiteColor()
        amountField.placeholder = nil
        print("value changed")
        formatCurrency(amountField.text!)
    }
    func formatCurrency(string: String) {
        print("format \(string)")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var numberFromField = (NSString(string: currentString).doubleValue)/100
        amountField.text = formatter.stringFromNumber(numberFromField)
        print(amountField.text )
    }
    /*func formatCurrency(string: String) {
        print("format \(string)")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        print(amountField.text)
    }*/
  
    func backButtonPressed(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    @IBAction func onCompose(sender: AnyObject) {
        currentRequest = Request(
            amount:Int(amountField.text!)!,
            lat: Float((location?.latitude)!),
            long: Float((location?.longitude)!),
            user:  _currentUser!)
        currentRequest!.postOpenRequest( withCompletion: {
            (success: Bool, error: NSError?) -> Void in
            if success {
                print("success requesting for \(self.currentRequest?.amount)")
            } else {
                print(error!.localizedDescription)
            }
        })
    }    
}
