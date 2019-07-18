//
//  SheetAction.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 09/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import UIKit

public struct SheetAction{
    public var name : String = ""
    public var color : UIColor = .black
    public var font : UIFont? = nil
    public var backColor : UIColor = UIColor.white
    public var action : ((UIViewController) -> Void)? = nil
    
    public init(nameP : String, colorP: UIColor, font : UIFont?=nil, backColor : UIColor=UIColor.white, actionP: @escaping ((UIViewController) -> Void)){
        self.name = nameP
        self.color = colorP
        self.font = font
        self.backColor = backColor
        self.action = actionP
    }
}
