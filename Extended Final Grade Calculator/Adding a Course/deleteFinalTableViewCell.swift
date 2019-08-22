//
//  deleteFinalTableViewCell.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/19/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//

import UIKit

protocol DeleteFinalDelegate{
   func deleteFinalButtonPressed()
}

class deleteFinalTableViewCell: UITableViewCell {
    var delegate: DeleteFinalDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteFinalButtonPressed(_ sender: UIButton) {
        delegate.deleteFinalButtonPressed()
    }
}
