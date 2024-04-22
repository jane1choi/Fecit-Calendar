//
//  CalendarView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/18/24.
//

import SwiftUI

struct CalendarView: View {
    var monthModel: MonthModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {

                // days
                ForEach(0..<monthModel.numberOfRows(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<7) { column in
                            let dayIndex = column + (row * 7)
                            let dayModel = monthModel.dayModelList[dayIndex]
                           
                            DayView(dayModel: dayModel)
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: geometry.size.height)
        }
    }
    
}


#Preview {
    CalendarView(monthModel: MonthModel(Date().firstDayOfMonth()))
}
