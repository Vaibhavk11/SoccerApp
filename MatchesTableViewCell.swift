//
//  MatchesTableViewCell.swift
//  FootballApp
//
//  Created by admin on 12/09/16.
//  Copyright © 2016 Unixon Solutions. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    @IBOutlet var awayTeam: UILabel!
    @IBOutlet var matchTime: UILabel!
    @IBOutlet var homeTeam: UILabel!
    @IBOutlet var awayScore: UITextField!
    @IBOutlet var homeScore: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
