//
//  SignUpNameBirthdayVC.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/5/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import TextFieldEffects
import SCLAlertView

class SignUpNameBirthdayVC: UIViewController, UITextFieldDelegate{

    var username = ""
    var email = ""
    var PHusername = ""
    var PHemail = ""
    var PHlastname = ""
    var PHfirstname = ""
    var PHbday = ""
    
    @IBOutlet weak var firstName: MadokaTextField!
    @IBOutlet weak var LastName: MadokaTextField!
    @IBOutlet weak var Birthdate: MadokaTextField!
    @IBOutlet weak var theDatePicker: UIDatePicker!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch traitCollection.userInterfaceStyle {
        case .light: //light mode
            theDatePicker.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        break
        case .dark:
            theDatePicker.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        break //dark mode
        case .unspecified:
            theDatePicker.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        break //the user interface style is not specified
        @unknown default:
            theDatePicker.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
        theDatePicker.isHidden = true
        confirmBtn.isHidden = true
        nextBtn.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(PHfirstname != "")
        {
            firstName.text = PHfirstname
        }
        if(PHlastname != "")
        {
            LastName.text = PHlastname
        }
        if(PHbday != "")
        {
            Birthdate.text = PHbday
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == Birthdate)
        {
            textField.endEditing(true)
            theDatePicker.isHidden = false
            nextBtn.isHidden = true
            confirmBtn.isHidden = false
        }
    }
    
    @IBAction func NextbtnPrsd(_ sender: Any) {
        if(firstName.hasText && LastName.hasText && Birthdate.hasText)
        {
            self.performSegue(withIdentifier: "Nextpassword", sender: self)
        }
        else
        {
            //Some field is empty
            print("Something is empty")
            _ = SCLAlertView().showError("Oops", subTitle: "Some field is empty. Please double check that all fields are filled", closeButtonTitle:"dismiss")
        }
    }
    
    @IBAction func datePickerCOnfirmBtnPrsed(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        let now = df.string(from: theDatePicker.date)
        Birthdate.text = now
        theDatePicker.isHidden = true
        confirmBtn.isHidden = true
        nextBtn.isHidden = false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Nextpassword")
        {
            let vc = segue.destination as! SignUpPasswordVC
            vc.username = username
            vc.email = email
            vc.firstName = firstName.text!
            vc.lastName = LastName.text!
            vc.birthdate = Birthdate.text!
        }
        else if(segue.identifier == "backToEmail")
        {
            let vc = segue.destination as! SignUpUsernameEmailVC
            vc.PHusername = PHusername
            vc.PHemail = PHemail
            vc.PHfirstname = firstName.text!
            vc.PHlastname = LastName.text!
            vc.PHbday = Birthdate.text!
        }
    }
    
}
