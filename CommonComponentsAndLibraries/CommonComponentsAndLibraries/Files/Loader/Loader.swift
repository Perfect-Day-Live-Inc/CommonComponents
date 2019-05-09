//
//  Loader.swift
//  BHRN
//
//  Created by Muhammad Ahmed Baig on 26/08/2017.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import Swift
import UIKit


//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This is the loader which are using in whole application

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
open class Loader {
    private init(){setUIComponents()}
    
    private static let instance = Loader()
    
    static public func getInstance() -> Loader{
        return instance
    }
    
    private var activityIndicatorView : DGActivityIndicatorView!
    private var viewForActivity = UIView()
    private var TxtLbl = UILabel()
    private var timer = Timer()
    
    
    public var loaderColor: UIColor = .white
    public var textColor: UIColor = .white
    public var loaderType : DGActivityIndicatorAnimationType = .ballSpinFadeLoader
    public var loaderSize : CGFloat = 50.0
    
    private func setUpLoader(inView: UIView,
                             loaderColor: UIColor?=nil,
                             txtToShow: String?=nil,
                             txtColor: UIColor?=nil,
                             loaderType : DGActivityIndicatorAnimationType?=nil){

        self.viewForActivity.isHidden = false
        self.activityIndicatorView.isHidden = false
        if txtToShow != nil{
            self.TxtLbl.isHidden = false
        }
        
        if loaderColor == nil{
            self.activityIndicatorView.tintColor = self.loaderColor
        }else{
            self.activityIndicatorView.tintColor = loaderColor!
        }
        
        if loaderType == nil{
            self.activityIndicatorView.type = self.loaderType
        }else{
            self.activityIndicatorView.type = loaderType!
        }
        
        UIView.animate(withDuration: 1.0) {
            self.viewForActivity.alpha = 1.0
            self.activityIndicatorView.alpha = 1.0
            if txtToShow != nil{
                self.TxtLbl.alpha = 1.0
            }
        }
        if txtToShow != nil{
            self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
            self.viewForActivity.addSubview(self.TxtLbl)
        }
        self.viewForActivity.frame = inView.bounds
        self.activityIndicatorView.center = self.viewForActivity.center
        self.viewForActivity.addSubview(self.activityIndicatorView)
        
        if txtToShow != nil{
            self.TxtLbl.frame = CGRect(x: 20, y: self.activityIndicatorView.frame.maxY + 10, width: inView.bounds.width - 40, height: 50)
            self.TxtLbl.text = txtToShow!
            self.TxtLbl.textAlignment = .center
            if txtColor == nil{
                self.TxtLbl.textColor = self.textColor
            }else{
                self.TxtLbl.textColor = txtColor!
            }
        }
        inView.addSubview(self.viewForActivity)
        inView.bringSubviewToFront(self.viewForActivity)
    }
    
    public func showLoader(inView: UIView,
                           loaderColor: UIColor?=nil,
                           txtToShow: String?=nil,
                           txtColor: UIColor?=nil,
                           loaderType : DGActivityIndicatorAnimationType?=nil){
        setUpLoader(inView: inView, loaderColor: loaderColor, txtToShow: txtToShow, txtColor: txtColor, loaderType: loaderType)
        activityIndicatorView.startAnimating()
    }
    
    func setUIComponents(){
        self.activityIndicatorView = DGActivityIndicatorView(type: .ballSpinFadeLoader, tintColor: self.loaderColor, size: 50)
        self.activityIndicatorView.bounds = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        self.TxtLbl.bounds = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        viewForActivity.backgroundColor = UIColor.clear
        TxtLbl.backgroundColor = UIColor.clear
        self.viewForActivity.alpha = 0
        self.TxtLbl.alpha = 0
    }
    
    public func hideLoader(inView: UIView){
        if activityIndicatorView != nil{
            activityIndicatorView.stopAnimating()
            self.timer.invalidate()
            if(inView.subviews.contains(self.viewForActivity)){
                UIView.animate(withDuration: 1.0, animations: {
                    self.viewForActivity.alpha = 0.0
                    self.activityIndicatorView.alpha = 0.0
                    self.TxtLbl.alpha = 0.0
                }, completion: { (status) in
                    if status {
                        self.activityIndicatorView.isHidden = true
                        self.viewForActivity.isHidden = true
                        self.TxtLbl.isHidden = true
                        self.TxtLbl.removeFromSuperview()
                        self.activityIndicatorView.removeFromSuperview()
                        self.viewForActivity.removeFromSuperview()
                    }
                })
            }
//            else{
//                if let mainWindow = UIApplication.shared.keyWindow {
//                    if mainWindow.subviews.contains(self.viewForActivity){
//                        UIView.animate(withDuration: 1.0, animations: {
//                            self.viewForActivity.alpha = 0.0
//                            self.activityIndicatorView.alpha = 0.0
//                            self.TxtLbl.alpha = 0.0
//                        }, completion: { (status) in
//                            if status {
//                                self.activityIndicatorView.isHidden = true
//                                self.viewForActivity.isHidden = true
//                                self.TxtLbl.isHidden = true
//                                self.TxtLbl.removeFromSuperview()
//                                self.activityIndicatorView.removeFromSuperview()
//                                self.viewForActivity.removeFromSuperview()
//                            }
//                        })
//                    }
//                }
//            }
        }
    }
    
    @objc func timeUpdate(){
        if !self.TxtLbl.isHidden && self.TxtLbl.text != nil{
            if self.TxtLbl.text!.contains("..."){
                self.TxtLbl.text = self.TxtLbl.text!.components(separatedBy: "...").first!
            }else if self.TxtLbl.text!.contains(".."){
                self.TxtLbl.text = self.TxtLbl.text! + "."
            }else if self.TxtLbl.text!.contains("."){
                self.TxtLbl.text = self.TxtLbl.text! + "."
            }else{
                self.TxtLbl.text = self.TxtLbl.text! + "."
            }
        }else{
            self.timer.invalidate()
        }
    }
}
