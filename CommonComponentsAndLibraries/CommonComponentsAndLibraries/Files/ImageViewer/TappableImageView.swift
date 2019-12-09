//
//  TappableImageView.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 02/11/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

class TappableImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imagesPath : [String]? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImage))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func openImage(){
        if self.imagesPath != nil{
            if let rootVC = UIApplication.getTopViewController(){
                let bundle = Bundle.init(for: ImageViewer.self)
                let imageVC = ImageViewer(nibName: "ImageViewer", bundle: bundle)//AppRouter.ImageViewerVC()
                imageVC.mediaPaths = self.imagesPath!
                imageVC.providesPresentationContextTransitionStyle = true
                imageVC.definesPresentationContext = true
                imageVC.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
                imageVC.modalTransitionStyle = .crossDissolve
                DispatchQueue.main.async {
                    rootVC.present(imageVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    func setAllImages(path: [String]){
        self.imagesPath = path
    }

}
