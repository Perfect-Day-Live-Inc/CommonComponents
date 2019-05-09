//
//  ImageViewer.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 02/11/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


enum MediaType{
    case image
    case video
    case invalid
    case unknown
}

enum MediaStatus{
    case downloaded
    case downloading
    case stillWait
}

struct Media{
    var path: String
    var type: MediaType
    var status: MediaStatus
    var thumbImage: UIImage?
    var erroMsg: String?
}

class MediaDownloader{
    
    static func downloadImage(with url: URL, index: Int, completion: @escaping ((UIImage?, MediaType, Int, Error?)->Void)) {
        
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: url) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                completion(nil, MediaType.unknown, index, error)
                
            } else {
                
                if let mimeType = response?.mimeType{
                    if mimeType.contains("image"){
                        if (response as? HTTPURLResponse) != nil {
                            
                            //checking if the response contains an image
                            if let imageData = data {
                                
                                //getting the image
                                let image = UIImage(data: imageData)
                                
                                //displaying the image
                                completion(image, MediaType.image, index, nil)
                                
                            } else {
                                completion(nil, MediaType.image, index, nil)
                            }
                        } else {
                            completion(nil, MediaType.image, index, nil)
                        }
                    }else{
                        completion(nil, MediaType.video, index, nil)
                    }
                }else{
                    completion(nil, MediaType.invalid, index, nil)
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
    }
    
    
    static func getVideoThumbImage(url: URL, index: Int, size: CGSize, completion: @escaping (UIImage?, Int, Error?)->Void){
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        DispatchQueue.main.async {
            assetImgGenerate.maximumSize = size
        }
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 30)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            DispatchQueue.main.async {
                completion(UIImage(cgImage: img), index, nil)
            }
        } catch {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                completion(nil, index, error)
            }
        }
    }

}

open class ImageViewer: UIViewController {

    public init(){
        super.init(nibName: "ImageViewer", bundle: bundle)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ImageViewer", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var crossBtn: UIButton!
    
    let bundle = Bundle.init(for: ImageViewer.self)
    
    open var mediaPaths : [String] = []
    var mediaArray = [Media]()
    private var sizeOfVideo : CGSize!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sizeOfVideo = CGSize.init(width: self.view.frame.width, height: self.view.frame.height * 0.25)
        self.pageControl.numberOfPages = self.mediaPaths.count
        self.pageControl.hidesForSinglePage = true
        self.collectionView.register(UINib(nibName: "ViewerCVC", bundle: bundle), forCellWithReuseIdentifier: "ViewerCVC")
        self.settingData()
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingData(){
        for image in mediaPaths{
            self.mediaArray.append(Media.init(path: image,
                                              type: MediaType.unknown,
                                              status: MediaStatus.stillWait,
                                              thumbImage: nil,
                                              erroMsg: nil))
        }
        if self.mediaArray.count > 0{
            self.downloadMedia(at: 0)
        }
        self.collectionView.reloadData()
    }
    
    func downloadMedia(at Index: Int){
        self.mediaArray[Index].status = .downloading
        if let mediaURL = URL.init(string: self.mediaArray[Index].path){
            if self.mediaArray[Index].type == .video{
                DispatchQueue.global(qos: .background).async {
                    MediaDownloader.getVideoThumbImage(url: mediaURL,
                                                       index: Index,
                                                       size: self.sizeOfVideo,
                                                       completion: { (image, index, error)  in
                                                        self.mediaArray[index].status = .downloaded
                                                        if error != nil{
                                                            if error!.localizedDescription.lowercased().contains("The operation could not be completed".lowercased()){
                                                                self.mediaArray[index].status = .stillWait
                                                            }else{
                                                                self.mediaArray[index].erroMsg = "Unable to download image from this specific URL"
                                                            }
                                                            print("error while downloading video thumb: ", error!)
                                                            DispatchQueue.main.async {
                                                                self.collectionView.reloadItems(at: [IndexPath.init(row: index, section: 0)])
                                                            }
                                                            return
                                                        }
                                                        if image != nil{
                                                            self.mediaArray[index].thumbImage = image!
                                                            DispatchQueue.main.async {
                                                                self.collectionView.reloadItems(at: [IndexPath.init(row: index, section: 0)])
                                                            }
                                                        }
                    })
                }
            }else{
                DispatchQueue.global(qos: .background).async {
                    MediaDownloader.downloadImage(with: mediaURL, index: Index) { (image, type, index, error)  in
                        if error == nil{
                            self.mediaArray[index].type = type
                            if image != nil{
                                self.mediaArray[index].status = .downloaded
                                self.mediaArray[index].thumbImage = image!
                                DispatchQueue.main.async {
                                    self.collectionView.reloadItems(at: [IndexPath.init(row: index, section: 0)])
                                }
                            }else if type == .video{
                                self.downloadMedia(at: index)
                            }
                        }else{
                            self.mediaArray[index].erroMsg = error!.localizedDescription
                            DispatchQueue.main.async {
                                self.collectionView.reloadItems(at: [IndexPath.init(row: index, section: 0)])
                            }
                            return
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func crossBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    public static func presentImageViewer(with mediaPaths: [String]){
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController{
            let imageVC = ImageViewer(nibName: "ImageViewer", bundle: Bundle.init(for: ImageViewer.self))//AppRouter.ImageViewerVC()
            var pathsToSave : [String] = mediaPaths
            
            if pathsToSave.count == 0{
                fatalError("mediaPaths must not be empty")
            }
            
            pathsToSave.removeAll { (str) -> Bool in
                return str == ""
            }
            
            imageVC.mediaPaths = pathsToSave
            imageVC.providesPresentationContextTransitionStyle = true
            imageVC.definesPresentationContext = true
            imageVC.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
            imageVC.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                rootVC.present(imageVC, animated: true, completion: nil)
            }
        }
    }
    
    public func setImagesPath(paths: [String]){
        var pathsToSave : [String] = paths
        
        if pathsToSave.count == 0{
            fatalError("mediaPaths must not be empty")
        }
        
        pathsToSave.removeAll { (str) -> Bool in
            return str == ""
        }
        
        self.mediaPaths = pathsToSave
    }
    
    public func showImageViewer(){
        if mediaPaths.count == 0{
            fatalError("mediaPaths must not be empty")
        }
        
        mediaPaths.removeAll { (str) -> Bool in
            return str == ""
        }
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController{
            self.providesPresentationContextTransitionStyle = true
            self.definesPresentationContext = true
            self.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
            self.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                rootVC.present(self, animated: true, completion: nil)
            }
        }
    }
    
}

extension ImageViewer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mediaArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewerCVC", for: indexPath) as! ViewerCVC
        cell.index = indexPath.item
        cell.delegate = self
        cell.setData(media: self.mediaArray[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionView.frame.height)
    }
}

extension ImageViewer: UIScrollViewDelegate{
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        if self.mediaArray.count > pageControl.currentPage{
            switch self.mediaArray[pageControl.currentPage].status {
            case .stillWait:
                self.downloadMedia(at: pageControl.currentPage)
                break
            case .downloading:
                break
            default:
                break
            }
        }
    }
}

extension ImageViewer: ViewerCVCDelegate{
    func playBtnTapped(at Index: Int) {
        let videoURL = URL(string: self.mediaPaths[Index])
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func dismissImageViewer() {
        self.dismiss(animated: false, completion: nil)
    }
}
