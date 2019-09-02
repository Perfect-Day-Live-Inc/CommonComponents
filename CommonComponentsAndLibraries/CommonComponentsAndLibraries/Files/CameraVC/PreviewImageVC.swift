//
//  PreviewImageVC.swift
//  CameraVC
//
//  Created by Appiskey's iOS Dev on 28/08/2019.
//  Copyright © 2019 Appiskey. All rights reserved.
//

import UIKit

protocol PreviewImageVCDelegate {
    func imagePickerSelectImage(_ image: UIImage, controller: UIViewController)
    func imagePickerCanceled(_ controller: UIViewController)
}

class PreviewImageVC: UIViewController {

    let bundle = Bundle.init(for: CameraController.self)
    @IBOutlet weak var rightBBtn: UIButton!
    @IBOutlet weak var leftBBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate : PreviewImageVCDelegate!
    var imageData : Data!
    var imageToShow : UIImage!{
        didSet{
            self.imageView.image = imageToShow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let image = UIImage.init(data: imageData){
            self.imageToShow = image
        }
    }
    
    @IBAction func rightBBtnTapped(_ sender: UIButton){
        if delegate != nil{
            delegate!.imagePickerSelectImage(self.imageToShow, controller: self)
        }
    }
    
    @IBAction func leftBBtnTapped(_ sender: UIButton){
        if delegate != nil{
            delegate!.imagePickerCanceled(self)
        }
    }
    
}
