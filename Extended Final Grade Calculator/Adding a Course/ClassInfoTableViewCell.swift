//
//  ClassInfoTableViewCell.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/12/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//

import UIKit

protocol CourseInfoDelegate{
    func courseNameDidChange(newCourseName: String)
    
}

class ClassInfoTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var courseNameTextField: UITextField!
    var delegate: CourseInfoDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        courseNameTextField.delegate = self
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.courseNameDidChange(newCourseName: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
