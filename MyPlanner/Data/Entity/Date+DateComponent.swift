//
//  DateExtension.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

extension Date {
    
    func toString(format: String = "YYYY-MM-dd (E) HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static func getWeekdays(of date: Self) -> [Self] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date) - 1
        guard let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: date) else {
            print("Date.getWeekdays(of:) -> found nil in guard let weekdays = ...")
            return []
        }
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: date) }
        
        return days
    }
    
    static func createDate(year: Int,
                           month: Int,
                           day: Int) -> Self {
        let dateComponent = DateComponents(calendar: .current,
                                           year: year,
                                           month: month,
                                           day: day)
        guard let date = dateComponent.date else {
            print("DateComponents.createDate(year:month:day:) -> dateComponents is nil.")
            return Date()
        }
        
        return date
    }
}
