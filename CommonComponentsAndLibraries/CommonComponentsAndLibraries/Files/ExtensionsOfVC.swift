//
//  Extensions.swift
//  
//
//  Created by admin on 05/10/2017.
//  Copyright © 2017 APPISKEY. All rights reserved.
//

import Foundation
import UIKit


//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This extension contains some important functions which are using in approximately whole applications screen
///this contains back button code
///menu btn code
///their actions

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

extension UIViewController {
    
    ///setting status bar
    func setStatusBarColor(color: UIColor?=UIColor.clear){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
    
    ///return back bar button which are using in whole app
    func backBarButton() -> UIBarButtonItem {
        
        let backButtonItem = UIBarButtonItem(image: UIImage(named:"back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        return backButtonItem
    }
    
    ///return menu bar button which are using in whole app
    func menuBarButton() -> UIBarButtonItem {
        
        let menuButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(MenuButtonTapped))
        return menuButtonItem
    }
    
    ///return menu bar button which are using in whole app
    func searchBarButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(image: UIImage(named:"search-black"), style: .plain, target: self, action: #selector(SearchButtonTapped))
        return buttonItem
    }
    
    ///return menu bar button which are using in whole app
    func filterBarButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(image: UIImage(named:"filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(FilterButtonTapped))
        return buttonItem
    }
    
    ///return menu bar button which are using in whole app
    func bellWhiteBarButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem(image: UIImage(named:"icon_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(FilterButtonTapped))
        return buttonItem
    }
    
    ///Menu btn action
    @objc func MenuButtonTapped() {
//        sideMenuViewController?.presentLeftMenuViewController()
    }

    ///Back Btn Action
    @objc func BackButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func SearchButtonTapped(){
//        let vc = AppRouter.SearchVC()
//        DispatchQueue.main.async {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @objc func FilterButtonTapped(){
//        let vc = AppRouter.LetsConnectVC()
//        DispatchQueue.main.async {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    func swipeToPopDisable() {
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func swipeToPopEnable() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
}
extension UIViewController: UIGestureRecognizerDelegate{

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return false
        }
        return true
    }
    
}

//extension UIViewController: UIGestureRecognizerDelegate{
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}



