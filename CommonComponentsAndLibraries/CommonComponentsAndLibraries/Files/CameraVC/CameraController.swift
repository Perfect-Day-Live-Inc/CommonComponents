//
//  ViewController.swift
//  CameraVC
//
//  Created by Appiskey's iOS Dev on 09/08/2019.
//  Copyright © 2019 Appiskey. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import QuickLook

protocol CameraControllerDelegate{
    func cameraControllerCapturedImage(_ image: UIImage, controller: UIViewController)
    func cameraControllerCapturedVideo(_ videoURL: URL, controller: UIViewController)
    func cameraControllerCancelled(_ controller: UIViewController)
}

class CameraController: UIViewController {
    
    enum CaptureMode {
        case video
        case picture
    }
    
    @IBOutlet weak var flashImgView: UIImageView!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var redDotView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var camPreview: UIView!
    @IBOutlet weak var changeCameraBtn: UIButton!
    
    let bundle = Bundle.init(for: CameraController.self)
    var timer : Timer = Timer()
    var countOfVideoRecording : Int = 0
    var delegate : CameraControllerDelegate!
    
    var maximumDurationInSeconds : Int = 30
    var usingFrontCamera : Bool = false
    var captureMode : CaptureMode = .video
    
    var isEditedVideoSaved : Bool = false
    let captureSession = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    let imageOutput = AVCapturePhotoOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var activeInput: AVCaptureDeviceInput!
    var outputURL: URL!
    var captureDevice: AVCaptureDevice!
    var capturedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeCameraBtn.imageView?.contentMode = .scaleAspectFit
        if setupSession() {
            self.setupPreview()
            self.setupUI()
            self.startSession()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func setupPreview() {
        // Configure previewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.connection?.videoOrientation = self.currentVideoOrientation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.previewLayer.frame = self.camPreview.bounds
            self.camPreview.layer.addSublayer(self.previewLayer)
        }
    }
    
    func setupUI(){
        self.recordBtn.layer.cornerRadius = self.recordBtn.frame.height/2
        self.recordBtn.backgroundColor = (self.captureMode == .video) ? .red : .white
        self.recordBtn.clipsToBounds = true
        self.redDotView.isHidden = true
        self.topView.isHidden = (self.captureMode == .video) ? false : true
    }
    
    func startTimer(){
        self.countOfVideoRecording = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerValueChanged),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func timerValueChanged(){
        self.countOfVideoRecording += 1
        var textToShow = "00:00:00"
        if self.countOfVideoRecording <= (60*60*24){
            self.redDotView.isHidden = !self.redDotView.isHidden
            let hours = Int(self.countOfVideoRecording) / 3600
            let minutes = Int(self.countOfVideoRecording) / 60 % 60
            let seconds = Int(self.countOfVideoRecording) % 60
            textToShow = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
            self.timeLbl.text = "\(textToShow)"
            if self.countOfVideoRecording == self.maximumDurationInSeconds{
                self.redDotView.isHidden = true
                timer.invalidate()
                self.stopRecording()
                //                self.showAlert(title: "Alert", message: "Max Limit.")
            }
        }else{
            self.stopRecording()
        }
        
    }
    
    //MARK:- Setup Camera
    
    func setupSession() -> Bool {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        // Setup Camera
        if let camera = self.getBackCamera(){
            do {
                self.captureDevice = camera
                let input = try AVCaptureDeviceInput(device: camera)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                    activeInput = input
                }
            } catch {
                self.unableToFindCameraAlert()
                print("Error setting device video input: \(error)")
                return false
            }
            
            // Setup Microphone
            if let microphone = AVCaptureDevice.default(for: AVMediaType.audio){
                do {
                    let micInput = try AVCaptureDeviceInput(device: microphone)
                    if captureSession.canAddInput(micInput) {
                        captureSession.addInput(micInput)
                    }
                } catch {
                    print("Error setting device audio input: \(error)")
                    return false
                }
            }else{
                self.unableToFindCameraAlert()
                print("unable to find microphone")
                return false
            }
            
            
            // Movie output
            if self.captureMode == .video{
                if captureSession.canAddOutput(movieOutput) {
                    captureSession.addOutput(movieOutput)
                }
            }else{
                if captureSession.canAddOutput(imageOutput) {
                    captureSession.addOutput(imageOutput)
                }
            }
            
        }else{
            self.unableToFindCameraAlert()
            print("unable to find camera")
            return false
        }
        return true
    }
    
    func changeCamera(){
        usingFrontCamera = !usingFrontCamera
        UIView.animate(withDuration: 0.3) {
            if let inputs = self.captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    self.captureSession.removeInput(input)
                }
            }
            if(self.usingFrontCamera){
                self.captureDevice = self.getFrontCamera()
            }else{
                self.captureDevice = self.getBackCamera()
            }
            if self.captureDevice != nil{
                do{
                    let captureDeviceInput1 = try AVCaptureDeviceInput(device: self.captureDevice)
                    self.captureSession.addInput(captureDeviceInput1)
                }catch{
                    print(error.localizedDescription)
                    self.unableToFindCameraAlert()
                }
            }else{
                self.unableToFindCameraAlert()
            }
        }
    }
    
    func unableToFindCameraAlert(){
        let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        self.showAlert(title: "Alert", message: "Device camera is not configured.", defaultAction: defaultAction)
    }
    
    
    func getFrontCamera() -> AVCaptureDevice?{
        return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices.first ?? nil
    }
    
    func getBackCamera() -> AVCaptureDevice?{
        return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first ?? nil
    }
    
    //MARK:- Camera Session
    func startSession() {
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            orientation = AVCaptureVideoOrientation.portrait
        case .portraitUpsideDown:
            orientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            orientation = AVCaptureVideoOrientation.landscapeRight
        default:
            orientation = AVCaptureVideoOrientation.landscapeLeft
        }
        return orientation
    }
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.previewLayer.connection?.videoOrientation = self.currentVideoOrientation()
            self.imageOutput.connection(with: AVMediaType.video)?.videoOrientation = self.currentVideoOrientation()
            self.previewLayer.frame.size = self.camPreview.frame.size
        }, completion: { (context) -> Void in
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    //EDIT 1: I FORGOT THIS AT FIRST
    func tempURL() -> URL? {
        
        let directory = NSTemporaryDirectory() as NSString
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mov")
            return URL(fileURLWithPath: path)
        }
        return nil
    }
    
    func captureImage(){
        let captureSettings = AVCapturePhotoSettings()
        //        captureSettings.
        let previewPixelType = captureSettings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 300,
                             kCVPixelBufferHeightKey as String: 300,
                             ]
        captureSettings.previewPhotoFormat = previewFormat
        if let photoOutputConnection = self.imageOutput.connection(with: AVMediaType.video) {
            photoOutputConnection.videoOrientation = currentVideoOrientation()
        }
        // For this line
        self.imageOutput.capturePhoto(with: captureSettings, delegate: self)
    }
    
    func startRecording() {
        
        if movieOutput.isRecording == false {
            var connection = movieOutput.connection(with: .video)
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            let device = activeInput.device
            if (device.isSmoothAutoFocusSupported) {
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            self.startTimer()
            
            movieOutput.maxRecordedDuration = CMTime.init(seconds: Double(self.maximumDurationInSeconds),
                                                          preferredTimescale: 30)
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
        }
        else {
            if captureMode == .video{
                stopRecording()
            }
        }
    }
    
    func stopRecording() {
        if movieOutput.isRecording == true {
            self.redDotView.isHidden = true
            self.timeLbl.text = "00:00:00"
            self.timer.invalidate()
            self.movieOutput.stopRecording()
        }
    }
    
    func stopCaptureSession () {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
    }
    
    func showAlert(title: String,
                   message: String,
                   defaultAction: UIAlertAction?=nil){
        
        let alert = UIAlertController.init(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        var okAction = UIAlertAction.init(title: "OK",
                                          style: .default,
                                          handler: nil)
        if defaultAction != nil{
            okAction = defaultAction!
        }
        
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func flashBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.flashImgView.image = UIImage.init(named: (sender.isSelected) ? "flashOn.png" : "flashOff.png")
        do {
            try self.captureDevice.lockForConfiguration()
            defer { self.captureDevice.unlockForConfiguration() }
            
            do {
                try self.captureDevice.setTorchModeOn(level: sender.isSelected ? 1 : 0)
            } catch{
                debugPrint(error)
            }
        } catch{
            debugPrint(error)
        }
        
    }
    
    @IBAction func pinchGesturePinching(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed{
            //            if sender.scale > 0.0 && sender.scale < 1.0{
            //                print("zoom out")
            do {
                try self.captureDevice.lockForConfiguration()
                defer { self.captureDevice.unlockForConfiguration() }
                //                    if sender.scale <= max{
                self.captureDevice.cancelVideoZoomRamp()
                var scale = (sender.scale + 1)
                if sender.scale == 0{
                    scale = sender.scale
                }
                self.captureDevice.ramp(toVideoZoomFactor: scale, withRate: Float(sender.velocity))
                //                    }
            } catch{
                debugPrint(error)
            }
            //            }else{
            //                print("zoom in")
            //                print("zoom out")
            //                do {
            //                    try self.captureDevice.lockForConfiguration()
            //                    defer { self.captureDevice.unlockForConfiguration() }
            //                    self.captureDevice.videoZoomFactor -= 1
            //                } catch{
            //                    debugPrint(error)
            //                }
            //            }
        }
    }
    
    @IBAction func startCapture(_ sender: UIButton) {
        if captureMode == .video{
            self.startRecording()
        }else{
            self.captureImage()
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        if self.delegate != nil{
            self.delegate!.cameraControllerCancelled(self)
        }
    }
    
    @IBAction func changeCameraTapped(_ sender: UIButton) {
        if movieOutput.isRecording{
            self.stopRecording()
        }
        self.changeCamera()
    }
    
}

extension CameraController: AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if (error != nil) {
            if let nsError = error as? NSError{
                if nsError.localizedFailureReason == "The recording reached the maximum allowable length."{
                    self.showAlert(title: "Alert", message: "The recording reached the maximum allowable length.")
                }
            }
            print("Error recording movie: \(error!.localizedDescription)")
        } else {
            
            let urlToSend = outputFileURL.absoluteString.components(separatedBy: "file:///")
            if UIVideoEditorController.canEditVideo(atPath: urlToSend.last!) {
                let editController = UIVideoEditorController()
                editController.videoPath = urlToSend.last!
                editController.videoMaximumDuration = TimeInterval(self.maximumDurationInSeconds)
                editController.delegate = self
                self.present(editController, animated:true)
            }
        }
        
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate{
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?){
        print(photo)
        if let data = photo.fileDataRepresentation(){
            let vc = PreviewImageVC.init(nibName: "PreviewImageVC", bundle: bundle)
            vc.delegate = self
            vc.imageData = data
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension CameraController: PreviewImageVCDelegate{
    
    func imagePickerSelectImage(_ image: UIImage, controller: UIViewController) {
        DispatchQueue.main.async {
            controller.dismiss(animated: true, completion: nil)
        }
        if self.delegate != nil{
            self.delegate!.cameraControllerCapturedImage(image, controller: self)
        }
    }
    
    func imagePickerCanceled(_ controller: UIViewController) {
        DispatchQueue.main.async {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension CameraController : UINavigationControllerDelegate, UIVideoEditorControllerDelegate{
    func videoEditorController(_ editor: UIVideoEditorController,
                               didSaveEditedVideoToPath editedVideoPath: String) {
        print("Success")
        if !isEditedVideoSaved{
            self.isEditedVideoSaved = !self.isEditedVideoSaved
            if delegate != nil{
                let url = URL.init(fileURLWithPath: editedVideoPath)
                self.delegate!.cameraControllerCapturedVideo(url, controller: self)
                
            }
            DispatchQueue.main.async {
                editor.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func videoEditorControllerDidCancel(_ editor: UIVideoEditorController) {
        print("Cancel")
        DispatchQueue.main.async {
            editor.dismiss(animated: true, completion: nil)
        }
    }
    
    func videoEditorController(_ editor: UIVideoEditorController,
                               didFailWithError error: Error) {
        print("an error occurred: \(error.localizedDescription)")
        DispatchQueue.main.async {
            editor.dismiss(animated: true, completion: nil)
        }
    }
}
