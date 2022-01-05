//
//  DateExtension.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

extension Date {
    
    // MARK: - Static Methods
    static var startDate: Self {
        return Self.createDate(year: 1960, month: 1, day: 1)
    }
    
    static var endDate: Self {
        return Self.createDate(year: 2300, month: 12, day: 31)
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
                           day: Int,
                           hour: Int = 0,
                           minute: Int = 0) -> Self {
        let dateComponent = DateComponents(calendar: .autoupdatingCurrent,
                                           timeZone: .autoupdatingCurrent,
                                           year: year,
                                           month: month,
                                           day: day,
                                           hour: hour,
                                           minute: minute)

        guard let date = dateComponent.date else {
            print("DateComponents.createDate(year:month:day:) -> dateComponents is nil.")
            return Date()
        }
        
        return date.addingTimeInterval(60 * 60 * 9)
    }
    
    // MARK: - Instance Methods
    func toString(format: String = "YYYY-MM-dd (E) HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func createDate() -> Self {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        
        return Date.createDate(year: year,
                               month: month,
                               day: day,
                               hour: hour,
                               minute: minute)
    }
    
    func getComponent(of component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        
        return calendar.component(component, from: self)
    }
    
    mutating func addWeek(_ week: Int) -> Date {
        let oneWeek = TimeInterval(60 * 60 * 24 * 7)
        return self.addingTimeInterval(Double(week) * oneWeek)
    }
}
