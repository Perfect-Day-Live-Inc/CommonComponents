//
//  ExtensionOfString.swift
//  
//
//  Created by MacBook Retina on 1/9/18.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import Swift
import UIKit

///Extension of string to perform multiple dunctions
extension String {
    
    ///get height from constant width font of string
    ///    width: width size
    ///    font: font size to use
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    ///convert html to attributed string.
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}
