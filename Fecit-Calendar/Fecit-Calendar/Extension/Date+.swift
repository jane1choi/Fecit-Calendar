//
//  Date+.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/19/24.
//

import Foundation

extension Date {
    
    func day() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: self))!
    }
    
    func month() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: self))!
    }
    
    func year() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    func localizedMonthString() -> String {
        let calendar = Calendar.current
        return calendar.shortStandaloneMonthSymbols[self.month() - 1]
    }
    
    func yearMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM"
        return dateFormatter.string(from: self)
    }
    
    // 0: 일요일
    func weekDay() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday ?? 0 - 1
    }

    
    /// 해당 월의 일 수를 구하는 메서드
    func daysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.count
    }
    
    func dateFromString(month: Int, year: Int, day: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: "\(addPadding(year, 4))/\(addPadding(month, 2))/\(addPadding(day, 2))")!
    }
    
    func addPadding(_ int: Int, _ targetDigit: Int ) -> String {
        return String(format: "%0\(targetDigit)d", int)
    }
    
    func firstDayOfMonth() -> Date {
        let calendar = Calendar.current
        let date = dateFromString(month: self.month(), year: self.year(), day: 1)
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func plusDate(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: count, to: self)!
    }
    
    func minusDate(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -count, to: self)!
    }
    
    func plusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: count, to: self)!
    }
    
    func minusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -count, to: self)!
    }

    func isToday() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let todayDateString = dateFormatter.string(from: Date())
        let dateToCompareString = dateFormatter.string(from: self)
        return (todayDateString == dateToCompareString)
    }
    
    func isWeekend() -> Bool {
        let weekday = self.weekDay()
        return ((weekday == 0 ) || (weekday == 6))
    }
    
    func isCurrentMonth() -> Bool {
        let today = Date()
        return (today.year() == self.year()) && (today.month() == self.month())
    }
}
