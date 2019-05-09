//
//  ToastView.swift
//  InvisibleGuardian
//
//  Created by MacBook Retina on 10/13/17.
//  Copyright © 2017 M. Arqam Owais. All rights reserved.
//

import Foundation
import Swift
import UIKit

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class will set and show Toastview for whole app

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
open class ToastView{
    private init() {}
    
    private static let instance = ToastView()
    
    static public func getInstance() -> ToastView{
        return instance
    }
    
    var ToastLbl : UILabel = UILabel()
    var backView = UIView()
    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    public var textColor: UIColor = UIColor.white
    //    private var lbl : UILabel!
    private func setUpToast(inView: UIView,
                            textToShow: String,
                            backgroundColor: UIColor?=nil,
                            textColor: UIColor?=nil){
        self.setToast()
        if backgroundColor != nil{
            self.backView.backgroundColor = backgroundColor!
        }
        if textColor != nil{
            self.ToastLbl.textColor = textColor!
        }
        
        if let mainWindow = UIApplication.shared.keyWindow {
            
            self.ToastLbl.text = textToShow
            let labelSizeWithFixedWith = CGSize(width: mainWindow.bounds.width * 0.4, height: CGFloat.greatestFiniteMagnitude)
            var exactLabelsize = self.ToastLbl.sizeThatFits(labelSizeWithFixedWith)
            (exactLabelsize.height > 120) ? (exactLabelsize.height = 120) : (exactLabelsize.height = exactLabelsize.height)
            self.ToastLbl.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: exactLabelsize)
            self.backView.frame = CGRect(x: UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height - 120, width: mainWindow.bounds.width * 0.5, height: exactLabelsize.height * 1.4)
            self.ToastLbl.center = CGPoint(x: self.backView.bounds.width / 2, y: self.backView.bounds.height / 2)
            self.backView.addSubview(self.ToastLbl)
            mainWindow.layoutIfNeeded()
            self.backView.layer.masksToBounds = true
            self.ToastLbl.isHidden = false
            self.backView.isHidden = false
            UIView.animate(withDuration: 0.6) {
                self.ToastLbl.alpha = 1.0
                self.backView.alpha = 1.0
                mainWindow.addSubview(self.backView)
                mainWindow.bringSubviewToFront(self.backView)
            }

        }else {
            self.ToastLbl.text = textToShow
            let labelSizeWithFixedWith = CGSize(width: inView.bounds.width * 0.4, height: CGFloat.greatestFiniteMagnitude)
            var exactLabelsize = self.ToastLbl.sizeThatFits(labelSizeWithFixedWith)
            (exactLabelsize.height > 120) ? (exactLabelsize.height = 120) : (exactLabelsize.height = exactLabelsize.height)
            self.ToastLbl.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: exactLabelsize)
            self.backView.frame = CGRect(x: UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height - 120, width: inView.bounds.width * 0.5, height: exactLabelsize.height * 1.4)
            self.ToastLbl.center = CGPoint(x: self.backView.bounds.width / 2, y: self.backView.bounds.height / 2)
            self.backView.addSubview(self.ToastLbl)
            inView.layoutIfNeeded()
            self.backView.layer.masksToBounds = true
            self.ToastLbl.isHidden = false
            self.backView.isHidden = false
            UIView.animate(withDuration: 0.6) {
                self.ToastLbl.alpha = 1.0
                self.backView.alpha = 1.0
                inView.addSubview(self.backView)
                inView.bringSubviewToFront(self.backView)
                
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.hideLoader(inView: inView)
        })
    }
    
    public func setUpColors(backgroundColor: UIColor,
                            textColor: UIColor){
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public func showToast(inView: UIView,
                          textToShow: String,
                          backgroundColor: UIColor?=nil,
                          textColor: UIColor?=nil){
        //        setUpLoader(inView: inView)
//        self.hideLoader(inView: inView)
        setUpToast(inView: inView,
                   textToShow: textToShow,
                   backgroundColor: backgroundColor,
                   textColor: textColor)
    }
    
    private func setToast(){
        self.backView.backgroundColor = self.backgroundColor
        self.ToastLbl.textColor = self.textColor
        self.ToastLbl.alpha = 0
        self.backView.alpha = 0
        self.ToastLbl.numberOfLines = 0
        self.ToastLbl.font = self.ToastLbl.font.withSize(12)
        self.ToastLbl.textAlignment = .center
        self.backView.layer.cornerRadius = 5.0
    }
    
    private func hide(inView: UIView){
        if(inView.subviews.contains(self.backView)){
            self.backView.alpha = 0.0
            self.ToastLbl.alpha = 0.0
            self.ToastLbl.isHidden = true
            self.backView.isHidden = true
            self.ToastLbl.removeFromSuperview()
            self.backView.removeFromSuperview()
        }else{
            if let mainWindow = UIApplication.shared.keyWindow {
                if mainWindow.subviews.contains(self.backView){
                    self.backView.alpha = 0.0
                    self.ToastLbl.alpha = 0.0
                    self.ToastLbl.isHidden = true
                    self.backView.isHidden = true
                    self.ToastLbl.removeFromSuperview()
                    self.backView.removeFromSuperview()
                }
            }
        }
    }
    
    public func hideLoader(inView: UIView){
        if(inView.subviews.contains(self.backView)){
            UIView.animate(withDuration: 0.2, animations: {
                self.backView.alpha = 0.0
                self.ToastLbl.alpha = 0.0
            }, completion: { (status) in
                if status {
                    self.ToastLbl.isHidden = true
                    self.backView.isHidden = true
                    self.ToastLbl.removeFromSuperview()
                    self.backView.removeFromSuperview()
                }
            })
        }else{
            if let mainWindow = UIApplication.shared.keyWindow {
                if mainWindow.subviews.contains(self.backView){
                    UIView.animate(withDuration: 0.2, animations: {
                        self.backView.alpha = 0.0
                        self.ToastLbl.alpha = 0.0
                    }, completion: { (status) in
                        if status {
                            self.ToastLbl.isHidden = true
                            self.backView.isHidden = true
                            self.ToastLbl.removeFromSuperview()
                            self.backView.removeFromSuperview()
                        }
                    })
                }
            }
        }
    }

}
