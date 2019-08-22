//
//  TodayViewController.swift
//  Extended Final Grade Calculator Widget
//
//  Created by Lonnie Gerol on 12/18/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

struct courseFinal{
    var courseName: String!
    var finalDate: Date!
    var finalType: Bool
    //var grade: String!
    
}

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var finals = [courseFinal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WidgetTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let defaults = UserDefaults(suiteName: "group.com.lontronix.finalgradecalculator")
        defaults?.synchronize()
        
        getFinals()
    }
    
  
    
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if(activeDisplayMode == .expanded){
         preferredContentSize = CGSize(width: 0.0, height: 800)
            
        }
        else{
            self.preferredContentSize = maxSize
            }
        
    }
    
    private func getFinals(){
        let defaults = UserDefaults(suiteName: "group.com.lontronix.finalgradecalculator")
        defaults?.synchronize()
        
        let firstFinalTitle = defaults?.object(forKey: "FirstFinal-CourseTitle") as? String
        if(firstFinalTitle != nil){
            let firstFinalDate = defaults?.object(forKey: "FirstFinal-finalDate") as! Date
            let firstFinalType = defaults?.object(forKey: "FirstFinal-finalType") as! Bool
            
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @IBAction func openAppButtonPressed(_ sender: UIButton) {
        self.extensionContext?.open(URL(string: "Studu://")!, completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69.5
    }
    
}
