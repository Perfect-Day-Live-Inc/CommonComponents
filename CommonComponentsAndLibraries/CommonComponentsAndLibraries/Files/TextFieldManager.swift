//
//  TextFieldDelegateManager.swift
//  Safe Space Health
//
//  Created by Muhammad Ahmed Baig on 19/09/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import UIKit

class TextFieldManager : NSObject{
    private override init() {super.init()}
    static let instance = TextFieldManager()
    
    private var textFields = [UITextField]()
    
    func setTextFieldsWithDelegate(textFieldsArr: [UITextField]){
        self.textFields = textFieldsArr
        self.textFields.forEach { (field) in
            field.addTarget(self, action: #selector(TextFieldsUpdate), for: UIControl.Event.editingDidEndOnExit)
            if field === self.textFields.last{
                field.returnKeyType = .done
            }else{
                field.returnKeyType = .next
            }
        }
    }
    
    @objc func TextFieldsUpdate(){
        let currFieldIndex =  self.textFields.firstIndex { (field) -> Bool in
            return field.isFirstResponder
        }
        if currFieldIndex == nil{
            return
        }
        
        let currField = self.textFields[currFieldIndex!]
        currField.resignFirstResponder()
        if self.textFields.count <= currFieldIndex! + 1{
            return
        }
        let nextField = self.textFields[currFieldIndex! + 1]
        if nextField.isEnabled {
            nextField.becomeFirstResponder()
        }else{
            if self.textFields.count <= currFieldIndex! + 2{
                return
            }
            let newNextField = self.textFields[currFieldIndex! + 2]
            newNextField.becomeFirstResponder()
        }
    }
}
