//
//  ViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/2/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse
import TextFieldEffects
import SCLAlertView

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var EmailField: MadokaTextField!
    @IBOutlet weak var PasswordField: MadokaTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if(currentUser != nil)
        {
            self.performSegue(withIdentifier: "signedIn", sender: self)
        }
    }

    @IBAction func signUpBtnPrsd(_ sender: Any) {
        self.performSegue(withIdentifier: "Signup", sender: self)
    }
    
    @IBAction func FogotPswdBtnPrsd(_ sender: Any) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.placeholder == "Password")
        {
            attemptSignIn()
        }
        else
        {
            textField.endEditing(true)
        }
        return true
    }
    
    func attemptSignIn(){
        let query = PFQuery(className:"EmailToUsername")
        query.whereKey("Email", equalTo:EmailField.text?.lowercased() ?? "")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
                _ = SCLAlertView().showError("Oops", subTitle: error.localizedDescription, closeButtonTitle:"dismiss")
            } else if let objects = objects {
                // The find succeeded.
                if(objects.count > 1)
                {
                    //Too many results to one email. Should be 1 username to 1 email.
                    _ = SCLAlertView().showError("Oops", subTitle: "There is an error on our end! Please wait as we resolve the issue)", closeButtonTitle:"dismiss")
                    print(objects)
                }
                else if(objects.count == 1)
                {
                    if(self.PasswordField.hasText)
                    {
                        PFUser.logInWithUsername(inBackground: objects[0]["Username"] as! String, password: self.PasswordField.text!) { (userog, error) in
                            if userog != nil {
                              // Do stuff after successful login.
                                //Segue to main here
                                PFUser.become(inBackground: (userog?.sessionToken)!) { (user, error) in
                                    if error != nil {
                                      // The token could not be validated.
                                        _ = SCLAlertView().showError("Oops", subTitle: "Your session token could not be validated. Please try again later", closeButtonTitle:"dismiss")
                                    } else {
                                      // The current user is now set to user.
                                        self.performSegue(withIdentifier: "signedIn", sender: self)
                                    }
                                }
                            } else {
                              // The login failed. Check error to see why.
                                print(error?.localizedDescription as Any)
                                _ = SCLAlertView().showError("Oops", subTitle: error!.localizedDescription, closeButtonTitle:"dismiss")
                            }
                        }
                    }
                    else
                    {
                        //Password has no values.
                        _ = SCLAlertView().showError("Oops", subTitle: "Looks like you forgot to put in your password. Please double check", closeButtonTitle:"dismiss")
                    }
                }
                else
                {
                    _ = SCLAlertView().showError("Oops", subTitle: "Your account doesn't exsist. Please sign up.", closeButtonTitle:"dismiss")
                }
            }
        }
    }
}

