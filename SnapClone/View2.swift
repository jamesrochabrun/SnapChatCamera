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
    var didtakePhoto = Bool()

    
    @IBOutlet weak var tempImageView: UIImageView!
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

extension View2: AVCapturePhotoCaptureDelegate {
    
    func didPressTakePhoto() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160,
                             ]
        settings.previewPhotoFormat = previewFormat
        self.stillImageOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            
            guard let dataProvider = CGDataProvider(data: dataImage as CFData) else {
                print("error with dataProvider")
                return
            }
            guard let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) else {
                print("error on cgImageref initialization")
                return
            }
            
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: .right)
            
            tempImageView.image = image//UIImage(data: dataImage)
            tempImageView.isHidden = false
            
            
        } else {
            print("\(photoSampleBuffer)")
        }
    }
    
    func didPressTakeAnother() {
        
        if didtakePhoto {
            tempImageView.isHidden = true
            didtakePhoto = false
        } else {
            captureSession?.startRunning()
            didtakePhoto = true
            didPressTakePhoto()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didPressTakeAnother()
    }
}




















