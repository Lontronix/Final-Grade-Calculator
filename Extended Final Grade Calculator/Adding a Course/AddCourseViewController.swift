//
//  AddCourseViewController.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/10/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//


/**
 Description:
 An Extension of the Final Grade Calculator that we created earlier on in the year. This version allows the user to save their final grades by class and edit them.
 //  
 
 Citations:
 https://stackoverflow.com/questions/5306240/ios-dismiss-keyboard-when-touching-outside-of-uitextfield - Dismiss keyboard when touching outside of view
 
 https://stackoverflow.com/questions/35689528/add-a-view-on-top-of-the-keyboard-using-inputaccessoryview-swift - Adding a vew on top of keyboard
 
 https://stackoverflow.com/questions/40242702/converting-boolean-value-to-integer-value-in-swift-3 - Converting a boolean value to an integer
 
 http://www.mikitamanko.com/blog/2017/02/15/swift-how-to-create-ios-today-extension-and-share-data-with-containing-app/ - Creating a today extension and sharing data between it and the host app
 
 https://medium.com/cocoa-gurus/core-data-sharing-data-between-apps-and-their-widgets-6cb7204bd98f - today widget info continued
 
 https://hackernoon.com/app-extensions-and-today-extensions-widget-in-ios-10-e2d9fd9957a8 - more today widget info
 
 https://stackoverflow.com/questions/40653242/today-widget-extension-height-ios10 - dealing with height of today widget
 
 https://www.raywenderlich.com/697-today-extension-tutorial-getting-started - more today widget basic information
 
 https://stackoverflow.com/questions/39503873/disable-blinking-cursor-from-uitextfield-in-swift - disabling blinking text cursor
 
 https://nsdateformatter.com - date formatting
 
 https://apoorv.blog/change-textfield-input-to-datepicker/ - date picker in place of a keyboard
 
 
 https://stackoverflow.com/questions/35689528/add-a-view-on-top-of-the-keyboard-using-inputaccessoryview-swift - Adding an accessory view on top of keyboard
 https://apoorv.blog/change-textfield-input-to-datepicker/ - date picker in place of a keyboard
 
 **/

import UIKit

class AddCourseViewController: UIViewController, GradeInfoCellDelegate, CourseInfoDelegate, DeleteFinalDelegate{
   
    
    

    @IBOutlet weak var tableView: UITableView!
    var semesterFinal: SemesterFinal!
    //indicated whether a final has been passed forward
    var editingFinal: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.view.backgroundColor = Colors.red
        tableView.register(UINib(nibName: "ClassInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "classInfoCell")
        tableView.register(UINib(nibName: "GradeInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "gradeInfoCell")
        tableView.register(UINib(nibName: "deleteFinalTableViewCell", bundle: nil), forCellReuseIdentifier: "deleteFinalTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if(semesterFinal == nil){
            semesterFinal = SemesterFinal(context: context)
        }
        else{
            editingFinal = true
        }
        
        
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets.zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
            }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        context.rollback()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
       
            self.view.endEditing(true)
        if(semesterFinal.finalIsExam == nil){
            semesterFinal.finalIsExam = false
        }
        
            
            do{
                try context.save()
                self.dismiss(animated: true, completion: nil)
            }
            catch{
                 displayAlert(title: "Error!", message: "One or more fields is missing information.")
            }
            
        
        
        
        
 
    
    }
    
    func displayAlert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    }
    
    
    func semesterFinalGradeDidChange(newDate: Date) {
        semesterFinal.finalDate = newDate as NSDate
        
    }
    
    
    func desiredGradeDidChange(newGrade: Double) {
        semesterFinal.desiredGrade = newGrade
    }
    
    func currentGradeDidChange(newGrade: Double) {
        semesterFinal.currentGrade = newGrade
    }
    
    func gradingScaleDidChange(isRounded: Bool) {
        semesterFinal.gradeIsRounded = isRounded
    }
    
    func finalTypeDidChange(isProject: Bool) {
        semesterFinal.finalIsExam = !isProject
    }
    
    func courseNameDidChange(newCourseName: String) {
        semesterFinal.courseName = newCourseName
    }
    
    func finalWeightDidChange(newFinalWeight: Double) {
        semesterFinal.finalWeight = newFinalWeight
    }
    
    func deleteFinalButtonPressed() {
        let popupAlertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this final?", preferredStyle: .actionSheet)
        popupAlertController.addAction(UIAlertAction(title: "Yes!", style: .destructive, handler:{ (alert: UIAlertAction) in
            context.delete(self.semesterFinal)
           
            
            do{
            try context.save()
            }
            catch{
                
            }
             self.dismiss(animated: true, completion: nil)
            
            
        }))
            popupAlertController.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
        
        self.present(popupAlertController, animated: true, completion: nil)
    }
    
    
    
}




extension AddCourseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "classInfoCell") as! ClassInfoTableViewCell
                cell.delegate = self
            
            if(editingFinal){
                cell.courseNameTextField.text = semesterFinal.courseName
            }
            
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gradeInfoCell") as! GradeInfoTableViewCell
                cell.delegate = self
            
            if(editingFinal){
                cell.desiredGradeTextField.text = String(semesterFinal.desiredGrade)
                cell.currentGradeTextField.text = String(semesterFinal.currentGrade)
                cell.gradingScaleSegmentedControl.selectedSegmentIndex = semesterFinal.gradeIsRounded ? 0 : 1
                cell.finalTypeSegmentedControl.selectedSegmentIndex = semesterFinal.finalIsExam ? 1 : 0
                cell.finalDateTextField.text = dateFormats.getFormatDate(date: semesterFinal.finalDate! as Date)
                cell.finalWeightTextField.text = String(semesterFinal.finalWeight)
                
                editingFinal = false
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "deleteFinalTableViewCell") as! deleteFinalTableViewCell
            cell.delegate = self
            return cell
        }
       
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Course Information"
         case 1:
            return "Final Information"
            
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return 265
        }
        else{
            return 49.5
        }
    }
    
    
    
    
    
    
}
