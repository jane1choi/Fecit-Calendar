//
//  Utility.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/23/24.
//

import SwiftUI

enum Week: Int, CaseIterable {
    case sun = 0
    case mon = 1
    case tue = 2
    case wed = 3
    case thu = 4
    case fri = 5
    case sat = 6
}

struct YearMonth: Equatable, Hashable {
    let year: Int
    let month: Int
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    static var current: YearMonth {
        get {
            let today = Date()
            return YearMonth(
                year: Calendar.current.component(.year, from: today),
                month: Calendar.current.component(.month, from: today)
            )
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month
    }
    
    var monthString: String {
        get {
            var components = toDateComponents()
            components.day = 1
            components.hour = 0
            components.minute = 0
            components.second = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter.string(from: Calendar.current.date(from: components)!)
        }
    }
    
    func addMonth(value: Int) -> YearMonth {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let toDate = self.toDateComponents()

        var components = DateComponents()
        components.month = value

        let addedDate = Calendar.current.date(byAdding: components, to: gregorianCalendar.date(from: toDate)!)!
        let ret = YearMonth(year: Calendar.current.component(.year, from: addedDate), month: Calendar.current.component(.month, from: addedDate))
        return ret
    }
    
    func diffMonth(value: YearMonth) -> Int {
        var origin = self.toDateComponents()
        origin.day = 1
        origin.hour = 0
        origin.minute = 0
        origin.second = 0
        var new = value.toDateComponents()
        new.day = 1
        new.hour = 0
        new.minute = 0
        new.second = 0
        return Calendar.current.dateComponents([.month], from: Calendar.current.date(from: origin)!, to: Calendar.current.date(from: new)!).month!
    }
    
    func toDateComponents() -> DateComponents {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        return components
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.year)
        hasher.combine(self.month)
    }
    
    func cellToDate(_ cellIndex: Int, startWithMonday: Bool) -> YearMonthDay {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        var toDateComponent = DateComponents()
        toDateComponent.year = self.year
        toDateComponent.month = self.month
        toDateComponent.day = 1
        let toDate = gregorianCalendar.date(from: toDateComponent)!
        let weekday = Calendar.current.component(.weekday, from: toDate) // 1Sun, 2Mon, 3Tue, 4Wed, 5Thu, 6Fri, 7Sat
        var components = DateComponents()
        components.day = cellIndex - weekday + (!startWithMonday ? 1 : weekday == 1 ? (-5) : 2)
        let addedDate = Calendar.current.date(byAdding: components, to: toDate)!
        let year = Calendar.current.component(.year, from: addedDate)
        let month = Calendar.current.component(.month, from: addedDate)
        let day = Calendar.current.component(.day, from: addedDate)
        let isFocusYaerMonth = year == self.year && month == self.month
        let ret = YearMonthDay(year: year, month: month, day: day, isFocusYearMonth: isFocusYaerMonth)
        return ret
    }
}

struct YearMonthDay: Equatable, Hashable {
    let year: Int
    let month: Int
    let day: Int
    let isFocusYearMonth: Bool?
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.isFocusYearMonth = nil
    }
        
    init(year: Int, month: Int, day: Int, isFocusYearMonth: Bool) {
        self.year = year
        self.month = month
        self.day = day
        self.isFocusYearMonth = isFocusYearMonth
    }
    
    static var today: YearMonthDay {
        get {
            let today = Date()
            return YearMonthDay(
                year: Calendar.current.component(.year, from: today),
                month: Calendar.current.component(.month, from: today),
                day: Calendar.current.component(.day, from: today)
            )
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
    
    var isToday: Bool {
        let today = Date()
        let year = Calendar.current.component(.year, from: today)
        let month = Calendar.current.component(.month, from: today)
        let day = Calendar.current.component(.day, from: today)
        return self.year == year && self.month == month && self.day == day
    }
    
    var dayOfWeek: Week {
        let weekday = Calendar.current.component(.weekday, from: self.date!)
        return Week.allCases[weekday - 1]
    }
    
    var date: Date? {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        return gregorianCalendar.date(from: self.toDateComponents())
    }
    
    func toDateComponents() -> DateComponents {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = self.day
        return components
    }
    
    func addDay(value: Int) -> YearMonthDay {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let toDate = self.toDateComponents()

        var components = DateComponents()
        components.day = value

        let addedDate = Calendar.current.date(byAdding: components, to: gregorianCalendar.date(from: toDate)!)!
        let ret = YearMonthDay(
            year: Calendar.current.component(.year, from: addedDate),
            month: Calendar.current.component(.month, from: addedDate),
            day: Calendar.current.component(.day, from: addedDate)
        )
        return ret
    }
    
    func diffDay(value: YearMonthDay) -> Int {
        var origin = self.toDateComponents()
        origin.hour = 0
        origin.minute = 0
        origin.second = 0
        var new = value.toDateComponents()
        new.hour = 0
        new.minute = 0
        new.second = 0
        return Calendar.current.dateComponents([.day], from: Calendar.current.date(from: origin)!, to: Calendar.current.date(from: new)!).month!
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.year)
        hasher.combine(self.month)
        hasher.combine(self.day)
    }
}
