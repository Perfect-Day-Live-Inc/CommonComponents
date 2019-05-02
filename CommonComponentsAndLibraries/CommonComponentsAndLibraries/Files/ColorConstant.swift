//
//  ColorConstant.swift
//  
//
//  Created by admin on 16/10/2017.
//  Copyright © 2017 APPISKEY. All rights reserved.
//

import Foundation
import UIKit

///These class contains all the colors which are use in many screens of application
class ColorConstant{
    
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
    
    static let headerColor = UIColor.hexStringToUIColor(hex: "#272f33")
    static let yellowColor = UIColor.hexStringToUIColor(hex: "#e9c02a")
    static let blackColor = UIColor.hexStringToUIColor(hex: "#000000")
    static let grayColor = UIColor.hexStringToUIColor(hex: "#5f5f5f")
    static let greenColor = UIColor.hexStringToUIColor(hex: "#42f344")
    static let blueColor = UIColor.hexStringToUIColor(hex: "#2f5099")
    
    
    ///Contest Colors
    static let contestRedColor = UIColor.hexStringToUIColor(hex: "#ff3d3d")
    static let contestBlueColor = UIColor.hexStringToUIColor(hex: "#5283ff")
    static let contestYellowColor = UIColor.hexStringToUIColor(hex: "#ffaf31")
    static let contestPinkColor = UIColor.hexStringToUIColor(hex: "#fd52ff")
    
    static let LightGrayColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0)
    static let DarkGrayColor = UIColor(red: 92/255, green: 94/255, blue: 102/255, alpha: 1.0)
    static let tableViewLightGreyColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
    static let borderGreyColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)

    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


