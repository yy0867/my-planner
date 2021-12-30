//
//  DateExtension.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

extension Date {
    
    func toString(format: String = "YYYY-MM-dd") -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone(identifier: "ko_KR")
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

extension DateComponents {
    
    init(year: Int,
         month: Int,
         day: Int) {
        self.init(calendar: .current,
                  timeZone: TimeZone(abbreviation: "KST"),
                  year: year,
                  month: month,
                  day: day)
    }
    
    static func createDate(year: Int,
                           month: Int,
                           day: Int) -> Date {
        let dateComponent = DateComponents(year: year,
                                           month: month,
                                           day: day)
        guard let date = dateComponent.date else {
            print("DateComponents.createDate(year:month:day:) -> dateComponents is nil.")
            return Date()
        }
        
        return date
    }
}
