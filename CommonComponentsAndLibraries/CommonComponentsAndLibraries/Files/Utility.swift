//
//  Utility.swift
//  Scholarship
//
//  Created by MacBook Retina on 9/15/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import UIKit
import Swift
import SafariServices
import MapKit
import CoreLocation
import MobileCoreServices
import AVKit


extension UIColor {
    func as1ptImage() -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This Extension is use to get version number and build number of application

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class contains small tasks which are repeatadly use in the application
///It contians ui settings task
///some api tasks
///and many libraries properties settings

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
protocol DatePickerDelegate {
    func timePicked(time: Date, index: Int, isDatePicker: Bool)
}

class Utility{
    static let getInstance = Utility()
    private init(){}
    
    static var isLoggingOut : Bool = false
    var datePickerDelegate : DatePickerDelegate?
    
    
    ///setting navigation controller
    func setNavigationBar(leftBarItem: UIBarButtonItem?=nil, rightBarItem: UIBarButtonItem?=nil, title: String, vc: UIViewController, isTransparent: Bool=false, isBottomLine: Bool=false, titleView: UIView?=nil, itemsColor: UIColor=UIColor.black, titlesFontSize: CGFloat=19, itemsFontSize: CGFloat=19){
        let font = UIFont(name: Constants.mediumFont, size: titlesFontSize)
        let itemsFont = UIFont(name: Constants.mediumFont, size: itemsFontSize)
        if(rightBarItem != nil){
            rightBarItem?.setTitleTextAttributes([NSAttributedString.Key.font : itemsFont!], for: .normal)
            vc.navigationItem.rightBarButtonItem = rightBarItem
        }
        
        if(leftBarItem != nil){
            leftBarItem?.setTitleTextAttributes([NSAttributedString.Key.font : itemsFont!], for: .normal)
            vc.navigationItem.leftBarButtonItem = leftBarItem
        }
        if (titleView == nil){
            vc.navigationItem.title = title
        }else{
            vc.navigationItem.titleView = titleView!
        }
        
        if !isTransparent{
            //
            vc.navigationController?.navigationBar.barTintColor = UIColor.white//color
            vc.navigationController?.navigationBar.backgroundColor = UIColor.white//.getDarkBlueColor//color
            vc.navigationController?.navigationBar.isTranslucent = false
            if !isBottomLine{
                vc.navigationController?.navigationBar.shadowImage = UIImage()
            }else{
                vc.navigationController?.navigationBar.shadowImage = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0).as1ptImage()
            }
        }else{
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            vc.navigationController?.navigationBar.barTintColor = UIColor.clear//color
            vc.navigationController?.navigationBar.backgroundColor = UIColor.clear//.getDarkBlueColor//color
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        vc.navigationController?.navigationBar.tintColor = itemsColor
        
        vc.navigationItem.backBarButtonItem?.tintColor = itemsColor
        
        vc.navigationItem.rightBarButtonItem?.tintColor = itemsColor
        vc.navigationItem.leftBarButtonItem?.tintColor = itemsColor
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor : itemsColor,
                                       NSAttributedString.Key.font : font!]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
    }
    
    ///setting initial root view controller
    func setInitialVC(loggedIn: Bool=false){
//        var snapshot:UIView!
//        let rootVC : UIViewController!
//
////        let model = UserModel.getAppUser()
////
//        if (!loggedIn){
//            let vcToShow : SignInVC = AppRouter.instantiateViewController(storyboard: .Auth, bundle: Bundle.main)
//            rootVC = UINavigationController(rootViewController: vcToShow)
//        }else{
////            if model!.phone_verified_at == ""{
////                let vcToShow = AppRouter.VerifyVC()
////                rootVC = UINavigationController(rootViewController: vcToShow)
////            }else{
//            let vcToShow : RootVC = AppRouter.instantiateViewController(storyboard: .Menu, bundle: Bundle.main)
//            rootVC = vcToShow//UINavigationController(rootViewController: vcToShow)
////            }
//        }
//        DispatchQueue.main.async {
//            snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
//            rootVC.view.addSubview(snapshot);
//
//            UIApplication.shared.keyWindow?.rootViewController = rootVC;
//            UIView.transition(with: snapshot, duration: 0.4, options: .transitionCrossDissolve, animations: {
//                snapshot.layer.opacity = 0;
//            }, completion: { (status) in
//                snapshot.removeFromSuperview()
//            })
//        }
    }
    
    
    ///set specific view controller as root
    func makeSpecificViewRoot(vc: UIViewController){
        var snapshot:UIView!
        let rootVC : UIViewController!
        
        rootVC = vc
        DispatchQueue.main.async {
            snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
            rootVC.view.addSubview(snapshot);
            
            UIApplication.shared.keyWindow?.rootViewController = rootVC;
            UIView.transition(with: snapshot, duration: 0.4, options: .transitionCrossDissolve, animations: {
                snapshot.layer.opacity = 0;
            }, completion: { (status) in
                snapshot.removeFromSuperview()
            })
        }
    }
    
    ///logout user
    func logoutUser(vc: UIViewController){
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.setInitialVC(loggedIn: false)
//            UserModel.logoutUser(completion: { (status) in
//                if status{
//                    Utility.isLoggingOut = true
//                    DispatchQueue.main.async {
//                        self.setInitialVC()
//                    }
//                }
//            })
        }
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        alert.view.tintColor = Theme.appMainColor
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    ///set nav bar clear color
    func setNavBarClearColor(vc: UIViewController){
        vc.navigationController?.navigationBar.barTintColor = UIColor.clear//color
        vc.navigationController?.navigationBar.backgroundColor = UIColor.clear//.getDarkBlueColor//color
    }
    
    ///add underline to attributed string
    func addUnderLine(attStr: NSMutableAttributedString, range: NSRange, url : URL!) -> NSMutableAttributedString{
        attStr.addAttribute(NSAttributedString.Key.link, value: url!, range: range)
        attStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        attStr.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.black, range: range)
        return attStr
    }
    
    ///add shadow at bottom
    func showShadowAtBottom(view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 50)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1.0
    }
    
    ///present view controller with model presentation style
    func presentModally(vc: UIViewController, fromVC : UIViewController){
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            fromVC.present(vc, animated: true, completion: nil)
        }
    }
    
    ///present view controller with model presentation style
    func presentModallyOnRoot(vc: UIViewController){
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    ///create center label
    func createCenterLblForTitle(titleTxt: NSString) -> UILabel{
        let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:40))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.center = CGPoint(x: 22, y: UIScreen.main.bounds.width / 2)
        
        //getting the range to separate the button title strings
        let newlineRange: NSRange = titleTxt.range(of: "\n")
        
        //getting both substrings
        var substring1: NSString = ""
        var substring2: NSString = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = titleTxt.substring(to: newlineRange.location) as NSString
            substring2 = titleTxt.substring(from: newlineRange.location) as NSString
        }
        
        //assigning diffrent fonts to both substrings
        let font:UIFont? = UIFont.boldSystemFont(ofSize: 14)
        let attrString =  NSMutableAttributedString(string: substring1 as String, attributes: [NSAttributedString.Key.font: font!])
        
        let font1:UIFont? = UIFont.systemFont(ofSize: 11)
        let attrString1 =  NSMutableAttributedString(string: substring2 as String, attributes: [NSAttributedString.Key.font: font1!])
        
        //appending both attributed strings
        attrString.append(attrString1)
        
        //assigning the resultant attributed strings to the button
        label.attributedText = attrString
        return label
    }
    
    ///update fcm token
    func updateFCM(isFromAppDelegate: Bool?=false, isFromLogout: Bool?=false, completion: @escaping(Bool) -> Void){
        
        var refreshedToken =  UserDefaults.standard.string(forKey:  "FIRInstanceIDToken")
        if isFromLogout! {
            refreshedToken = ""
        }
        if refreshedToken != nil{
//            UserModel.updateUserProfile(params: ["device":"ios",
//                                                 "fcm":"\(refreshedToken!)",
//                                                 "_method":"put"],
//                                          completion: { (isSuccess, model, msg) in
//                    completion(true)
//            })
        }else{
            completion(false)
        }
    }
    
    ///check if any field is empty or not
    func checkWeatherTextFieldEmpty(textFieldWithErrorMsg: [UITextField: String]) -> String{
        for (textField, msg) in textFieldWithErrorMsg{
            if textField.text == ""{
                return msg
            }
        }
        return ""
    }
    
    ///make call
    func makeCall(number: String){
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    ///open website on SF Safari
    func openWeb(link: String, isLocal: Bool=false, vc: UIViewController){
        var urlToShow : URL!
        if isLocal{
            urlToShow = URL(fileURLWithPath: link)
        }else{
            urlToShow = URL(string: link)
        }
        let svc = SFSafariViewController(url: urlToShow)
        svc.preferredControlTintColor = Theme.appMainColor
        svc.preferredBarTintColor = UIColor.white
        DispatchQueue.main.async {
            vc.present(svc, animated: true, completion: nil)
        }
    }
    
    ///show date time picker
    func showDateTimePicker(fromVC : UIViewController, index: Int, isDatePicker: Bool?=false, minimumDate : Date?=Date(), selectedDateTime: Date?=nil){
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 150)
        let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        
        var alertCont = UIAlertController(title: "Choose Time", message: "", preferredStyle: UIAlertController.Style.alert)
        pickerView.datePickerMode = .time
        if selectedDateTime != nil{
            pickerView.date = selectedDateTime!
        }
        if isDatePicker!{
            pickerView.datePickerMode = .date
            pickerView.minimumDate = minimumDate
            alertCont = UIAlertController(title: "Choose Date", message: "", preferredStyle: UIAlertController.Style.alert)
        }
        pickerView.locale = NSLocale(localeIdentifier: "\(Formatter.getInstance.getAppTimeFormat().rawValue)") as Locale
        
        vc.view.addSubview(pickerView)
        alertCont.setValue(vc, forKey: "contentViewController")
        let setAction = UIAlertAction(title: "Select", style: .default) { (action) in
            if self.datePickerDelegate != nil{
                self.datePickerDelegate!.timePicked(time: pickerView.date, index: index, isDatePicker: isDatePicker!)
            }
        }
        alertCont.addAction(setAction)
        alertCont.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertCont.view.tintColor = Theme.appMainColor
        fromVC.present(alertCont, animated: true)
    }
    
    ///get string presentation of integer value
    func getStringOfInteger(value: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    ///get date ago in yesterday, today, tomorrow
    func getDateOrAgoFrom(date: Date) -> String{
        let calendar = Calendar.current
        if calendar.isDateInYesterday(date){
            return "Yesterday"
        }else if calendar.isDateInToday(date){
            return "Today"
        }else if calendar.isDateInTomorrow(date){
            return "Tomorrow"
        }else{
            return Formatter.getInstance.dateTimeFormatterWithDay().string(from: date)
        }
    }
    
    ///round off to point .2f
    func roundOfPoint25Of(num: Double) -> Double{
        
        let floorInt : Int = Int(floor(num))
        var afterDecimalFinal = 0.0
        let remainderDecimal = num.truncatingRemainder(dividingBy: 1)
        let twoDigitsDecimal : Double = Double(String(format: "%.2f", arguments: [remainderDecimal]))!
        
        if twoDigitsDecimal != 0.00{
            if twoDigitsDecimal <= 0.25{
                afterDecimalFinal = 0.25
            }else if twoDigitsDecimal <= 0.50{
                afterDecimalFinal = 0.50
            }else if twoDigitsDecimal <= 0.75{
                afterDecimalFinal = 0.75
            }else if twoDigitsDecimal > 0.75{
                afterDecimalFinal = 1.0
            }
        }
        let returnDouble : Double = Double(Double(floorInt) + afterDecimalFinal)
        return returnDouble
        
    }
    
    ///make glow on view
    func makeGlowOnView(view: UIView){
        let color = UIColor.red
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = false
    }
    
    ///remove flow on view
    func removeGlowFromView(view: UIView){
        let color = UIColor.clear
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 0.0
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = true
    }
    
    ///show location disable alert
    func showLocationSettingsAlert(){
        let alert = UIAlertController(title: "Alert", message: "\"\" Detect that your application's location setting is disable, Please enable location service for better results.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Go to settings", style: .default) { (action) in
            Utility.getInstance.openAppSettings()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        DispatchQueue.main.async{
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    ///open application settings
    func openAppSettings(){
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl as URL)
                }
            }
        }
    }
    
    ///convert string to dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///unauthenticate user
    func unAuthenticatedLoggedOut(){
        
        DispatchQueue.main.async {
            if let viewCont = UIApplication.shared.keyWindow?.rootViewController{
//                Loader.getInstance().hideLoader(inView: viewCont.view)
//                AlertViewController.showAlertView(textToShow: MessagesConstants.unAuthenticatedError, mainColor: Theme.appMainColor, secondaryColor: Theme.appGreySecondaryColor, fromVC: viewCont, isOkDelegate: true)
            }
        }
    }
    
    ///show custom alert view, it first check root view and show alert on it, if no root then on fromVC param
//    func showAlertView(textToShow: String, isSingleBtn: Bool?=true, fromVC: UIViewController, isOkDelegate: Bool?=false){
//        
//        let vc : AlertViewController = AlertViewController(nibName: "ImageViewer", bundle: nil)
//        //AppRouter.AlertVC()
//        vc.typeOfPopUp = .singleBtn
//        
//        if !isSingleBtn!{
//            vc.typeOfPopUp = .doubleBtn
//        }
//        vc.textToShow = textToShow
//        if isOkDelegate!{
//            vc.delegate = fromVC as? AlertVCDelegate
//        }
//        DispatchQueue.main.async{
//            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
//                Utility.getInstance.presentModally(vc: vc, fromVC: rootWindow)
//            }else{
//                Utility.getInstance.presentModally(vc: vc, fromVC: fromVC)
//            }
//        }
//    }
    
    //Email Validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Password Validation
    func isValidPassword(testStr:String) -> Bool {
        let passRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[-_!?/<>;:{}()*@#$%^&+=])(?=\\S+$).{4,}$"
        
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: testStr)
    }
    
    func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    func playVideo(path: URL, sourceVC: UIViewController) {
        let player = AVPlayer(url: path)
        let playerController = AVPlayerViewController()
        playerController.player = player
        DispatchQueue.main.async {
            sourceVC.present(playerController, animated: true) {
                player.play()
            }
        }
    }
    
    func getPercentageFromCountString(resultCount: Int, totalCount: Int) -> String{
        if (Double(Double(resultCount)/Double(totalCount)) * 100) == 0.0{
            return "0%"
        }
        if String(format: "%.1f", Double(Double(resultCount)/Double(totalCount)) * 100).contains(".0") {
            return String(format: "%.0f", Double(Double(resultCount)/Double(totalCount)) * 100) + "%"
        }else{
            return String(format: "%.1f", Double(Double(resultCount)/Double(totalCount)) * 100) + "%"
        }
    }
    
    func getPercentageFromCount(resultCount: Int, totalCount: Int) -> Double{
        return Double(Double(resultCount)/Double(totalCount)) * 100
    }
    
    func setRememberMeNumberPass(num: String, pass: String){
        UserDefaults.standard.setValue(num, forKey: "RememberNum")
        UserDefaults.standard.setValue(pass, forKey: "RememberPass")
    }
    
    func removeRememberMeNumberPass(){
        UserDefaults.standard.setValue("", forKey: "RememberNum")
        UserDefaults.standard.setValue("", forKey: "RememberPass")
    }
    
    func getRememberMeNumberPass() -> Dictionary<String, String>?{
        var dic : [String: String]? = nil
        if let num = UserDefaults.standard.string(forKey: "RememberNum") {
            dic = [:]
            dic!["Id"] = num
            if let pass = UserDefaults.standard.string(forKey: "RememberPass") {
                dic!["pass"] = pass
                return dic!
            }
        }
        return nil
    }
    
}

//extension Utility : AlertVCDelegate{
//    func okBtnTapped() {
////        UserModel.logoutUser { (bool) in
////            Utility.getInstance.setInitialVC()
////        }
//    }
//
//    func yesBtnTapped() {}
//    func noBtnTapped() {}
//}

