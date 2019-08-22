//
//  SemesterFinal+CoreDataProperties.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/18/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//
//

import Foundation
import CoreData


extension SemesterFinal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SemesterFinal> {
        return NSFetchRequest<SemesterFinal>(entityName: "SemesterFinal")
    }

    @NSManaged public var courseName: String
    @NSManaged public var currentGrade: Double
    @NSManaged public var desiredGrade: Double
    @NSManaged public var finalDate: NSDate?
    @NSManaged public var finalType: Int16
    @NSManaged public var gradeIsRounded: Bool
    @NSManaged public var finalIsExam: Bool
    @NSManaged public var finalWeight: Double

}
