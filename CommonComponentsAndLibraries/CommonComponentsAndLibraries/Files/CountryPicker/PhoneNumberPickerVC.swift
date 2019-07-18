//
//  PhoneNumberPickerVC.swift
//  
//
//  Created by MacBook Retina on 11/15/17.
//  Copyright © 2017 Appiskey. All rights reserved.
//

import UIKit

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///this class is use to pick phone number
///this is a component by which use select country and then enter phone number

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///delegate methods which have to imppement by the class which call this class self
public protocol PhoneNumberPickerVCDelegate {
    func phoneNumberPicker(number: String, isoModel: IsoCountryInfo)
}

open class PhoneNumberPickerVC: UIViewController {
    
    
    public init(){
        let bundle = Bundle.init(for: PhoneNumberPickerVC.self)
        print("All Bundles ", Bundle.allBundles)
        super.init(nibName: "PhoneNumberPickerVC", bundle: bundle)
    }
    
    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let bundle = Bundle.init(for: PhoneNumberPickerVC.self)
        print("All Bundles ", Bundle.allBundles)
        super.init(nibName: "PhoneNumberPickerVC", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchBar.delegate = self
        self.numberField.delegate = self
    }
    
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topInputView: UIView!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var isSearchEnable : Bool = false
    var arrayToShow = [IsoCountryInfo]()
    
    public var delegate : PhoneNumberPickerVCDelegate?
    
    public var countryModel : IsoCountryInfo?
    public var selectedNumber = ""
    public var maximumExcludingDailingCode = 7
    public var minmumDigitsRequired = 5
    public var backBarItemImage: UIImage!
    public var rightBarItemImage: UIImage? = nil
    public var backgroundImage: UIImage? = nil
    public var isTransparentNavigation: Bool = false
    public var navigationBarItemColor: UIColor = .black
    public var textColors: UIColor = .black
    public var navigationFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    var isPresented : Bool = true
    var isNavigationHiddenInParent : Bool = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = Bundle.init(for: PhonePickerTVCell.self)
        self.tableView.register(UINib(nibName: "PhonePickerTVCell", bundle: bundle), forCellReuseIdentifier: "PhonePickerTVCell")
        
        if self.navigationController == nil{
            fatalError("Expected a navigation controller, you need to add this controller inside a navigation controller or call 'setUpPhonePicker' or 'presentPicker'")
        }
        
        if self.backBarItemImage == nil{
            backBarItemImage = UIImage.init(named: "back", in: Bundle.init(for: PhoneNumberPickerVC.self), compatibleWith: UITraitCollection.init())
        }
        
        self.setUpNavigation()
        
        ///get and set all countries iso codes and numeric codes to local array
        if self.countryModel == nil{
            self.countryModel = ISOCountries.allCountries.filter({ (model) -> Bool in
                return model.alpha2 == "US"
            }).first!
        }
        self.numberField.text = selectedNumber
        self.numberField.keyboardType = .numberPad
        self.arrayToShow = ISOCountries.allCountries
        self.numberField.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
        
        if backgroundImage != nil{
            self.bgImageView.image = backgroundImage
            self.topInputView.backgroundColor = .clear
            self.codeLbl.textColor = textColors
            self.numberField.textColor = textColors
            self.searchBar.backgroundColor = .clear
            self.searchBar.tintColor = textColors
            self.tableView.backgroundColor = .clear
            self.seperatorView.backgroundColor = textColors
        }
        
        self.setData()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let presentedController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController{
            if presentedController.isKind(of: UINavigationController.self){
                if presentedController === self.navigationController{
                    self.isPresented = true
                }else{
                    self.isPresented = false
                }
            }else{
                self.isPresented = false
            }
        }else{
            self.isPresented = false
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isNavigationHiddenInParent{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavigation(){
        if self.navigationController?.isNavigationBarHidden ?? false{
            self.isNavigationHiddenInParent = true
        }else{
            self.isNavigationHiddenInParent = false
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.title = "Contact Number"
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor : self.navigationBarItemColor,
                                       NSAttributedString.Key.font : navigationFont]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
        
        if rightBarItemImage == nil{
            let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnTapped))
            doneBtn.setTitleTextAttributes([NSAttributedString.Key.font : navigationFont,
                                            NSAttributedString.Key.foregroundColor: self.navigationBarItemColor], for: .normal)
            self.navigationItem.rightBarButtonItem = doneBtn
        }else{
            let doneBtn = UIBarButtonItem.init(image: self.rightBarItemImage!, style: .done, target: self, action: #selector(doneBtnTapped))
            self.navigationItem.rightBarButtonItem = doneBtn
        }
        
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem()
        self.navigationItem.leftBarButtonItem?.tintColor = self.navigationBarItemColor
        
        if isTransparentNavigation{
            self.navigationController?.navigationBar.barTintColor = UIColor.clear//color
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear//.getDarkBlueColor//color
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    
    ///return back bar button which are using in whole app
    func backBarButtonItem() -> UIBarButtonItem {
        let backButtonItem = UIBarButtonItem(image: backBarItemImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButtonItem.tintColor = .black
        return backButtonItem
    }
    
    @objc func backButtonTapped(){
        
        if self.isPresented{
            self.navigationController?.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func isValidPhoneNumber(number: String) -> Bool{
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: number, options: [], range: NSMakeRange(0, number.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == number.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    public func setUpPhonePicker(countryModel : IsoCountryInfo?=nil,
                                 selectedNumber : String="",
                                 maximumExcludingDailingCode: Int,
                                 minmumDigitsRequired: Int,
                                 backBarItemImage: UIImage?=nil,
                                 backgroundImage: UIImage? = nil,
                                 isTransparentNavigation: Bool? = nil,
                                 navigationBarItemColor: UIColor? = nil,
                                 textColors: UIColor? = nil){
        
        self.maximumExcludingDailingCode = maximumExcludingDailingCode
        self.minmumDigitsRequired = minmumDigitsRequired
        
        if countryModel != nil{
            self.countryModel = countryModel!
        }
        if selectedNumber != ""{
            self.selectedNumber = selectedNumber
        }
        if textColors != nil{
            self.textColors = textColors!
        }
        if navigationBarItemColor != nil{
            self.navigationBarItemColor = navigationBarItemColor!
        }
        if isTransparentNavigation != nil{
            self.isTransparentNavigation = isTransparentNavigation!
        }
        if backgroundImage != nil{
            self.backgroundImage = backgroundImage!
        }
        if backBarItemImage != nil{
            self.backBarItemImage = backBarItemImage!
        }
    }
    
    public func presentPicker(fromViewController vc: UIViewController){
        let navVC = UINavigationController.init(rootViewController: self)
        vc.present(navVC, animated: true, completion: nil)
    }
    
    func showAlert(withMsg message: String){
        let alert = UIAlertController.init(title: "Alert",
                                           message: message,
                                           preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: "Ok",
                                           style: UIAlertAction.Style.cancel,
                                           handler: nil))
        
        alert.popoverPresentationController?.sourceView = sourceVC.view
        DispatchQueue.main.async {
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func codeBtnTapped(_ sender: UIButton) {
        self.searchBar.becomeFirstResponder()
    }
}
extension PhoneNumberPickerVC : UITableViewDelegate, UITableViewDataSource{
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToShow.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhonePickerTVCell", for: indexPath) as! PhonePickerTVCell
        cell.countryNameLbl.text = arrayToShow[indexPath.row].name
        cell.countryCodeLbl.text = arrayToShow[indexPath.row].calling
        if self.countryModel != nil{
            if arrayToShow[indexPath.row].alpha2 == self.countryModel!.alpha2{
                cell.tickWidth.constant = 30
            }else{
                cell.tickWidth.constant = 0
            }
        }
        if self.backgroundImage != nil{
            cell.contentView.backgroundColor = .clear
            cell.countryNameLbl.textColor = textColors
            cell.countryCodeLbl.textColor = textColors
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countryModel = arrayToShow[indexPath.row]
        if self.countryModel != nil{
            self.searchBar.text = self.countryModel!.name
            self.numberField.becomeFirstResponder()
        }
        self.setData()
    }
    
    ///set data to country code label
    func setData(){
        self.codeLbl.text = self.countryModel!.calling
        self.tableView.reloadData()
    }
    
    ///this will check if number is not empty then call delegate method
    @objc func doneBtnTapped(){
        if numberField.text != "", numberField.text!.count >= self.minmumDigitsRequired, numberField.text!.count <= self.maximumExcludingDailingCode{
            if self.isValidPhoneNumber(number: self.codeLbl.text! + "" + self.numberField.text!){
                if delegate != nil{
                    delegate!.phoneNumberPicker(number: self.codeLbl.text! + "" + self.numberField.text!,
                                                isoModel: self.countryModel!)
                    if self.isPresented{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else{
                self.showAlert(withMsg: "Please enter valid number.")
            }
        }else{
            var errorToShow = "Number cannot be empty."
            if numberField.text != "", numberField.text!.count < self.minmumDigitsRequired{
                errorToShow = "Number cannot be less then \(self.minmumDigitsRequired)."
            }else if numberField.text != "", numberField.text!.count > self.maximumExcludingDailingCode{
                errorToShow = "Number cannot be greater then \(self.maximumExcludingDailingCode)."
            }
            self.showAlert(withMsg: errorToShow)
        }
    }
}

extension PhoneNumberPickerVC: UISearchBarDelegate, UITextFieldDelegate{
    //------------------------------------------------------------------------------------------------------//
    ///Search bar delegate methods
    //------------------------------------------------------------------------------------------------------//
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if searchBar.text != ""{
            isSearchEnable = true
            arrayToShow = ISOCountries.allCountries.filter({ (model) -> Bool in
                return model.name.lowercased().contains(searchBar.text!.lowercased())
            })
        }else{
            isSearchEnable = false
            arrayToShow = ISOCountries.allCountries
        }
        self.tableView.reloadData()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearchEnable = false
        arrayToShow = ISOCountries.allCountries
        self.tableView.reloadData()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.view.endEditing(true)
        if searchText != ""{
            isSearchEnable = true
            arrayToShow = ISOCountries.allCountries.filter({ (model) -> Bool in
                return model.name.lowercased().contains(searchBar.text!.lowercased())
            })
        }else{
            isSearchEnable = false
            arrayToShow = ISOCountries.allCountries
        }
        self.tableView.reloadData()
    }
    
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
    
    
    
    //------------------------------------------------------------------------------------------------------//
    ///Textfields delegate methods
    //------------------------------------------------------------------------------------------------------//
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (textField.text!.count + (string.count - range.length) > self.maximumExcludingDailingCode) && isBackSpace != -92{
            return false
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
}


