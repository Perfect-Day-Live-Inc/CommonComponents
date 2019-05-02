//
//  Theme.swift
//  
//
//  Created by Muhammad Ali Maniar on 10/10/17.
//  Copyright © 2017 Appiskey. All rights reserved.
//

import Foundation
import UIKit


//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class contains Theme related codes,
///such as status bar color
///set app default font with default size

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
class Theme {
    
    static var appLigthGray : UIColor {
        return UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1.0)
    }
    
    static func setStatusBarApperence(Color: UIColor){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Color
        }
    }
    
    static var appMainColor : UIColor {
        return UIColor(red: 163/255.0, green: 7/255.0, blue: 15/255.0, alpha: 1.0)
    }
    
    static var appBlackSecondaryColor : UIColor {
        return UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1.0)
    }
    
    static var appGreySecondaryColor : UIColor {
        return UIColor(red: 104/255.0, green: 104/255.0, blue: 104/255.0, alpha: 1.0)
    }
    
    static func getAppBoldFontWithSize(size:CGFloat?=14) -> UIFont{
        return UIFont.init(name: Constants.HeavyFont, size: size!)!
    }
    
    static func getAppFontWithSize(size:CGFloat?=14) -> UIFont{
        return UIFont.init(name: Constants.fontName, size: size!)!
    }
    
    static func getAppMediumFontWithSize(size:CGFloat?=14) -> UIFont{
        return UIFont.init(name: Constants.mediumFont, size: size!)!
    }
}
