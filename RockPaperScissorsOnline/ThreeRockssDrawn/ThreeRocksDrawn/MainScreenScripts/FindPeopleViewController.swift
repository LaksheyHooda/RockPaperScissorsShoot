//
//  FindPeopleViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/17/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import TextFieldEffects
import Parse

class FindPeopleViewController: UIViewController, UITextFieldDelegate {

    var usernameForSegue = ""
    @IBOutlet weak var recentUsernameOne: UILabel!
    @IBOutlet weak var recentUsernameTwo: UILabel!
    @IBOutlet weak var recentUsernameThree: UILabel!
    @IBOutlet weak var recentNameOne: UILabel!
    @IBOutlet weak var recentNameTwo: UILabel!
    @IBOutlet weak var recentNameThree: UILabel!
    @IBOutlet weak var discoverUsernameOne: UILabel!
    @IBOutlet weak var discoverUernameTwo: UILabel!
    @IBOutlet weak var discoverNameOne: UILabel!
    @IBOutlet weak var discoverNameTwo: UILabel!
    @IBOutlet weak var leaderbaordUsernameOne: UILabel!
    @IBOutlet weak var leaderboardUsernameTwo: UILabel!
    @IBOutlet weak var leaderboardUsernameThree: UILabel!
    @IBOutlet weak var leaderboardNameOne: UILabel!
    @IBOutlet weak var leaderboardNameTwo: UILabel!
    @IBOutlet weak var leaderboardNameThree: UILabel!
    @IBOutlet weak var recentoneBtn: UIButton!
    @IBOutlet weak var recenttwoBtn: UIButton!
    @IBOutlet weak var recentthreeBtn: UIButton!
    @IBOutlet weak var recentOneImg: UIImageView!
    @IBOutlet weak var recentTwoImg: UIImageView!
    @IBOutlet weak var recentThreeImg: UIImageView!
    
    fileprivate func getRecentSearches(_ recentOneUsername: String?, _ recentTwoUsername: String?, _ recentThreeUsername: String?) {
        for i in 1...3{
            if i == 1{
                let queryOne = PFUser.query()
                queryOne?.whereKey("username", equalTo: recentOneUsername as Any)
                queryOne?.findObjectsInBackground(block: { (objcs, error) in
                    if let error = error{
                        print(error)
                    }
                    else
                    {
                        if objcs!.count > 1{
                            //too many objects
                        }
                        else if objcs!.count > 0
                        {
                            self.recentUsernameOne.text = recentOneUsername
                            self.recentNameOne.text = "\(objcs![0]["FirstName"] ?? "Name") \(objcs![0]["LastName"] ?? "Surname")"
                        }
                    }
                })
            }
            else if i == 2{
                let queryTwo = PFUser.query()
                queryTwo?.whereKey("username", equalTo: recentTwoUsername as Any)
                queryTwo?.findObjectsInBackground(block: { (objcs, error) in
                    if let error = error{
                        print(error)
                    }
                    else
                    {
                        if objcs!.count > 1{
                            //too many objects
                        }
                        else if objcs!.count > 0
                        {
                            self.recentUsernameTwo.text = recentTwoUsername
                            self.recentNameTwo.text = "\(objcs![0]["FirstName"] ?? "Name") \(objcs![0]["LastName"] ?? "Surname")"
                        }
                    }
                })
            }
            else if i == 3{
                let queryThree = PFUser.query()
                queryThree?.whereKey("username", equalTo: recentThreeUsername as Any)
                queryThree?.findObjectsInBackground(block: { (objcs, error) in
                    if let error = error{
                        print(error)
                    }
                    else if objcs!.count > 0
                    {
                        if objcs!.count > 1{
                            //too many objects
                        }
                        else if objcs!.count > 0
                        {
                            self.recentUsernameThree.text = recentThreeUsername
                            self.recentNameThree.text = "\(objcs![0]["FirstName"] ?? "Name") \(objcs![0]["LastName"] ?? "Surname")"
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    @IBAction func recentOnePrsd(_ sender: Any) {
        usernameForSegue = recentUsernameOne.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func recentTwoPrsd(_ sender: Any) {
        usernameForSegue = recentUsernameTwo.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func recentThreePrsd(_ sender: Any) {
        usernameForSegue = recentUsernameThree.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func trendingOnePrsd(_ sender: Any) {
        usernameForSegue = discoverNameOne.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func trendingTwoPrsd(_ sender: Any) {
        usernameForSegue = discoverUernameTwo.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func LeaderboardOnePrsd(_ sender: Any) {
        usernameForSegue = leaderbaordUsernameOne.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func leaderboardTwoPrsd(_ sender: Any) {
        usernameForSegue = leaderboardUsernameTwo.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    @IBAction func leaderboardThreePrsd(_ sender: Any) {
        usernameForSegue = leaderboardUsernameThree.text!
        self.performSegue(withIdentifier: "userProfile", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        let recentOneUsername = user!["RecentFirst"] as? String
        let recentTwoUsername = user!["RecentSecond"] as? String
        let recentThreeUsername = user!["RecentThird"] as? String
        if(recentOneUsername == ""){
            recentUsernameOne.isHidden = true
            recentUsernameTwo.isHidden = true
            recentUsernameThree.isHidden = true
            recentNameOne.isHidden = true
            recentNameTwo.isHidden = true
            recentNameThree.isHidden = true
            recentOneImg.isHidden = true
            recentTwoImg.isHidden = true
            recentThreeImg.isHidden = true
            recentoneBtn.isHidden = true
            recenttwoBtn.isHidden = true
            recentthreeBtn.isHidden = true
        }else if(recentTwoUsername == ""){
            recentUsernameTwo.isHidden = true
            recentUsernameThree.isHidden = true
            recentNameTwo.isHidden = true
            recentNameThree.isHidden = true
            recentTwoImg.isHidden = true
            recentThreeImg.isHidden = true
            recenttwoBtn.isHidden = true
            recentthreeBtn.isHidden = true
        }else if(recentThreeUsername == ""){
            recentUsernameThree.isHidden = true
            recentNameThree.isHidden = true
            recentThreeImg.isHidden = true
            recentthreeBtn.isHidden = true
        }
        getRecentSearches(recentOneUsername, recentTwoUsername, recentThreeUsername)
        let randomUserQueryOne = PFUser.query()
        randomUserQueryOne?.addDescendingOrder("Searches")
        randomUserQueryOne?.findObjectsInBackground(block: { (objcs, error) in
            if let error = error{
                print(error)
            }
            else
            {
                if(objcs?.count ?? 0 >= 2)
                {
                    self.discoverUsernameOne.text = objcs![0]["username"] as? String
                    self.discoverNameOne.text = "\(objcs![0]["FirstName"] ?? "Name") \(objcs![0]["LastName"] ?? "Surname")"
                    self.discoverUernameTwo.text = objcs![1]["username"] as? String
                    self.discoverNameTwo.text = "\(objcs![1]["FirstName"] ?? "Name") \(objcs![1]["LastName"] ?? "Surname")"
                }
            }
        })
               
        let leaderBoardQuery = PFUser.query()
        leaderBoardQuery?.addDescendingOrder("Wins")
        leaderBoardQuery?.findObjectsInBackground(block: { (objects, error) in
            if let error = error{
                print(error)
            }
            else
            {
                if objects!.count >= 3{
                    self.leaderbaordUsernameOne.text = objects![0]["username"] as? String
                    self.leaderboardNameOne.text = "\(objects![0]["FirstName"] ?? "Name") \(objects![0]["LastName"] ?? "Surname")"
                    self.leaderboardUsernameTwo.text = objects![1]["username"] as? String
                    self.leaderboardNameTwo.text = "\(objects![1]["FirstName"] ?? "Name") \(objects![1]["LastName"] ?? "Surname")"
                    self.leaderboardUsernameThree.text = objects![2]["username"] as? String
                    self.leaderboardNameThree.text = "\(objects![2]["FirstName"] ?? "Name") \(objects![2]["LastName"] ?? "Surname")"
                }
            }
        })
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "userProfile"){
            let vc = segue.destination as! UserProfileFromSearchViewController
            vc.userName = usernameForSegue
        }
    }
    

}
