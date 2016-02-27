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

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        print("loaded")
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
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

    @IBAction func onSignup(sender: AnyObject) {
        let user = PFUser()
        
        user.username = userField.text
        user.password = passwordField.text
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("created user")
                self.performSegueWithIdentifier("loginToMain", sender: nil)
            } else {
                print("failed creating user \(error?.localizedDescription)")
            }
        }
    }
}

