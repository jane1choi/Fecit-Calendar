//
//  CalendarView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/18/24.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var isNotCurrentMonth: Bool = false
}

struct CalendarView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
            Week(days: [DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date()),
                        DateValue(day: 1, date: Date())])
        }
    }
}

struct Week: View {
    
    var days: [DateValue]
    
    init(days: [DateValue]) {
        self.days = days
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(days.indices, id: \.self) { i in
                CardView(value: days[i])
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack(spacing: 0) {
            if value.day > 0 {
                Text("\(value.day)")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.top, 4)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 7)
        .frame(maxHeight: .infinity)
        .background(Rectangle().stroke())
    }
}

#Preview {
    CalendarView()
}
