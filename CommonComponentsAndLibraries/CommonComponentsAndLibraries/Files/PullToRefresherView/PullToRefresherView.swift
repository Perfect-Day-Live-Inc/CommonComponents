//
//  PullToRefresherView.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 07/11/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import UIKit

open class PullToRefresher: UIRefreshControl{
    
    var refreshView: PullToRefresherView!
    public var indicatorStyle : DGActivityIndicatorAnimationType = .ballSpinFadeLoader
    public var loaderColor : UIColor = UIColor.black
    public var textColor : UIColor = UIColor.black
    
    override public init() {
        super.init()
        self.getRefereshView()
    }
    
    public init(loaderColor: UIColor=UIColor.black,
                textColor: UIColor=UIColor.black,
                indicatorType: DGActivityIndicatorAnimationType=DGActivityIndicatorAnimationType.ballSpinFadeLoader) {
        super.init()
        
        self.loaderColor = loaderColor
        self.textColor = textColor
        self.indicatorStyle = indicatorType
        self.getRefereshView()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.getRefereshView()
    }
    
    public init(frame: CGRect,
                loaderColor: UIColor=UIColor.black,
                textColor: UIColor=UIColor.black,
                indicatorType: DGActivityIndicatorAnimationType=DGActivityIndicatorAnimationType.ballSpinFadeLoader) {
        super.init(frame: frame)
        self.loaderColor = loaderColor
        self.textColor = textColor
        self.indicatorStyle = indicatorType
        self.getRefereshView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.getRefereshView()
    }
    
    func getRefereshView() {
        self.tintColor = UIColor.clear
        refreshView = PullToRefresherView(frame: self.frame)
        refreshView.loaderColor = self.loaderColor
        refreshView.textColor = self.textColor
        refreshView.indicatorStyle = self.indicatorStyle
        refreshView.setUI()
        self.addSubview(refreshView)
    }
    
    open override func beginRefreshing() {
        super.beginRefreshing()
        refreshView.startAnimation()
    }
    
    open override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopAnimation()
    }
    
}

class PullToRefresherView: UIView {
    
    var view: UIView!
    @IBOutlet weak var superViewForIndicator: UIView!
    var indicatorView: DGActivityIndicatorView!
    @IBOutlet weak var msgLbl: UILabel!
    private var timer = Timer()
    
    public var indicatorStyle : DGActivityIndicatorAnimationType = .ballSpinFadeLoader
    public var loaderColor : UIColor = UIColor.black
    public var textColor : UIColor = UIColor.black
    
    override public init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: PullToRefresherView.self)
        let nib = UINib(nibName: "PullToRefresherView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    public func setUI(){
        self.indicatorView = DGActivityIndicatorView(type: indicatorStyle, tintColor: self.loaderColor, size: 30)
        self.msgLbl.textColor = self.textColor
        self.indicatorView.center = self.superViewForIndicator.center
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        self.view.addSubview(self.indicatorView)
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    public func startAnimation(){
        self.indicatorView.tintColor = self.loaderColor
        self.msgLbl.textColor = self.textColor
        self.indicatorView.isHidden = false
        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        self.indicatorView.startAnimating()
    }
    
    public func stopAnimation(){
        self.timer.invalidate()
        self.indicatorView.stopAnimating()
    }
    
    @objc func timeUpdate(){
        if !self.msgLbl.isHidden && self.msgLbl.text != nil{
            if self.msgLbl.text!.contains("..."){
                self.msgLbl.text = self.msgLbl.text!.components(separatedBy: "...").first!
            }else if self.msgLbl.text!.contains(".."){
                self.msgLbl.text = self.msgLbl.text! + "."
            }else if self.msgLbl.text!.contains("."){
                self.msgLbl.text = self.msgLbl.text! + "."
            }else{
                self.msgLbl.text = self.msgLbl.text! + "."
            }
        }else{
            self.timer.invalidate()
        }
    }
}
