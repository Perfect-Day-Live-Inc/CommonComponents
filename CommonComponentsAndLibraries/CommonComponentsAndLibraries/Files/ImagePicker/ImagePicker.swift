//
//  ImagePicker.swift
//  Scholarship
//
//  Created by MacBook Retina on 10/31/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import UIKit
import AssetsLibrary
import Photos
import MobileCoreServices

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class is used to pick image, capture image,
///this class is use to remove redundancy of uiimagepickercontroller,
///the class which implements this, need to implement it's delegate

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

public enum FileType{
    case doc
    case xlx
    case pdf
    case image
    case video
    case message
    case audio
}

enum PickedMediaType{
    case picture
    case movie
}
public struct ImagePickerModel{
    public var image : UIImage? = nil
    public var fileName : String = ""
    public var mimeType : String = ""
    public var url : URL? = nil
    public var fileType : FileType = .image
    public var asset : PHAsset? = nil
}

public protocol ImagePickerDelegate{
    func PickerDidPicked(images: [ImagePickerModel]?, downloadErrorString: String?)
}


extension PHAsset {
    
    func getImage(size: CGSize, completion: @escaping (UIImage?)->Void){
        let options = PHImageRequestOptions()
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        
        options.progressHandler = {  (progress, error, stop, info) in
            print("progress: \(progress)")
        }
        
        PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: PHImageContentMode.aspectFill, options: options, resultHandler: {
            (image, info) in
            completion(image)
        })
    }
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.isNetworkAccessAllowed = true
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.isNetworkAccessAllowed = true
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
}

open class ImagePicker : NSObject{
    private override init() {super.init()}
    static public let getInstance = ImagePicker()
    
    let bundle = Bundle.init(for: CameraController.self)
    public var delegate : ImagePickerDelegate!
    public var imageLimit : Int = 5
    public var fontForPicker = UIFont.systemFont(ofSize: 18)
    public var tintColor = UIColor.black
    public var allowEditing : Bool = false
    
    private var pickerType : UIImagePickerController.SourceType = .camera
    private var sourceVC : UIViewController!
    private var picker = UIImagePickerController()
    private var activityIndicator : UIActivityIndicatorView!
    private var indicatorLbl : UILabel!
    private var indicatorView : UIView!
    private var mainView : UIView!
    private var maximumDurationOfVideoInSeconds = 30.0
    
    public func showPickerController(fromVC : UIViewController,
                                     selectedAssests: [PHAsset]?=nil,
                                     delegateFromVC : ImagePickerDelegate?=nil,
                                     imageLimit : Int?=nil,
                                     isVideo : Bool=false,
                                     maximumDurationInSeconds: TimeInterval=30.0){
        self.maximumDurationOfVideoInSeconds = maximumDurationInSeconds
        self.sourceVC = fromVC
        if delegateFromVC != nil{
            self.delegate = delegateFromVC!
        }else{
            if self.delegate == nil{
                fatalError("Class must have to implement 'ImagePickerDelegate'")
            }
        }
        self.imageLimit = imageLimit ?? self.imageLimit
        self.showImagePicker(selectedAssests: selectedAssests, isVideo: isVideo)
    }
    
    public func showCameraController(fromVC : UIViewController,
                                     delegateFromVC : ImagePickerDelegate?=nil,
                                     imageLimit : Int?=nil,
                                     isVideo : Bool=false,
                                     maximumDurationInSeconds: TimeInterval=30.0){
        self.sourceVC = fromVC
        if delegateFromVC != nil{
            self.delegate = delegateFromVC!
        }else{
            if self.delegate == nil{
                fatalError("Class must have to implement 'ImagePickerDelegate'")
            }
        }
        self.imageLimit = imageLimit ?? self.imageLimit
        if isVideo{
            self.showVideoController(maximumDurationInSeconds: maximumDurationInSeconds,
                                     fromVC: self.sourceVC,
                                     delegateFromVC: self.delegate)
        }else{
            self.openCamera()
        }
    }
    
    private func openCamera(){
        pickerType = .camera
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied ||
            AVCaptureDevice.authorizationStatus(for: .video) == .restricted{
            // The user has not yet been asked for camera access.
            self.presentCameraSettings()
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) && pickerType == .camera{
            picker.sourceType = .camera
        }else if pickerType != .camera{
            picker.sourceType = pickerType
        }
        
        if #available(iOS 11.0, *){
            let vc = CameraController.init(nibName: "CameraController", bundle: bundle)
            vc.captureMode = .picture
            vc.delegate = self
            DispatchQueue.main.async {
                self.sourceVC.present(vc, animated: true, completion: nil)
            }
        }else{
            if pickerType == .camera{
                picker.mediaTypes = [kUTTypeImage as String]
            }
            picker.allowsEditing = self.allowEditing
            picker.delegate = self
            
            self.settingAndPresentPicker(picker: picker)
        }
        
    }
    
    private func showVideoController(maximumDurationInSeconds: TimeInterval=30.0,
                                     fromVC : UIViewController,
                                     delegateFromVC : ImagePickerDelegate){
        pickerType = .camera
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied ||
            AVCaptureDevice.authorizationStatus(for: .video) == .restricted{
            // The user has not yet been asked for camera access.
            self.presentCameraSettings()
            return
        }
        self.sourceVC = fromVC
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        
        
        if #available(iOS 11.0, *){
            let vc = CameraController.init(nibName: "CameraController", bundle: bundle)
            vc.captureMode = .video
            vc.delegate = self
            vc.maximumDurationInSeconds = Int(maximumDurationInSeconds)
            DispatchQueue.main.async {
                self.sourceVC.present(vc, animated: true, completion: nil)
            }
        }else{
            picker.delegate = self
            picker.mediaTypes = [kUTTypeMovie as String]
            
            picker.videoMaximumDuration = maximumDurationInSeconds
            
            picker.allowsEditing = self.allowEditing
            picker.videoQuality = .typeMedium
            
            self.sourceVC = fromVC
            self.delegate = delegateFromVC
            
            self.settingAndPresentPicker(picker: picker)
            
        }
    }
    
    private func showImagePicker(selectedAssests: [PHAsset]?=nil, isVideo: Bool=false){
        
        var config = TatsiConfig.default
        config.showCameraOption = true
        if isVideo {
            config.supportedMediaTypes = [.video]
        }else{
            config.supportedMediaTypes = [.image]
        }
        config.firstView = .userLibrary
        config.maxNumberOfSelections = self.imageLimit
        
        let pickerViewController = TatsiPickerViewController(config: config)
        pickerViewController.pickerDelegate = self
        
        self.settingAndPresentPicker(picker: pickerViewController)
    }
    
    private func settingAndPresentPicker(picker: UINavigationController){
        picker.navigationBar.isTranslucent = false
        picker.navigationBar.backgroundColor = UIColor.white
        picker.navigationBar.tintColor = self.tintColor
        picker.navigationBar.barTintColor = UIColor.white
        picker.navigationBar.isHidden = false
        
        picker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : self.tintColor,
                                                    NSAttributedString.Key.font : self.fontForPicker]
        
        if picker.isBeingPresented{
            print("Controller is already presented")
        }else{
            DispatchQueue.main.async {
                self.sourceVC.present(picker, animated: false, completion: nil)
            }
        }
    }
    
    private func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
            }
        })
        alertController.popoverPresentationController?.sourceView = sourceVC.view
        DispatchQueue.main.async {
            self.sourceVC.present(alertController, animated: true)
        }
    }
    
    private func showAlert(selectedAssests: [PHAsset]?=nil, isVideo : Bool=false){
        var strTitle : String = "Take Photo"
        if isVideo == true{
            strTitle = "Take Video"
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let actionSheet = UIAlertController(title: "Select Option", message: "Select any one option", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: strTitle, style: .default) { (action) in
                self.pickerType = .camera
                if AVCaptureDevice.authorizationStatus(for: .video) == .denied ||
                    AVCaptureDevice.authorizationStatus(for: .video) == .restricted{
                    self.presentCameraSettings()
                }else{
                    if isVideo == true{
                        self.showVideoController(maximumDurationInSeconds: self.maximumDurationOfVideoInSeconds, fromVC: self.sourceVC, delegateFromVC: self.sourceVC as! ImagePickerDelegate)
                    }else{
                        self.openCamera()
                    }
                }
            }
            let galleryAction = UIAlertAction(title: "Choose From Gallery", style: .default) { (action) in
                self.pickerType = .photoLibrary
                self.showImagePicker(selectedAssests: selectedAssests,isVideo: isVideo)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(galleryAction)
            actionSheet.addAction(cancelAction)
            
            actionSheet.view.tintColor = self.tintColor
            actionSheet.popoverPresentationController?.sourceView = sourceVC.view
            actionSheet.popoverPresentationController?.sourceRect = CGRect.init(x: sourceVC.view.center.x,
                                                                                y: sourceVC.view.center.y,
                                                                                width: 0,
                                                                                height: 0)
            DispatchQueue.main.async {
                self.sourceVC.present(actionSheet, animated: true, completion: nil)
            }
        }else{
            self.showImagePicker(selectedAssests: selectedAssests, isVideo: isVideo)
        }
    }
    
}

extension ImagePicker{
    
    private func setupIndicatorViewAndShow(){
        indicatorLbl = UILabel.init(frame: CGRect.init(x: self.sourceVC.view.frame.width * 0.025, y: 60, width: self.sourceVC.view.frame.width * 0.7, height: 30))
        indicatorLbl.text = "Downloading Images From iCloud..."
        indicatorLbl.textColor = .white
        indicatorLbl.minimumScaleFactor = 0.5
        indicatorLbl.font = UIFont.systemFont(ofSize: 14)
        indicatorLbl.textAlignment = .center
        
        activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0,
                                                                            y: 10,
                                                                            width: self.sourceVC.view.frame.width * 0.75,
                                                                            height: 50))
        activityIndicator.color = .white
        activityIndicator.style = .whiteLarge
        
        indicatorView = UIView.init(frame: CGRect.init(x: 0,
                                                       y: 0,
                                                       width: self.sourceVC.view.frame.width * 0.75,
                                                       height: 100))
        
        mainView = UIView.init(frame: CGRect.init(x: 0,
                                                  y: 0,
                                                  width: UIScreen.main.bounds.width,
                                                  height: UIScreen.main.bounds.height))
        
        self.indicatorView.alpha = 1.0
        self.indicatorLbl.alpha = 1.0
        self.activityIndicator.alpha = 1.0
        self.mainView.alpha = 1.0
        
        self.indicatorView.addSubview(activityIndicator)
        self.indicatorView.addSubview(indicatorLbl)
        
        indicatorView.center = self.mainView.center
        
        self.mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        self.mainView.addSubview(self.indicatorView)
        
        self.sourceVC.view.addSubview(self.mainView)
    }
    
    private func hideIndicatorAndDeInit(){
        if self.indicatorView != nil{
            UIView.animate(withDuration: 1.0, animations: {
                self.indicatorView.alpha = 0.0
                self.indicatorLbl.alpha = 0.0
                self.activityIndicator.alpha = 0.0
                self.mainView.alpha = 0.0
            }, completion: { (status) in
                if status {
                    self.indicatorLbl.removeFromSuperview()
                    self.activityIndicator.removeFromSuperview()
                    self.indicatorView.removeFromSuperview()
                    self.mainView.removeFromSuperview()
                    
                    self.indicatorView = nil
                    self.indicatorLbl = nil
                    self.activityIndicator = nil
                    self.mainView = nil
                }
            })
        }
    }
}

extension ImagePicker: CameraControllerDelegate{
    func cameraControllerCancelled(_ controller: UIViewController) {
        DispatchQueue.main.async {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func cameraControllerCapturedVideo(_ videoURL: URL, controller: UIViewController) {
        self.encodeAndSendVideo(videoURL: videoURL, vc: picker)
    }
    
    func cameraControllerCapturedImage(_ image: UIImage, controller: UIViewController) {
        var imageM = ImagePickerModel()
        imageM.fileName = "Image.jpg"
        imageM.fileType = .image
        imageM.image = image
        if delegate != nil{
            self.picker = UIImagePickerController()
            DispatchQueue.main.async {
                controller.dismiss(animated: true, completion: {
                    self.delegate!.PickerDidPicked(images: [imageM], downloadErrorString: nil)
                })
            }
        }
    }
    
    func encodeAndSendVideo(videoURL: URL, vc: UIViewController){
        var imageM = ImagePickerModel()
        imageM.fileName = "video.mov"
        imageM.fileType = .video
        self.encodeVideo(videoURL: videoURL, completion: { (url) in
            if url != nil{
                imageM.fileName = "video.mp4"
                imageM.url = url!
                if self.delegate != nil{
                    DispatchQueue.main.async {
                        self.picker = UIImagePickerController()
                        self.delegate!.PickerDidPicked(images: [imageM], downloadErrorString: nil)
                        vc.dismiss(animated: true, completion: nil)
                    }
                }
                return
            }else{
                imageM.url = videoURL
                if self.delegate != nil{
                    DispatchQueue.main.async {
                        self.picker = UIImagePickerController()
                        self.delegate!.PickerDidPicked(images: [imageM], downloadErrorString: nil)
                        vc.dismiss(animated: true, completion: nil)
                    }
                }
            }
        })
    }
}

extension ImagePicker : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async {
            picker.dismiss(animated: true, completion: nil)
        }
        self.picker = UIImagePickerController()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let videoURL = info[.mediaURL] as? URL{
            self.encodeAndSendVideo(videoURL: videoURL, vc: picker)
        }else{
            var image = ImagePickerModel()
            image.fileName = "image.jpg"
            image.fileType = .image
            
            if #available(iOS 11.0, *) {
                if let imageURL = info[.imageURL] as? URL{
                    image.fileName = imageURL.pathComponents.last!
                    if let asset = info[.phAsset] as? PHAsset{
                        image.asset = asset
                    }
                }
                
                if let editedImage = info[.editedImage] as? UIImage{
                    image.image = editedImage
                }else {
                    if let normalImage = info[.originalImage] as? UIImage{
                        image.image = normalImage
                    }
                }
            }
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                image.image = editedImage
            }else {
                if let normalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    image.image = normalImage
                }
            }
            if delegate != nil{
                DispatchQueue.main.async {
                    picker.dismiss(animated: true, completion: {
                        self.picker = UIImagePickerController()
                        self.delegate!.PickerDidPicked(images: [image], downloadErrorString: nil)
                    })
                }
            }
        }
    }
}

extension ImagePicker : TatsiPickerViewControllerDelegate {
    
    public func pickerViewController(_ pickerViewController: TatsiPickerViewController, didPickAssets assets: [PHAsset]) {
        DispatchQueue.main.async {
            pickerViewController.dismiss(animated: true, completion: nil)
        }
        print("Assets \(assets)")
        print(assets)
        var arrayOfUIImages = [ImagePickerModel]()
        
        for asset in assets{
            if asset.mediaType == .video {
                if asset.duration > self.maximumDurationOfVideoInSeconds{
                    if delegate != nil{
                        self.delegate!.PickerDidPicked(images: arrayOfUIImages, downloadErrorString: "Video should not be greater then \(maximumDurationOfVideoInSeconds) sec.")
                        return
                    }
                }
            }
        }
        DispatchQueue.main.async {
            if self.indicatorView == nil{
                self.setupIndicatorViewAndShow()
            }
            self.activityIndicator.startAnimating()
        }
        var downloadErrorValue = 0
        var value = 0{
            didSet {
                if value == 0{
                    DispatchQueue.main.async {
                        if self.indicatorView != nil{
                            self.activityIndicator.stopAnimating()
                            self.hideIndicatorAndDeInit()
                        }
                    }
                    if delegate != nil{
                        if downloadErrorValue != 0{
                            self.delegate!.PickerDidPicked(images: arrayOfUIImages, downloadErrorString: "One or more image(s) are not downloaded successfully.")
                        }else{
                            if arrayOfUIImages.count != 0{
                                self.delegate!.PickerDidPicked(images: arrayOfUIImages, downloadErrorString: nil)
                            }else{
                                self.delegate!.PickerDidPicked(images: nil, downloadErrorString: "Unable to download image(s) from iCloud.")
                            }
                        }
                    }
                }
            }
        }
        for asset in assets{
            value += 1
            if asset.mediaType == .video {
                
                asset.getURL(completionHandler: { (url) in
                    if url != nil{
                        var imageM = ImagePickerModel()
                        imageM.fileType = .video
                        imageM.fileName = asset.value(forKey: "filename") as? String ?? "video.mp4"
                        imageM.image = nil
                        imageM.asset = asset
                        imageM.url = url
                        arrayOfUIImages.append(imageM)
                        value -= 1
                    }else{
                        value -= 1
                        downloadErrorValue += 1
                    }
                })
            }else{
                asset.getImage(size: CGSize(width: 300, height: 300), completion: { (image) in
                    if image != nil{
                        var imageM = ImagePickerModel()
                        imageM.fileType = .image
                        imageM.fileName = asset.value(forKey: "filename") as? String ?? "image.jpg"
                        imageM.image = image
                        imageM.asset = asset
                        arrayOfUIImages.append(imageM)
                        value -= 1
                    }else{
                        value -= 1
                        downloadErrorValue += 1
                    }
                })
            }
        }
    }
    
}

extension ImagePicker{
    
    func encodeVideo(videoURL: URL, completion: @escaping (URL?) -> Void){
        let avAsset = AVURLAsset(url: videoURL)
        let startDate = Date()
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough)
        
        let docDir2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        
        let filePath = docDir2.appendingPathComponent("\(UUID().uuidString).mp4")
        deleteFile(filePath!)
        
        exportSession?.outputURL = filePath
        exportSession?.outputFileType = AVFileType.mp4
        exportSession?.shouldOptimizeForNetworkUse = true
        
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRange(start: start, duration: avAsset.duration)
        exportSession?.timeRange = range
        
        exportSession!.exportAsynchronously{() -> Void in
            switch exportSession!.status{
            case .failed:
                print("\(exportSession!.error!)")
                completion(nil)
            case .cancelled:
                print("Export cancelled")
                completion(nil)
            case .completed:
                let endDate = Date()
                let time = endDate.timeIntervalSince(startDate)
                print(time)
                print("Successful")
                print(exportSession!.outputURL ?? "")
                completion(exportSession!.outputURL)
            default:
                completion(nil)
                break
            }
            
        }
    }
    
    func deleteFile(_ filePath:URL) {
        guard FileManager.default.fileExists(atPath: filePath.path) else{
            return
        }
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
        }catch{
            fatalError("Unable to delete file: \(error) : \(#function).")
        }
    }
    
}

