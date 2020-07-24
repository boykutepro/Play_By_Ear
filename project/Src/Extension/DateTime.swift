//
//  DateTime.swift
//  project
//
//  Created by Mac on 8/16/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
//MARK: - Date
extension Date {
    func getStringFromDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM, h:mm a"
        let dateTimeStr = dateFormatter.string(from: self)
        return dateTimeStr
    }
    
    
    //TODO: Get Date After Day , Year
    func getDateAfterDay(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    func getDateAfterYear(year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    

}
