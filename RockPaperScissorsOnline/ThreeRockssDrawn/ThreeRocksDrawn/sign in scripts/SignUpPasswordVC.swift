//
//  SignUpPasswordVC.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/5/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse
import SCLAlertView
import TextFieldEffects

class SignUpPasswordVC: UIViewController, UITextFieldDelegate {

    var username = ""
    var email = ""
    var firstName = ""
    var lastName = ""
    var birthdate = ""
    
    @IBOutlet weak var paswd: MadokaTextField!
    @IBOutlet weak var confirmPswd: MadokaTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if(paswd.text == confirmPswd.text)
        {
            let user = PFUser()
            user.username = username
            user.password = confirmPswd.text!
            user.email = email.lowercased()
            user["Wins"] = 0
            user["Losses"] = 0
            user["FirstName"] = firstName
            user["LastName"] = lastName
            user["Birthdate"] = birthdate
            user.signUpInBackground { (success, error) in
                if(error != nil)
                {
                    //Handle error
                    print(error?.localizedDescription as Any)
                    _ = SCLAlertView().showError("Oops", subTitle: error!.localizedDescription, closeButtonTitle:"dismiss")
                }
                else
                {
                    //Sucess in making new user
                    let usernameConversionClass = PFObject(className:"EmailToUsername")
                    usernameConversionClass["Username"] = self.username
                    usernameConversionClass["Email"] = self.email
                    usernameConversionClass.saveInBackground { (sucessSec, errorSec) in
                        if(sucessSec)
                        {
                            //Success in conversion chart and can user the app
                            self.performSegue(withIdentifier: "signUpToMain", sender: self)
                        }
                        else
                        {
                            //something went wrong handle error
                            print(errorSec?.localizedDescription as Any)
                            _ = SCLAlertView().showError("Oops", subTitle: errorSec!.localizedDescription, closeButtonTitle:"dismiss")
                        }
                    }
                }
            }
        }
        else
        {
            _ = SCLAlertView().showError("Oops", subTitle: "Passwords dont match or something is empty. Please double check", closeButtonTitle:"dismiss")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToName")
        {
            let vc = segue.destination as! SignUpNameBirthdayVC
            vc.PHbday = birthdate
            vc.PHlastname = lastName
            vc.PHfirstname = firstName
            vc.PHemail = email
            vc.PHusername = username
        }
    }
}
