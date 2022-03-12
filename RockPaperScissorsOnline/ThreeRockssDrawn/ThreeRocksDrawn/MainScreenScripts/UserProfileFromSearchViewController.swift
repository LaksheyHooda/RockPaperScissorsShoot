//
//  UserProfileFromSearchViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/16/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse

class UserProfileFromSearchViewController: UIViewController {

    var userName = ""
    var instaHook = ""
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var anmeLbl: UILabel!
    @IBOutlet weak var usernameBtmLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var winsLbl: UILabel!
    @IBOutlet weak var lossesLbl: UILabel!
    @IBOutlet weak var leaderboardPosLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let query = PFUser.query()
        query?.whereKey("username", equalTo: userName)
        query?.findObjectsInBackground(block: { (objetcs, error) in
            if(error == nil)
            {
                if(objetcs?.count ?? 0 > 1)
                {
                    print("multiple user with the same username or no user found")
                    //give client no user found errir nessage
                }
                else
                {
                    self.usernameLbl.text = objetcs![0]["username"] as? String
                    self.usernameBtmLbl.text = objetcs![0]["username"] as? String
                    self.anmeLbl.text = (objetcs![0]["FirstName"] as! String) + " " + (objetcs![0]["LastName"] as! String)
                    self.bioLbl.text = objetcs![0]["Bio"] as? String
                    self.winsLbl.text = "\(objetcs![0]["Wins"] as? Int ?? 0)"
                    self.lossesLbl.text = "\(objetcs![0]["Losses"] as? Int ?? 0)"
                }
            }
            else
            {
                print(error as Any)
            }
        })
        let secondQuery = PFUser.query()
        secondQuery?.addDescendingOrder("Wins")
        secondQuery?.findObjectsInBackground(block: { (allObjcts, error) in
            if let error = error{
                print(error)
            }
            else{
                var i = 0
                for objct in allObjcts!{
                    i+=1
                    if(objct["username"] as! String == self.userName)
                    {
                        break
                    }
                }
                self.leaderboardPosLbl.text = "\(i)"
            }
            
        })
    }
    
    @IBAction func InstaBtnPrsd(_ sender: Any) {
        let instagramHooks = "instagram://user?username=laksheyy"
        let instagramUrl = NSURL(string: instagramHooks)
        let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : true]
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.open(instagramUrl! as URL, options: options) { (success) in
                if success {
                    
                }else{
                    print("Couldnt open url")
                }
            }
        }else{
            UIApplication.shared.open(NSURL(string: "http://instagram.com/laksheyy")! as URL, options: options) { (success) in
                if success{
                    
                }else{
                    print("Coudnt open URL to safari")
                }
            }
        }
            //UIApplication.shared.openURL(instagramUrl! as URL)
        //} else {
          //redirect to safari because the user doesn't have Instagram
          //  UIApplication.shared.openURL(NSURL(string: //"http://instagram.com/laksheyy")! as URL)
        //}
    }
    
    @IBAction func backbtnPrsd(_ sender: Any) {
        self.performSegue(withIdentifier: "formUsertoTab", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "formUsertoTab" {
             if let destVC = segue.destination as? UITabBarController {
                  destVC.selectedIndex = 1
             }
        }
    }
    // func open(scheme: String) {
   //   if let url = URL(string: scheme) {
   //     if #available(iOS 10, *) {
   //       UIApplication.shared.open(url, options: [:],
   //         completionHandler: {
   //           (success) in
   //            print("Open \(scheme): \(success)")
   //        })
   //     } else {
   //       let success = UIApplication.shared.openURL(url)
   //       print("Open \(scheme): \(success)")
   //     }
   //   }
   // }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
