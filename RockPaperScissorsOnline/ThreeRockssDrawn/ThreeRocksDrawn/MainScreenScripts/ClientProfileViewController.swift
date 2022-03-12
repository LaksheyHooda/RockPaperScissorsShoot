//
//  ClientProfileViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/29/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse

class ClientProfileViewController: UIViewController {

    @IBOutlet weak var winCt: UILabel!
    @IBOutlet weak var lossCt: UILabel!
    @IBOutlet weak var leaderboardPos: UILabel!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var UsernamePtTwo: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Bio: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let user = PFUser.current()
        winCt.text = "\(user!["Wins"] ?? "0")"
        lossCt.text = "\(user!["Losses"] ?? "0")"
        Username.text = user!.username
        UsernamePtTwo.text = user!.username
        Bio.text = "\(user!["Bio"] ?? " ")"
        Name.text = "\(user!["FirstName"] ?? "Name") \(user!["LastName"] ?? "Surname")"
        
        
        let userQuery = PFUser.query()
        userQuery?.addDescendingOrder("Wins")
        userQuery?.findObjectsInBackground(block: { (objects, error) in
            if let error = error{
                print(error)
            } else {
                var i = 0    
                for object in objects!{
                    i += 1
                    if object == PFUser.current(){
                        break
                    }
                }
                self.leaderboardPos.text = "\(i)"
            }
        })
        
    }
    @IBAction func changeUserStuffPrsd(_ sender: Any) {
        performSegue(withIdentifier: "SiwtchToEditPFP", sender: self)
    }

}
