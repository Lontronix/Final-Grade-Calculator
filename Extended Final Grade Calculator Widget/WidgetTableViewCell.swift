//
//  WidgetTableViewCell.swift
//  Extended Final Grade Calculator Widget
//
//  Created by Lonnie Gerol on 12/18/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//

import UIKit

class WidgetTableViewCell: UITableViewCell {
    @IBOutlet weak var CourseNameLabel: UILabel!
    @IBOutlet weak var finalDateLabel: UILabel!
    @IBOutlet weak var finalTypeLabel: UILabel!
    @IBOutlet weak var necessaryPercentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
