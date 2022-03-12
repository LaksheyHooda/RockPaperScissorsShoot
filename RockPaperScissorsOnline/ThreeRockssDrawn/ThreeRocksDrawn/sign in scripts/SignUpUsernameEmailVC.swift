//
//  SignUpUsernameEmailVC.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/5/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import SCLAlertView
import TextFieldEffects

class SignUpUsernameEmailVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Email: MadokaTextField!
    @IBOutlet weak var Username: MadokaTextField!
    var PHusername = ""
    var PHemail = ""
    var PHlastname = ""
    var PHfirstname = ""
    var PHbday = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(PHemail != "")
        {
            Email.text = PHemail
        }
        if(PHusername != "")
        {
            Username.text = PHusername
        }
    }
    
    @IBAction func NextbtnPrsd(_ sender: Any) {
        if(Email.hasText && Username.hasText){
            if(Email.text?.range(of: "@") != nil && Email.text?.range(of: ".") != nil)
            {
                self.performSegue(withIdentifier: "Nextfield", sender: self)
            }
            else
            {
                //Email does not comply with email standered
                print("Email not in proper format")
                _ = SCLAlertView().showError("Oops", subTitle: "Make sure your email is in proper format. (Must include @ and  .)", closeButtonTitle:"dismiss")
            }
        }
        else
        {
            //one or more field is empty i.e. email or password
            print("something is empty")
            _ = SCLAlertView().showError("Oops", subTitle: "Some field is empty. Please double check that all fields are filled", closeButtonTitle:"dismiss")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Nextfield")
        {
            let vc = segue.destination as! SignUpNameBirthdayVC
            vc.email = Email.text!
            vc.username = Username.text!
            vc.PHusername = Username.text!
            vc.PHemail = Email.text!
            vc.PHfirstname = PHfirstname
            vc.PHlastname = PHlastname
            vc.PHbday = PHbday
        }
    }
    

}
