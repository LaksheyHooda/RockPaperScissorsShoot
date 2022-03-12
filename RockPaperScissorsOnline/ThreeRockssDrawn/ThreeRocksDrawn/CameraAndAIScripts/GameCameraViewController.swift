//
//  GameCameraViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 8/3/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import CameraManager
import Vision

class GameCameraViewController: UIViewController {

    @IBOutlet weak var PhotView: UIView!
    var myImage: UIImage?
    var solution:String?
    let cameraManager = CameraManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraManager.writeFilesToPhoneLibrary = false
        cameraManager.addPreviewLayerToView(PhotView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto(_ sender: Any) {        cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                    print(result)
                break
                    // error handling
                case .success(let content):
                    print("success")
                    self.myImage = content.asImage
                    self.processImg(img: self.myImage!)
            }
        })
    }
    
    @IBAction func FlipCameraClicked(_ sender: Any) {
        if cameraManager.cameraDevice == .back{
            cameraManager.cameraDevice = .front
        } else {
            cameraManager.cameraDevice = .back
        }
    }
    
    func turnFlashOn(){
        if(cameraManager.hasFlash(for: cameraManager.cameraDevice)){
            cameraManager.flashMode = .on
        }
    }
    
    func turnFlashOff(){
        cameraManager.flashMode = .off
    }
    
    @IBAction func backPrsd(_ sender: Any) {
        performSegue(withIdentifier: "CancelTakingPic", sender: self)
    }
    
    func processImg(img:UIImage){
           if let model = try? VNCoreMLModel(for: RPSClassifier().model){
               let request = VNCoreMLRequest(model: model) { (request, error) in
                   if let results = request.results as? [VNClassificationObservation]{
                       for result in results{
                           switch result.identifier {
                           case "rock":
                               self.solution = "rock"
                               self.performSegue(withIdentifier: "tookPic", sender: self)
                               break
                           case "paper":
                               self.solution = "paper"
                               self.performSegue(withIdentifier: "tookPic", sender: self)
                               break
                           case "scissors":
                               self.solution = "scissors"
                               self.performSegue(withIdentifier: "tookPic", sender: self)
                               break
                           default:
                               print("error, could not recog the img")
                           }
                       }
                   }
               }
               
               if let imagedata = img.jpegData(compressionQuality: 1.0){
                   let handler = VNImageRequestHandler(data: imagedata, options: [:])
                   
                   try? handler.perform([request])
               }
           }
       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tookPic"){
            let vc = segue.destination as! ResultScreenViewController
            vc.result = solution!
            vc.userTakenImg = myImage!
        }
        if segue.identifier == "CancelTakingPic" {
            if let destVC = segue.destination as? UITabBarController {
                destVC.selectedIndex = 0
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
