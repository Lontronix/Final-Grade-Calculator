//
//  GradeInfoTableViewCell.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/12/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//
//




import UIKit

protocol GradeInfoCellDelegate{
    func semesterFinalGradeDidChange(newDate: Date)
    func desiredGradeDidChange(newGrade: Double)
    func currentGradeDidChange(newGrade: Double)
    func gradingScaleDidChange(isRounded: Bool)
    func finalTypeDidChange(isProject: Bool)
    func finalWeightDidChange(newFinalWeight: Double)
    
    
    
}

class GradeInfoTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var currentGradeTextField: UITextField!
    @IBOutlet weak var desiredGradeTextField: UITextField!
    @IBOutlet weak var gradingScaleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var finalTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var finalDateTextField: UITextField!
    @IBOutlet weak var finalWeightTextField: UITextField!
    
    var delegate: GradeInfoCellDelegate!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
            picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(pickerDateValueChanged), for: .valueChanged)
        return picker
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        finalDateTextField.inputView = datePicker
        finalDateTextField.allowsEditingTextAttributes
            = false
        finalDateTextField.delegate = self
        finalDateTextField.tintColor = UIColor.clear
        currentGradeTextField.delegate = self
        desiredGradeTextField.delegate = self
        finalWeightTextField.delegate = self
        gradingScaleSegmentedControl.addTarget(self, action: #selector(finalGradeScaleDidChange), for: .valueChanged)
        finalTypeSegmentedControl.addTarget(self, action: #selector(finalTypeDidChange), for: .valueChanged)
        let button = UIButton()
            button.setTitle("Close Keyboard", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 10, height: 44)
            button.backgroundColor = Colors.red
        button.addTarget(self, action: #selector(closeKeyboard), for: .touchUpInside)
        finalDateTextField.inputAccessoryView = button
        finalWeightTextField.inputAccessoryView = button
        desiredGradeTextField.inputAccessoryView = button
        currentGradeTextField.inputAccessoryView = button
        
    }
    
    @objc func closeKeyboard(){
        self.contentView.endEditing(true)
        
    }
    
    @objc func pickerDateValueChanged(){
        finalDateTextField.text = dateFormats.getFormatDate(date: datePicker.date)
        delegate.semesterFinalGradeDidChange(newDate: datePicker.date)
        
    }
    
    @objc func finalTypeDidChange(){
        delegate.finalTypeDidChange(isProject: finalTypeSegmentedControl.selectedSegmentIndex == 0)
    }
    
    @objc func finalGradeScaleDidChange(){
        delegate.gradingScaleDidChange(isRounded: gradingScaleSegmentedControl.selectedSegmentIndex == 0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
 
  
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField != finalDateTextField){
            if let newGrade = Double(textField.text!){
                if(textField == currentGradeTextField){delegate.currentGradeDidChange(newGrade: newGrade)}
                else if (textField == desiredGradeTextField){delegate.desiredGradeDidChange(newGrade: Double(newGrade))}
                else if(textField == finalWeightTextField){
                    delegate.finalWeightDidChange(newFinalWeight: newGrade)}
                
            }
        }
    }
    }



