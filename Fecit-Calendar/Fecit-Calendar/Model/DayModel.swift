//
//  DayModel.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/19/24.
//

import Foundation

struct DayModel: Identifiable {
    var id: UUID = UUID()
    
    var date: Date?
    var hasEvent: Bool
    
    init(_ date: Date?) {
        self.date = date
        self.hasEvent = date?.day().isMultiple(of: 5) ?? false
    }
}
