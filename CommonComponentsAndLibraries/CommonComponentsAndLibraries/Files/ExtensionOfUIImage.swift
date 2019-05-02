//
//  ExtensionOfUIImage.swift
//  Scholarship
//
//  Created by MacBook Retina on 9/22/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import UIKit

///Extension to change size and quality of image
extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y :(size.height - lineWidth) - 2), size: CGSize(width: size.width, height: lineWidth)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
