//
//  Final+CoreDataProperties.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/17/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//
//

import Foundation
import CoreData


extension Final {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Final> {
        return NSFetchRequest<Final>(entityName: "Final")
    }

    @NSManaged public var courseName: String
    @NSManaged public var currentGrade: Double
    @NSManaged public var desiredGrade: Double
    @NSManaged public var finalType: Int16
    @NSManaged public var finalDate: NSDate

}
