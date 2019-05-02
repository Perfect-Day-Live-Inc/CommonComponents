//
//  DocumentPicker.swift
//  
//
//  Created by Muhammad Ahmed Baig on 15/03/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit


//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class is used to pick document
///this class is use to remove redundancy of UIDocumentPicker,
///the class which implements this, need to implement it's delegate

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

protocol DocumentPickerDelegate {
    func documentPickerFinishTask(data: Data?, error: String?)
}

class DocumentPicker : NSObject{
    
    private override init(){super.init();}
    static let getInstance = DocumentPicker()
    
    var delegate : DocumentPickerDelegate!
    static internal var viewController : UIViewController!
    func documentPickerShow(fromVC: UIViewController){
        DocumentPicker.viewController = fromVC
        
        let docPicker : UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: [kUTTypeHTML as String], in: UIDocumentPickerMode.import)
        docPicker.delegate = self
        docPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        fromVC.present(docPicker, animated: true, completion: nil)
    }
    
}

extension DocumentPicker : UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            // This is what it should be
            _ = (url.absoluteString as NSString).lastPathComponent
            print("Path: ", url.path)
            let fileData = try! Data.init(contentsOf: url as URL)
            let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            print("\nFile Data: ", fileStream)
            delegate.documentPickerFinishTask(data: fileData, error: nil)
        }else{
            delegate.documentPickerFinishTask(data: nil, error: "Something went wrong, Please try again!")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController){
        controller.dismiss(animated: true, completion: nil)
    }
}
