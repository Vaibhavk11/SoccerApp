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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
