//
//  LeaderBoardViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/19/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var firstPlaceUsername: UILabel!
    @IBOutlet weak var firstPlaceName: UILabel!
    @IBOutlet weak var secondPlaceUsername: UILabel!
    @IBOutlet weak var secondPlaceName: UILabel!
    @IBOutlet weak var thirdPlaceUsername: UILabel!
    @IBOutlet weak var thirdPlaceName: UILabel!
    @IBOutlet weak var forthPlaceUsername: UILabel!
    @IBOutlet weak var forthPlaceName: UILabel!
    @IBOutlet weak var fifthPlaceUsername: UILabel!
    @IBOutlet weak var fifthPlaceName: UILabel!
    @IBOutlet weak var sixthPlaceUsername: UILabel!
    @IBOutlet weak var sixthPlaceName: UILabel!
    
    var userNameToSend = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFUser.query()
        query?.addDescendingOrder("Wins")
        query?.findObjectsInBackground(block: { (objcts, error) in
            if let error = error{
                print(error)
            }
            else
            {
                if(objcts?.count ?? 0 >= 6){
                    self.firstPlaceUsername.text =  objcts![0]["username"] as? String
                    self.secondPlaceUsername.text =  objcts![1]["username"] as? String
                    self.thirdPlaceUsername.text =  objcts![2]["username"] as? String
                    self.forthPlaceUsername.text =  objcts![3]["username"] as? String
                    self.fifthPlaceUsername.text =  objcts![4]["username"] as? String
                    self.sixthPlaceUsername.text =  objcts![5]["username"] as? String
                    
                    self.firstPlaceName.text = "\(objcts![0]["FirstName"] ?? "Name") \(objcts![0]["LastName"] ?? "Surname")"
                    self.secondPlaceName.text = "\(objcts![1]["FirstName"] ?? "Name") \(objcts![1]["LastName"] ?? "Surname")"
                    self.thirdPlaceName.text = "\(objcts![2]["FirstName"] ?? "Name") \(objcts![2]["LastName"] ?? "Surname")"
                    self.forthPlaceName.text = "\(objcts![3]["FirstName"] ?? "Name") \(objcts![3]["LastName"] ?? "Surname")"
                    self.fifthPlaceName.text = "\(objcts![4]["FirstName"] ?? "Name") \(objcts![4]["LastName"] ?? "Surname")"
                    self.sixthPlaceName.text = "\(objcts![5]["FirstName"] ?? "Name") \(objcts![5]["LastName"] ?? "Surname")"
                }
            }
        })
        
    }
    
    @IBAction func sixthPlxPrsd(_ sender: Any) {
        userNameToSend = sixthPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    @IBAction func fifthPlsPrsd(_ sender: Any) {
        userNameToSend = fifthPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    @IBAction func fourthPlsPrsd(_ sender: Any) {
        userNameToSend = forthPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    @IBAction func thirdPlsPrsd(_ sender: Any) {
        userNameToSend = thirdPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    @IBAction func secondPlsPrsd(_ sender: Any) {
        userNameToSend = secondPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    @IBAction func firstPlsPrsd(_ sender: Any) {
        userNameToSend = firstPlaceUsername.text ?? "Notfound"
        self.performSegue(withIdentifier: "LeaderboardSeg", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderboardSeg"{
            let vc = segue.destination as! UserProfileFromSearchViewController
            vc.userName = userNameToSend
        }
    }
    

}
