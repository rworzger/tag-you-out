//
//  FaceDetectionViewController.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 10/08/2021.
//

import UIKit
import ARKit
import AVFoundation

class FaceDetectionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    
    let numOfFaces: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Put your face in the camera"
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont(name: "Seagram tfb", size: 32)
        
        label.numberOfLines = 0
        return label
    }()

    private let photoOutput = AVCapturePhotoOutput()
    
    var previewImage = UIImage()
    var people: [Person] = []
    var captureDevice: AVCaptureDevice?
    var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    var captureSession: AVCaptureSession = AVCaptureSession()
    var dataOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
    var input: AVCaptureDeviceInput?
    
    let captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleTakePhoto), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        // May not exist
        button.setImage(UIImage(systemName: "play"/*"person.2.fill"*/), for: .normal)
        button.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let switchCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.camera"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSwitchCamera), for: .touchUpInside)
        button.tintColor = .white
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    @objc func handleSwitchCamera() {
        // Get current input
        guard let input = captureSession.inputs[0] as? AVCaptureDeviceInput else { return }

        // Begin new session configuration and defer commit
        captureSession.beginConfiguration()
        defer { captureSession.commitConfiguration() }

        // Create new capture device
        var newDevice: AVCaptureDevice?
        if input.device.position == .back {
            newDevice = captureDevice(with: .front)
        } else {
            newDevice = captureDevice(with: .back)
        }

        // Create new capture input
        var deviceInput: AVCaptureDeviceInput!
        do {
            deviceInput = try AVCaptureDeviceInput(device: newDevice!)
            captureDevice = newDevice
        } catch let error {
            print(error.localizedDescription)
            return
        }

        // Swap capture device inputs
        captureSession.removeInput(input)
        captureSession.addInput(deviceInput)
    }

    // Create new capture device with requested position
    func captureDevice(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {

        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [ .builtInWideAngleCamera, .builtInMicrophone, .builtInDualCamera, .builtInTelephotoCamera ], mediaType: .video, position: .unspecified).devices

        for device in devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    @objc func handleContinue() {
        let controller = BlackHouseViewController(image: previewImage, people: people)
        
        let parent = self.presentingViewController
//        let nav = self.presentingViewController as! UINavigationController
//
//        self.dismiss(animated: true) {
//            nav.pushViewController(controller, animated: true)
//        }
        self.dismiss(animated: true) {
            parent?.present(controller, animated: true)
        }
    }
    
    func setupViews() {
        view.addSubview(numOfFaces)
        view.addSubview(captureButton)
        view.addSubview(switchCameraButton)
    }
    
    func setupConstraints() {
        numOfFaces.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numOfFaces.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        switchCameraButton.makeConstraints(top: view.topAnchor, left: nil, right: view.rightAnchor, bottom: nil, topMargin: 20, leftMargin: 0, rightMargin: 20, bottomMargin: 0, width: 50, height: 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        openCamera()
    }
    
    /* --------------------------------------------------Above is Basic Setup------------------------------------------------ */
    
    /* --Below Implements AVCaptureSession, AVCaptureVideoDataOutputSampleBufferDelegate, and AVCapturePhotoCaptureDelegate-- */
    private func setupCaptureSession(position: AVCaptureDevice.Position) {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
        
        if let currentInput = self.input {
            self.captureSession.removeInput(currentInput)
            self.input = nil
        }
        
        do {
            try input = AVCaptureDeviceInput(device: captureDevice!)
        } catch {
            return
        }
        
        captureSession.addInput(input!)
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
        
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.insertSublayer(cameraLayer, below: numOfFaces.layer)
        cameraLayer.frame = view.frame
        
        cameraLayer.videoGravity = .resizeAspectFill
        
        captureSession.startRunning()
        
        dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
       
        NetworkManager.analyze(encodedImage: imageData.base64EncodedString()) { ResultData in
            print(imageData.base64EncodedString())
            print(ResultData)
            self.people = ResultData.people
        }
        
        previewImage = UIImage(data: imageData)!
//        Flip the photo taken if front camera is used, so that the photo resemmble the one you see in preview
        if self.captureDevice?.position == .front {
            previewImage = UIImage(cgImage: previewImage.cgImage!, scale: UIScreen.main.scale, orientation: .leftMirrored)
        }
        
        let photoPreviewContainer = PhotoPreviewView(frame: self.view.frame)
        photoPreviewContainer.delegate = self
        photoPreviewContainer.photoImageView.image = previewImage
        self.view.addSubviews(photoPreviewContainer)
        photoPreviewContainer.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.bottomAnchor.constraint(equalTo: photoPreviewContainer.bottomAnchor, constant: -25).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: photoPreviewContainer.centerXAnchor).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            
            if let error = error {
                print("Failed to detect faces:", error)
                return
            }
            
            DispatchQueue.main.async {
                if let results = request.results {
                    if results.count == 1 {
                        self.numOfFaces.text = "Detected your face,\ntake a photo to proceed."
                        self.captureButton.isEnabled = true
                    } else if results.count > 1 {
                        self.numOfFaces.text = "More than one face detected,\nmake sure no one is behind you."
                        self.captureButton.isEnabled = true
                    } else {
                        self.numOfFaces.text = "Put your face in the camera"
                        self.captureButton.isEnabled = false
                    }
                }
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch let requestError {
                print("Failed to perform request:", requestError)
            }
        }
    }
    
    /* ----------------------------------------------Below are Helper Functions---------------------------------------------- */
    
    @objc private func handleTakePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    // Check camera authorization. If granted, setup capture session. Else, dismiss.
    private func openCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            self.setupCaptureSession(position: .front)
        
        case .notDetermined: // the user has not yet asked for camera access.
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            if granted { // if user has granted to access the camera.
                print("the user has granted to access the camera")
                DispatchQueue.main.async {
                    self.setupCaptureSession(position: .front)
                }
            } else {
                print("the user has not granted to access the camera")
                self.handleDismiss()
            }
        }
        
        case .denied:
            print("the user has denied previously to access the camera.")
            self.handleDismiss()
                
        case .restricted:
            print("the user can't give camera access due to some restriction.")
            self.handleDismiss()
                
        default:
            print("something has wrong due to we can't access the camera.")
            self.handleDismiss()
        }
    }
    
    @objc private func handleDismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

protocol SwitchCameraDelegate {
    func swichCamera() -> Void
}

extension FaceDetectionViewController: SwitchCameraDelegate {
    func swichCamera() {
        handleSwitchCamera()
    }
}
