//
//  PhonePickerTVCell.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 01/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit

class PhonePickerTVCell: UITableViewCell {

    @IBOutlet weak var tickWidth: NSLayoutConstraint!
    @IBOutlet weak var tickImg: UIImageView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
