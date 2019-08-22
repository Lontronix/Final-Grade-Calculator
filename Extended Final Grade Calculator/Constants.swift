//
//  Constants.swift
//  Extended Final Grade Calculator
//
//  Created by Lonnie Gerol on 12/15/18.
//  Copyright © 2018 Lontronix. All rights reserved.
//
//  better way of storing constants: https://www.youtube.com/watch?v=hIQMQmzitfU at 1:07
//
//

import Foundation
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

 struct Colors{
    static let red = UIColor(displayP3Red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    static let yellow = UIColor(displayP3Red: 239/255, green: 199/255, blue: 67/255, alpha: 1.0)
    static let orange = UIColor(displayP3Red: 232/255, green: 149/255, blue: 52/255, alpha: 1.0)
    static let blue = UIColor(displayP3Red: 115/255, green: 191/255, blue: 237/255, alpha: 1.0)
   
}

struct dateFormats{
    static func getFormatDate(date: Date) -> String! {
        let dateFormatter = DateFormatter.init()
            dateFormatter.locale = Locale.init(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yy, hh:mm")
        return dateFormatter.string(from: date)
    }
    
}
