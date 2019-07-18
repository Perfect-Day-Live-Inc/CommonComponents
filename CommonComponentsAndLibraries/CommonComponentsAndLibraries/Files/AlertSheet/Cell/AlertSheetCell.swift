//
//  AlertSheetCell.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 09/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit

class AlertSheetCell: UITableViewCell {
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var titleLbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpCell(sheetAction: SheetAction, seperatorColor: UIColor){
        self.titleLbl.text = sheetAction.name
        self.titleLbl.textColor = sheetAction.color
        self.backgroundColor = sheetAction.backColor
        self.seperatorView.backgroundColor = seperatorColor
        if sheetAction.font != nil{
            self.titleLbl.font = sheetAction.font
        }
    }
    
}
