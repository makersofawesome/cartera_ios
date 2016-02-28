//
//  ViewController.swift
//  Cartera
//
//  Created by Samee Khan on 2/26/16.
//  Copyright © 2016 Samee Khan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField! = nil
    @IBOutlet weak var userField: UITextField! = nil
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        signinButton.layer.cornerRadius = 8
        signupButton.layer.cornerRadius = 8
        print("loaded")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("signing in ")
                self.performSegueWithIdentifier("loginToMain", sender: nil)
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }


    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

}

