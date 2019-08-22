//
//  FinalInfoTableViewCell.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/15/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//

import UIKit

class FinalInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var necessaryGradeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

}
