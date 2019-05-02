//
//  Animations.swift
//  InventoryMeApp
//
//  Created by Muhammad Ahmed Baig on 02/01/2019.
//  Copyright © 2019 Appiskey. All rights reserved.
//

import Foundation
import UIKit
import Swift

class Animations {
    private init() {}
    private static let instanceOfClass = Animations()
    static func shared() -> Animations { return instanceOfClass  }
    
    func rotateViewTo45Degree(viewToRotate view: UIView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: Double.pi / 4)
        rotation.duration = 4.0
//        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        view.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func tanslateViewAnimation(view: UIView,
                              finalFrame: CGRect,
                              initalFrame: CGRect,
                              initalAlpha: CGFloat,
                              finalAlpha: CGFloat,
                              duration: TimeInterval)
    {
        view.alpha = initalAlpha
        view.frame = initalFrame
        
        UIView.animate(withDuration: duration, animations: {
            view.alpha = finalAlpha
            view.frame = finalFrame
        }) { _ in
//            view.transform = .identity
            view.frame = finalFrame
        }
    }
    
    func scaleViewAnimation(view: UIView,
                           scaleInitialX: CGFloat,
                           scaleFinalX: CGFloat,
                           scaleInitialY: CGFloat,
                           scaleFinalY: CGFloat,
                           initalAlpha: CGFloat,
                           finalAlpha: CGFloat,
                           duration: TimeInterval)
    {
        view.alpha = initalAlpha
        let initalScale = CGAffineTransform(scaleX: scaleInitialX, y: scaleInitialY)
        view.transform = initalScale
        
        UIView.animate(withDuration: duration) {
            view.alpha = finalAlpha
            view.transform = CGAffineTransform(scaleX: scaleFinalX, y: scaleFinalY)
        }
    }
    
    func translateAndThenScaleView(viewToAnimate: UIView, scaleX: CGFloat, scaleY: CGFloat, translationX: CGFloat, translationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        let scaledTransform = originalTransform.translatedBy(x: translationX, y: translationY)
        let scaledAndTranslatedTransform = scaledTransform.scaledBy(x: scaleX, y: scaleY)
        UIView.animate(withDuration: 0.7, animations: {
            viewToAnimate.transform = scaledAndTranslatedTransform
        }) { (isSuccess) in
            if completion != nil{
                completion!()
            }
        }
//        UIView.animate(withDuration: 0.7, animations: {
//            viewToAnimate.transform = scaledAndTranslatedTransform
//            completion!()
//        })
    }
    
    
    func bounceAnimationToView(viewToAnimate: UIView, finalY: CGFloat, initalAnimationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        var scaledTransform = originalTransform.translatedBy(x: 0.0, y: initalAnimationY)
        UIView.animate(withDuration: 0.2, animations: {
            viewToAnimate.transform = scaledTransform
        }) { (isSuccess) in
            scaledTransform = originalTransform.translatedBy(x: 0.0, y: finalY)
            UIView.animate(withDuration: 0.2, animations: {
                viewToAnimate.transform = scaledTransform
            }) { (isSuccess) in
                
                if completion != nil{
                    completion!()
                }
            }
        }
    }
    
    func bounceAnimationToViewWithTransprancy(viewToAnimate: UIView, finalY: CGFloat, initalAnimationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        var scaledTransform = originalTransform.translatedBy(x: 0.0, y: initalAnimationY)
        UIView.animate(withDuration: 0.2, animations: {
            viewToAnimate.transform = scaledTransform
            viewToAnimate.alpha = 0.5
        }) { (isSuccess) in
            scaledTransform = originalTransform.translatedBy(x: 0.0, y: finalY)
            UIView.animate(withDuration: 0.2, animations: {
                viewToAnimate.transform = scaledTransform
                viewToAnimate.alpha = 1.0
            }) { (isSuccess) in
                
                if completion != nil{
                    completion!()
                }
            }
        }
    }
}
