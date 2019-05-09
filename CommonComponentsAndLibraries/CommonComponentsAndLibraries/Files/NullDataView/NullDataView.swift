//
//  NullDataView.swift
//  
//
//  Created by Muhammad Ahmed Baig on 31/01/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import Swift
import UIKit

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class has set null data view if there is not data available then specific null data view will show

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

open class NullDataView{
    private init() {}
    
    private static let instance = NullDataView()
    
    static public func getInstance() -> NullDataView{
        return instance
    }
    
    var nullImage : UIImageView = UIImageView()
    var alertLbl : UILabel = UILabel()
    var backView = UIView()
    var backViewBtn = UIButton()
    
    var tapToRetry : UILabel = UILabel()
    
    public var defaultImage : UIImage? = nil
    
    private func setUpView(inView: UIView,
                           textToShow: String,
                           textColor: UIColor=UIColor.black,
                           textFont: UIFont=UIFont.systemFont(ofSize: 14),
                           image: UIImage?=nil,
                           tapAction: Selector?=nil,
                           tapToRetryTxt: String){
        self.setNullView()
        self.alertLbl.text = textToShow
        self.alertLbl.textColor = textColor
        self.alertLbl.font = textFont
        let labelSizeWithFixedWith = CGSize(width: inView.bounds.width * 0.65, height: CGFloat.greatestFiniteMagnitude)
        var exactLabelsize = self.alertLbl.sizeThatFits(labelSizeWithFixedWith)
        (exactLabelsize.height > 120) ? (exactLabelsize.height = 120) : (exactLabelsize.height = exactLabelsize.height)
        ///
        self.backView.frame = inView.bounds//CGRect(x: inView.bounds.origin.x, y: inView.bounds.origin.y, width: inView.bounds.width, height: inView.bounds.height)
        //
        self.backViewBtn.frame = self.backView.frame
        self.backViewBtn.setTitle("", for: .normal)
        if tapAction != nil{
            self.backViewBtn.addTarget(nil, action: tapAction!, for: .touchUpInside)
        }
        
        self.alertLbl.backgroundColor = .yellow
        
        //
        
        if image != nil{
            self.nullImage.backgroundColor = UIColor.green
            self.nullImage = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: inView.bounds.width * 0.5, height: inView.bounds.height * 0.3)))
            self.nullImage.image = image
            self.nullImage.contentMode = .scaleAspectFit
            
            if tapAction != nil{
                self.nullImage.center = CGPoint(x: self.backView.center.x, y: (self.backView.center.y-((exactLabelsize.height/2) + 35)))
            }else{
                self.nullImage.center = CGPoint(x: self.backView.center.x, y: (self.backView.center.y-((exactLabelsize.height/2) + 10)))
            }
            self.backView.addSubview(self.nullImage)
        }
        ////
        self.alertLbl.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: exactLabelsize)
        if image != nil{
            self.alertLbl.center = CGPoint(x: self.nullImage.center.x, y: (self.nullImage.center.y) +  (nullImage.bounds.height / 2) + 10)
        }else{
            self.alertLbl.center = backView.center
        }
        
        if tapAction != nil{
            self.tapToRetry.text = tapToRetryTxt
            self.tapToRetry.frame = CGRect.init(x: 0, y: 0, width: self.alertLbl.frame.width, height: 30)
            self.tapToRetry.center = CGPoint.init(x: self.alertLbl.center.x, y: self.alertLbl.center.y + (self.alertLbl.bounds.height/2) + 30)
        }
        
        self.backView.addSubview(self.tapToRetry)
        self.backView.addSubview(self.alertLbl)
        ////
        self.backView.addSubview(self.backViewBtn)
        inView.layoutIfNeeded()
        self.backView.layer.masksToBounds = true
        self.alertLbl.isHidden = false
        if image != nil{
            self.nullImage.isHidden = false
        }
        if tapAction != nil{
            self.tapToRetry.isHidden = false
        }
        self.backView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alertLbl.alpha = 1.0
            if image != nil{
                self.nullImage.alpha = 1.0
            }
            if tapAction != nil{
                self.tapToRetry.alpha = 1.0
            }
            self.backView.alpha = 1.0
            inView.addSubview(self.backView)
            inView.bringSubviewToFront(self.backView)
            
        }
    }
    
    public func showNullView(inView: UIView,
                             textToShow: String,
                             textColor: UIColor=UIColor.black,
                             textFont: UIFont=UIFont.systemFont(ofSize: 14),
                             imageToShow: UIImage?=nil,
                             tapAction: Selector?=nil,
                             tapToRetryTxt: String?=nil){
        if(!inView.subviews.contains(self.backView)){
            if let mainWindow = UIApplication.shared.keyWindow {
                if !mainWindow.subviews.contains(self.backView){
                    DispatchQueue.main.async {
                        self.setUpView(inView: inView,
                                       textToShow: textToShow,
                                       textColor: textColor,
                                       textFont: textFont,
                                       image: imageToShow ?? self.defaultImage,
                                       tapAction: tapAction,
                                       tapToRetryTxt: tapToRetryTxt ?? "Tap to retry")
                    }
                }
            }
        }else{
            self.backView.removeFromSuperview()
            self.showNullView(inView: inView,
                              textToShow: textToShow,
                              textColor: textColor,
                              textFont: textFont,
                              imageToShow: imageToShow ?? self.defaultImage,
                              tapAction: tapAction,
                              tapToRetryTxt: tapToRetryTxt ?? "Tap to retry")
        }
    }
    
    private func setNullView(){
        self.backView.backgroundColor = UIColor.white
        self.alertLbl.textColor = UIColor.black
        self.alertLbl.numberOfLines = 0
        self.alertLbl.font = self.alertLbl.font.withSize(14)
        self.alertLbl.textAlignment = .center
        self.nullImage.alpha = 0
        self.alertLbl.alpha = 0
        self.backView.alpha = 0
        
        self.tapToRetry.text = "Tap to retry"
        self.tapToRetry.textColor = UIColor.darkGray
        self.tapToRetry.font = UIFont.italicSystemFont(ofSize: 13)
        self.tapToRetry.textAlignment = .center
        self.tapToRetry.alpha = 0
    }
    
    public func hideNullView(inView: UIView){
        if(inView.subviews.contains(self.backView)){
            UIView.animate(withDuration: 0.6, animations: {
                self.nullImage.alpha = 0.0
                self.alertLbl.alpha = 0.0
                self.backView.alpha = 0.0
                self.tapToRetry.alpha = 0.0
            }, completion: { (status) in
                if status {
                    self.nullImage.isHidden = true
                    self.alertLbl.isHidden = true
                    self.backView.isHidden = true
                    self.tapToRetry.isHidden = true
                    self.backView.removeFromSuperview()
                }
            })
        }
    }
    
}
