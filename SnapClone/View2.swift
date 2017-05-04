//
//  View2.swift
//  SnapClone
//
//  Created by James Rochabrun on 5/4/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import AVFoundation

class View2: UIViewController {
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            if (captureSession?.canAddInput(input))! {
                captureSession?.addInput(input)
                stillImageOutput = AVCapturePhotoOutput()
                //check for settings .settingsoutput of deprecated class
                
                if (captureSession?.canAddOutput(stillImageOutput))! {
                    captureSession?.addOutput(stillImageOutput)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = .portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                }
                
            }
        } catch {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
}

extension View2: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}



