//
//  ExtensionOfUIView.swift
//  
//
//  Created by MacBook Retina on 10/21/17.
//  Copyright © 2017 Appiskey. All rights reserved.
//

import Foundation
import UIKit

///extension of view to make dropshadow
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addGradient(color1: UIColor=UIColor.clear, color2: UIColor=UIColor.black){
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0, 0.8, 0.8, 1]
        self.layer.mask = gradient
    }
    
    func curveCorners(_ corners: UIRectCorner, size: CGSize) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: size)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
