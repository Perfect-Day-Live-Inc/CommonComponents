//
//  AlertViewController.swift
//  Common
//
//  Created by Muhammad Ahmed Baig on 26/09/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit

protocol AlertVCDelegate : class {
    func noBtnTapped()
    func yesBtnTapped()
    func okBtnTapped()
}

///This enum is use to differentiate if popup is with Single Btn or Double Btn
public enum PopUpStyle {
    case singleBtn
    case doubleBtn
}

public struct AlertConfiguration{
    public var message: String
    public var messageTxtColor: UIColor = UIColor.init(red: 104/255, green: 104/255, blue: 104/255, alpha: 1.0)
    public var popUpStyle: PopUpStyle
    public var primaryBtnTitle: String
    public var secondaryBtnTitle: String
    public var primaryColor: UIColor
    public var secondaryColor: UIColor
    public var buttonTextColor: UIColor = UIColor.white
    public var backColor: UIColor = UIColor.white
    public var fontStyle: UIFont? = nil
    
    public init(message: String,
         popUpStyle: PopUpStyle,
         primaryBtnTitle: String,
         secondaryBtnTitle: String,
         primaryColor: UIColor,
         secondaryColor: UIColor) {
        
        self.message = message
        self.popUpStyle = popUpStyle
        self.primaryBtnTitle = primaryBtnTitle
        self.secondaryBtnTitle = secondaryBtnTitle
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    public init(message: String,
         messageTxtColor: UIColor,
         popUpStyle: PopUpStyle,
         primaryBtnTitle: String,
         secondaryBtnTitle: String,
         primaryColor: UIColor,
         secondaryColor: UIColor,
         buttonTextColor: UIColor,
         backColor: UIColor,
         fontStyle: UIFont) {
        
        self.message = message
        self.messageTxtColor = messageTxtColor
        self.popUpStyle = popUpStyle
        self.primaryBtnTitle = primaryBtnTitle
        self.secondaryBtnTitle = secondaryBtnTitle
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.buttonTextColor = buttonTextColor
        self.backColor = backColor
        self.fontStyle = fontStyle
    }
}

open class AlertViewController: UIViewController {
    
    public init(){
        let bundle = Bundle.init(for: AlertViewController.self)
        print("All Bundles ", Bundle.allBundles)
        super.init(nibName: "AlertViewController", bundle: bundle)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let bundle = Bundle.init(for: AlertViewController.self)
        print("All Bundles ", Bundle.allBundles)
        super.init(nibName: "AlertViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    private var typeOfPopUp : PopUpStyle = .doubleBtn
    
    private var delegate : AlertVCDelegate? = nil
    
    public var config: AlertConfiguration!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpData()
        self.mainView.layer.cornerRadius = 5.0
        if typeOfPopUp == .singleBtn{
            self.noBtn.isHidden = true
            self.yesBtn.isHidden = true
            self.okBtn.isHidden = false
        }else{
            self.noBtn.isHidden = false
            self.yesBtn.isHidden = false
            self.okBtn.isHidden = true
        }
    }
    
    private func setUpData(){
        
        self.mainView.backgroundColor = config.backColor
        
        self.txtLbl.textColor = config.messageTxtColor
        self.txtLbl.text = config.message
        
        self.typeOfPopUp = config.popUpStyle
        
        self.okBtn.backgroundColor = config.primaryColor
        self.okBtn.setTitle(config.primaryBtnTitle, for: UIControl.State.normal)
        self.okBtn.setTitleColor(config.buttonTextColor, for: UIControl.State.normal)
        
        self.yesBtn.backgroundColor = config.primaryColor
        self.yesBtn.setTitle(config.primaryBtnTitle, for: UIControl.State.normal)
        self.yesBtn.setTitleColor(config.buttonTextColor, for: UIControl.State.normal)
        
        self.noBtn.backgroundColor = config.secondaryColor
        self.noBtn.setTitle(config.secondaryBtnTitle, for: UIControl.State.normal)
        self.noBtn.setTitleColor(config.buttonTextColor, for: UIControl.State.normal)
        
        if config.fontStyle != nil{
            self.yesBtn.titleLabel?.font = config.fontStyle
            self.okBtn.titleLabel?.font = config.fontStyle
            self.noBtn.titleLabel?.font = config.fontStyle
            self.txtLbl.font = config.fontStyle
        }
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yesBtnTapped(_ sender: UIButton) {
        if delegate != nil{
            delegate!.yesBtnTapped()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func noBtnTapped(_ sender: UIButton) {
        if delegate != nil{
            delegate!.noBtnTapped()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func okBtnTapped(_ sender: UIButton) {
        if delegate != nil{
            delegate!.okBtnTapped()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: USER IMPEMENTATION FUNCTIONS.
    
    public func setUpAndShowAlertController(config: AlertConfiguration){
        
        let vc = AlertViewController(nibName: "AlertViewController", bundle: nil)
        vc.config = config
        self.presentViewController(vc: vc)
    }
    
    private func presentViewController(vc: UIViewController){
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
    
    public func showAlert(){
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(self, animated: true, completion: nil)
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
