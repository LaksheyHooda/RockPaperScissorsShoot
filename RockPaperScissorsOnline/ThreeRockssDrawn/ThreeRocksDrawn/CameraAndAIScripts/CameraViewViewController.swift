//
//  CameraViewViewController.swift
//  ThreeRocksDrawn
//
//  Created by Lakshey Hooda on 7/29/20.
//  Copyright © 2020 Lakshey Hooda. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import Vision

class CameraViewViewController: UIViewController, AVCapturePhotoCaptureDelegate {
        
    @IBOutlet weak var PhotView: UIView!
    var mainImg:UIImage?
    var solution:String?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer!.frame = view.layer.bounds
            PhotView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
        }
        catch
        {
            print("error")
        }
        
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput!)
    }
    
    func switchToFrontCam()
    {
        if frontCamera?.isConnected == true{
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            do
            {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer!.frame = view.layer.bounds
                PhotView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            }
            catch
            {
                print("error")
            }
        }
    }
    
    func switchToBackCam()
    {
        if backCamera?.isConnected == true{
            captureSession?.stopRunning()
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            do
            {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer!.frame = view.layer.bounds
                PhotView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            }
            catch
            {
                print("error")
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if photo.fileDataRepresentation() != nil
        {
            //CapturedImg
            let imgToSend = UIImage(data: photo.fileDataRepresentation()!)
            mainImg = imgToSend!
            processImg(img: imgToSend!)
        }
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
            vc.userTakenImg = mainImg!
        }
    }
    
    @IBAction func PictureClicked(_ sender: Any) {
        guard let CapturePhotoOutput = self.capturePhotoOutput else { print("Error")
            return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        CapturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    @IBAction func FlipCameraClicked(_ sender: Any) {
        guard let currentCameraInput: AVCaptureInput = captureSession?.inputs.first else {
            return
        }
        if let input = currentCameraInput as? AVCaptureDeviceInput
        {
            if input.device.position == .back
            {
                switchToFrontCam()
            }
            if input.device.position == .front
            {
                switchToBackCam()
            }
        }
    }
}
