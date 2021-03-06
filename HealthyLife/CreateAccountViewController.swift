//
//  CreateAccountViewController.swift
//  HealthyLife
//
//  Created by admin on 7/26/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    var ref =  FIRDatabase.database().reference()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func createButton(sender: AnyObject) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextfield.text {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.debugDescription)
                    Helper.showAlert("Error", message: error?.localizedDescription, inViewController: self)
                } else {
                    FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                        if error != nil {
                            
                        } else {
                            self.ref.child("users").child(user!.uid).child("username").setValue(username)
                            self.defaults.setBool(true, forKey: "checkID")
                            self.performSegueWithIdentifier("2", sender: self)
                        }
                    })
                }
                
            })
        } else {
            Helper.showAlert("Oops", message: "Please fill in all the fields", inViewController: self)
        }
    }
    
    @IBAction func dismis(sender: AnyObject) {
        
    }
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

