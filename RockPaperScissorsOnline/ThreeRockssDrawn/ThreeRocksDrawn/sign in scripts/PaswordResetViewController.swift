//
//  PaswordResetViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 8/18/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import TextFieldEffects
import Parse
import SCLAlertView

class PaswordResetViewController: UIViewController {

    @IBOutlet weak var email: MadokaTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendBtnPrsd(_ sender: Any) {
        if email.hasText{
            PFUser.requestPasswordResetForEmail(inBackground: email.text!) { (sucess, error) in
                if let error = error{
                    _ = SCLAlertView().showError("Oops", subTitle: error.localizedDescription, closeButtonTitle:"dismiss")
                }
            }
            self.performSegue(withIdentifier: "return", sender: self)
        }
        else
        {
            _ = SCLAlertView().showError("Oops", subTitle: "Looks like email is empty. Please double check and try again.", closeButtonTitle:"dismiss")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func returnbtnPrsd(_ sender: Any) {
        self.performSegue(withIdentifier: "return", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
