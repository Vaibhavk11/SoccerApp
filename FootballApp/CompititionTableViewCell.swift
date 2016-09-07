//
//  CompititionTableViewCell.swift
//  FootballApp
//
//  Created by admin on 01/09/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit

class CompititionTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var imageHolder: UIImageView!
    
    @IBOutlet var checkBox: VKCheckbox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        checkBox.line             = .Thin
        checkBox.bgColorSelected  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        checkBox.bgColor          = UIColor.grayColor()
        checkBox.color            = UIColor.whiteColor()
        checkBox.borderColor      = UIColor.whiteColor()
        checkBox.borderWidth      = 2
        checkBox.cornerRadius     = CGRectGetHeight(checkBox.frame) / 2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
