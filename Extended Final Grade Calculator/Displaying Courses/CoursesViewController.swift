//
//  ViewController.swift
//  Extended Final Grade Calculator
//
//  
//  Created by Lonnie Gerol on 12/10/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//
//
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
 **/



import UIKit
import CoreData

class FGNavigationController: UINavigationController{
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.navigationBar.barTintColor = Colors.red
        self.navigationBar.isTranslucent = false
        self.navigationBar.prefersLargeTitles = true
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationBar.titleTextAttributes = titleAttributes
        self.navigationBar.largeTitleTextAttributes = titleAttributes
        self.navigationBar.tintColor = UIColor.white
       
    }
    

    
}

class CoursesViewController: UITableViewController {
    var finals = [SemesterFinal]()
    var colorIndex = 0
    var selectedFinalIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FinalInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "courseInfoCell")
        updateFinals()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateFinals()

    }

     func updateFinals(){
        let fetchRequest = NSFetchRequest<SemesterFinal>(entityName: "SemesterFinal")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "finalDate", ascending: true)]
        
        do{
            finals = try context.fetch(fetchRequest)
        }
        catch{
            
        }
        tableView.reloadData()
    }
    
    func setSharedFinals(){
        let defaults = UserDefaults(suiteName: "group.com.lontronix.finalgradecalculator")
        //Can't just pass an NSManaged Object
        if(finals.count > 1){
        defaults?.set(finals[0].courseName, forKey: "FirstFinal-CourseTitle")
        defaults?.set(finals[0].finalDate, forKey: "FirstFinal-finalDate")
        defaults?.set(finals[0].finalIsExam, forKey: "FirstFinal-finalType")
        }
        else{
            defaults?.set(nil, forKey: "FirstFinal-CourseTitle")
            defaults?.set(nil, forKey: "FirstFinal-finalDate")
            defaults?.set(nil, forKey: "FirstFinal-finalType")
        }
        if(finals.count > 2){
        defaults?.set(finals[1].courseName, forKey: "SecondFinal-CourseTitle")
        defaults?.set(finals[1].finalDate, forKey: "SecondFinal-finalDate")
        defaults?.set(finals[1].finalIsExam, forKey: "SecondFinal-finalType")
        }
        else{
            defaults?.set(nil, forKey: "SecondFinal-CourseTitle")
            defaults?.set(nil, forKey: "SecondFinal-finalDate")
            defaults?.set(nil, forKey: "SecondFinal-finalType")
        }
        
        if(finals.count > 3){
        defaults?.set(finals[2].courseName, forKey: "ThirdFinal-CourseTitle")
        defaults?.set(finals[2].finalDate, forKey: "ThirdFinal-finalDate")
        defaults?.set(finals[2].finalIsExam, forKey: "ThirdFinal-finalType")
        }
        else{
            defaults?.set(nil, forKey: "ThirdFinal-CourseTitle")
            defaults?.set(nil, forKey: "ThirdFinal-finalDate")
            defaults?.set(nil, forKey: "ThirdFinal-finalType")
        }
        defaults?.synchronize()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseInfoCell")! as! FinalInfoTableViewCell
            cell.courseNameLabel.text = finals[indexPath.section].courseName
            cell.dateLabel.text = dateFormats.getFormatDate(date: finals[indexPath.section].finalDate! as Date)
        
        //let result = (desiredGrade - (1.0 - Double(finalWeight)) * currentGrade)/Double(finalWeight)
        let desiredGrade = finals[indexPath.section].desiredGrade
        let currentGrade = finals[indexPath.section].currentGrade
        let finalWeight = finals[indexPath.section].finalWeight / 100.0
        
        cell.necessaryGradeLabel.text = String(format: "%.2f",
                                               
        ((desiredGrade - ((1.0 - finalWeight)*currentGrade))/finalWeight)) + "%"
        
        switch colorIndex{
        case 0:
            cell.backgroundColor = Colors.yellow
            colorIndex = colorIndex + 1
        case 1:
            cell.backgroundColor = Colors.red
            colorIndex = colorIndex + 1
            
        case 2:
            cell.backgroundColor = Colors.orange
            colorIndex = colorIndex + 1
        case 3:
            cell.backgroundColor = Colors.blue
            colorIndex = 0
        
        default: ()
        }
        
        
        
        return cell
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(finals.count == 0){
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = "No Finals, click the \"+\" button to add one"
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        }
        else{
            tableView.backgroundView = nil
        }
        return finals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFinalIndex = indexPath.section
        performSegue(withIdentifier: "upcomingToEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "upcomingToEdit"){
            let destination = segue.destination as! AddCourseViewController
                destination.semesterFinal = finals[selectedFinalIndex]
        }
    }

}



