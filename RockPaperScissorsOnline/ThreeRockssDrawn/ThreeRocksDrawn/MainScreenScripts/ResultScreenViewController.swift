//
//  ResultScreenViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 8/3/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Parse

class ResultScreenViewController: UIViewController {
    
    var userTakenImg = UIImage()
    var result = ""
    var solution = "win"
    
    @IBOutlet weak var WinorLossLbl: UILabel!
    @IBOutlet weak var totalLosses: UILabel!
    @IBOutlet weak var totalWins: UILabel!
    @IBOutlet weak var AIImg: UIImageView!
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var resultStr: UILabel!
    @IBOutlet weak var addWin: UILabel!
    @IBOutlet weak var AILbl: UILabel!
    @IBOutlet weak var addLoss: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func whoWon(_ genAnswer: String) {
        if genAnswer == "rock"{
            if result == "rock"{
                solution = "draw"
            } else if result == "paper"{
                solution = "won"
            } else {
                solution = "loss"
            }
        }
        else if genAnswer == "paper"{
            switch result {
            case "paper":
                solution = "draw"
                break
            case "scissors":
                solution = "win"
                break
            case "rock":
                solution = "loss"
                break
            default:
                solution = "win"
                break
            }
        }
        else if genAnswer == "scissors"{
            switch result {
            case "scissors":
                solution = "draw"
                break
            case "rock":
                solution = "win"
                break
            case "paper":
                solution = "loss"
                break
            default:
                solution = "win"
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserImg.image = userTakenImg
        resultStr.text = result
        var genAnswer = ""
        switch arc4random_uniform(3){
        case 0:
            genAnswer = "rock"
            AIImg.image = UIImage(named: "rockRPSAI1")
            break
        case 1:
            genAnswer = "paper"
            AIImg.image = UIImage(named: "paperRPSAI1")
            break
        default:
            genAnswer = "scissors"
            AIImg.image = UIImage(named: "scissorsRPSAI1")
            break
        }
        AILbl.text = genAnswer
        whoWon(genAnswer)
        if(solution == "win"){
            //won
            WinorLossLbl.text = "You Won!"
        }
        else if(solution == "loss"){
            //lost
            WinorLossLbl.text = "You Lost"
        }
        else if(solution == "draw"){
            //draw
            WinorLossLbl.text = "Draw!"
        }
        updateUser()
    }
    
    @IBAction func donePrsd(_ sender: Any) {
        performSegue(withIdentifier: "finishedPLaying", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "finishedPLaying" {
                   if let destVC = segue.destination as? UITabBarController {
                        destVC.selectedIndex = 0
                   }
              }
    }
    
    func updateUser(){
        let user = PFUser.current()
        totalWins.text = "\(user!["Wins"] ?? "0")"
        totalLosses.text = "\(user!["Losses"] ?? "0")"
        if(solution == "win"){
            addWin.isHidden = false
            user!["Wins"] = (user!["Wins"] as? Int)! + 1
        }
        else if(solution == "loss"){
            addLoss.isHidden = false
            user!["Losses"] = (user!["Losses"] as? Int)! + 1
        }
        user!.saveInBackground()
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
