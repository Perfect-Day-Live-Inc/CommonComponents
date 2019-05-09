//
//  ProgressView.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 05/11/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import UIKit

open class ProgressBarView{
    private init() {}
    
    private static let instance = ProgressBarView()
    
    static public func getInstance() -> ProgressBarView{
        return instance
    }
    
    private var progressView : UIProgressView? = nil
    
    open func showProgressView(inView: UIView,
                               progressBarColor: UIColor=UIColor.black){
        if progressView  == nil{
            progressView = UIProgressView()
        }
        let pSetX : CGFloat = 0.0
        let pSetY : CGFloat = 0.0
        let pSetWidth = inView.frame.width
        let pSetHight : CGFloat  = 2.0
        
        progressView!.frame = CGRect(x: pSetX, y: pSetY, width: pSetWidth, height: pSetHight)
        progressView!.progressViewStyle = .default
        progressView!.trackTintColor = progressBarColor.withAlphaComponent(0.6)//ColorConstant.AppLightOrangeColor.withAlphaComponent(0.6)
        progressView!.progressTintColor = progressBarColor.withAlphaComponent(1.0)//ColorConstant.AppOrangeColor.withAlphaComponent(1.0)
        
        inView.addSubview(progressView!)
        inView.bringSubviewToFront(progressView!)
        self.setTimer()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func setTimer(){
        if progressView != nil{
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
                if self.progressView!.progress >= 0.75 {
                    timer.invalidate()
                }
                self.progressView!.setProgress(self.progressView!.progress + 0.1, animated: true)
            })
        }else{
            
        }
    }
    
    open func updateProgressValue(value: Float){
        if progressView  != nil{
            progressView!.setProgress(value, animated: true)
        }
    }
    
    open func hideProgressView(inView: UIView){
        if progressView != nil{
            if(inView.subviews.contains(self.progressView!)){
                progressView!.setProgress(1, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    UIView.animate(withDuration: 1.0, animations: {
                        self.progressView!.alpha = 0.0
                    }, completion: { (status) in
                        if status {
                            self.progressView!.isHidden = true
                            self.progressView = nil
                            UIApplication.shared.endIgnoringInteractionEvents()
                        }
                    })
                })
            }
        }
    }
}
