//
//  AlertSheet.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 09/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit
import Foundation

//var handler : (() -> Void) = (() -> Void)

public class AlertSheet: UIViewController {
    
    public init(){
        let bundle = Bundle.init(for: AlertSheet.self)
        print("All Bundles ", Bundle.allBundles)
        super.init(nibName: "AlertSheet", bundle: bundle)
    }
    
    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let bundle = Bundle.init(for: AlertSheet.self)
        super.init(nibName: "AlertSheet", bundle: bundle)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private var optionsWithActions = [SheetAction]()
    
    public var seperatorColor: UIColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    private var isDefaultActionRequired : Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let bundle = Bundle.init(for: AlertSheetCell.self)
        self.tableView.register(UINib(nibName: "AlertSheetCell", bundle: bundle), forCellReuseIdentifier: "AlertSheetCell")
        self.tableView.rowHeight = 55
        self.tableView.layer.cornerRadius = 10
        self.updateConstraints()
    }
    
    func updateConstraints(){
        
        if CGFloat(self.optionsWithActions.count * 55) < self.view.frame.height * 0.7{
            self.tableView.isScrollEnabled = false
            self.tableViewHeight.constant = CGFloat(self.optionsWithActions.count * 55)
        }else{
            self.tableView.isScrollEnabled = true
            self.tableViewHeight.constant = self.view.frame.height * 0.7
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func addAction(action: SheetAction){
        self.optionsWithActions.append(action)
    }
    
    public func showAlert(isDefaultActionRequired : Bool=true){
        self.isDefaultActionRequired = isDefaultActionRequired
        if self.isDefaultActionRequired{
            self.optionsWithActions.append(SheetAction.init(nameP: "Cancel", colorP: UIColor.black, actionP: { (vc) in
                vc.dismiss(animated: true, completion: nil)
            }))
        }
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.getTopViewController(){
                rootWindow.present(self, animated: true, completion: nil)
            }
        }
    }
    
}

extension AlertSheet : UITableViewDelegate, UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsWithActions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertSheetCell", for: indexPath) as! AlertSheetCell
        cell.setUpCell(sheetAction: self.optionsWithActions[indexPath.row], seperatorColor: seperatorColor)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.optionsWithActions[indexPath.row].action != nil{
            self.optionsWithActions[indexPath.row].action!(self)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
