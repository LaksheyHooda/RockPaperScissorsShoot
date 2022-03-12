//
//  EditProfileViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/29/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse
import SCLAlertView

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editUsername(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
          kTextFieldHeight: 60,
          showCloseButton: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Edit your name")
        _ = alert.addButton("Done") {
            let user = PFUser.current()
            user?.username = txt.text
            user?.saveInBackground(block: { (result, error) in
                if let error = error{
                    print("error")
                    _ = SCLAlertView().showError("Oops", subTitle: error.localizedDescription, closeButtonTitle:"dismiss")
                }
            })
        }
        _ = alert.showEdit("Edit Username", subTitle: "Edit your username to whatever you want", closeButtonTitle: "Cancel" )
    }
    @IBAction func editName(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
          kTextFieldHeight: 60,
          showCloseButton: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Edit your First Name")
        _ = alert.addButton("Done") {
            let appearance = SCLAlertView.SCLAppearance(
              kTextFieldHeight: 60,
              showCloseButton: true
            )
            let alert = SCLAlertView(appearance: appearance)
            let txtLast = alert.addTextField("Edit your Last Name")
            _ = alert.addButton("Done") {
                let user = PFUser.current()
                user!["FirstName"] = "\(txt.text ?? "First")"
                user!["LastName"] = "\(txtLast.text ?? "Last")"
                user?.saveEventually({ (result, error) in
                    if let error = error{
                        print("error")
                        _ = SCLAlertView().showError("Oops", subTitle: error.localizedDescription, closeButtonTitle:"dismiss")
                    }
                })
            }
            _ = alert.showEdit("Edit Name", subTitle: "Edit your last name.", closeButtonTitle: "Cancel")
        }
        _ = alert.showEdit("Edit Name", subTitle: "Edit your first name", closeButtonTitle: "Cancel")
    }
    @IBAction func editBio(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
            kTextFieldHeight: 60,
            showCloseButton: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Edit your Bio")
        _ = alert.addButton("Done") {
            let user = PFUser.current()
            user!["Bio"] = txt.text
            user?.saveInBackground(block: { (result, error) in
                if let error = error{
                    print("error")
                    _ = SCLAlertView().showError("Oops", subTitle: error.localizedDescription, closeButtonTitle:"dismiss")
                }
            })
        }
        _ = alert.showEdit("Edit Bio", subTitle: "Edit your Bio to whatever you want!", closeButtonTitle: "Cancel")
    }
    @IBAction func logOUt(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "SignInAgain", sender: self)
    }
    
    @IBAction func backPrsd(_ sender: Any) {
        performSegue(withIdentifier: "backtouserPfp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtouserPfp" {
             if let destVC = segue.destination as? UITabBarController {
                  destVC.selectedIndex = 2
             }
        }
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
