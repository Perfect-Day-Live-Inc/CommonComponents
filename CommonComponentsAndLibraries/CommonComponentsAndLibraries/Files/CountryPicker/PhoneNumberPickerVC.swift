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
    public var limitOfNumberExcludingDailingCode = 7
    var isPresented : Bool = true
    var isNavigationHiddenInParent : Bool = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = Bundle.init(for: PhonePickerTVCell.self)
        self.tableView.register(UINib(nibName: "PhonePickerTVCell", bundle: bundle), forCellReuseIdentifier: "PhonePickerTVCell")
        
        if self.navigationController == nil{
            fatalError("Expected a navigation controller, you need to add this controller in navigation controller or call 'setUpPhonePicker' or 'presentPicker'")
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
        self.setData()
    }
    
    func setUpNavigation(){
        if self.navigationController?.isNavigationBarHidden ?? false{
            self.isNavigationHiddenInParent = true
        }else{
            self.isNavigationHiddenInParent = false
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.title = "Contact Number"
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                       NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnTapped))
        doneBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        self.navigationItem.rightBarButtonItem = doneBtn
        
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
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
    
    
    ///return back bar button which are using in whole app
    func backBarButtonItem() -> UIBarButtonItem {
        let backImage = UIImage.init(named: "back", in: Bundle.init(for: PhoneNumberPickerVC.self), compatibleWith: UITraitCollection.init())
        
        let backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
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
    
    @IBAction func codeBtnTapped(_ sender: UIButton) {
        self.searchBar.becomeFirstResponder()
    }
    
    public func setUpPhonePicker(countryModel : IsoCountryInfo?=nil,
                                 selectedNumber : String="",
                                 limitOfNumberExcludingDailingCode: Int){
        self.countryModel = countryModel
        self.selectedNumber = selectedNumber
        self.limitOfNumberExcludingDailingCode = limitOfNumberExcludingDailingCode
    }
    
    public func presentPicker(fromViewController vc: UIViewController){
        let navVC = UINavigationController.init(rootViewController: self)
        vc.present(navVC, animated: true, completion: nil)
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
        if numberField.text != "" && numberField.text!.count >= self.limitOfNumberExcludingDailingCode{
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
            let alert = UIAlertController.init(title: "Alert", message: "Number cannot be greater then \(self.limitOfNumberExcludingDailingCode)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "Ok",
                                               style: UIAlertAction.Style.cancel,
                                               handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
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
                return model.name.contains(searchBar.text!)
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
                return model.name.contains(searchBar.text!)
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
        
        if (textField.text!.count + (string.count - range.length) > self.limitOfNumberExcludingDailingCode) && isBackSpace != -92{
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
