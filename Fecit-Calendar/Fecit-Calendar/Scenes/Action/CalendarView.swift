//
//  CalendarView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/18/24.
//

import SwiftUI
import Combine

struct CalendarView<CalendarCell: View>: View {
    
    private var gridItem: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 7)
    private let component: (YearMonthDay) -> CalendarCell
    @ObservedObject private var controller: CalendarController
    private var startWithMonday: Bool

    init(
        _ controller: CalendarController = CalendarController(),
        startWithMonday: Bool = false,
        @ViewBuilder component: @escaping (YearMonthDay) -> CalendarCell
    ) {
        self.controller = controller
        self.startWithMonday = startWithMonday
        self.component = component
    }
    
    var body: some View {
        GeometryReader { proxy in
            InfinitePagerView(controller) { yearMonth, i in
                LazyVGrid(columns: gridItem, alignment: .center, spacing: 0) {
                    ForEach(0..<(controller.columnCount * (controller.rowCount)), id: \.self) { j in
                        GeometryReader { geometry in
                            let date = yearMonth.cellToDate(j, startWithMonday: startWithMonday)
                            self.component(date)
                        }
                        .frame(height: calculateCellHeight(j, geometry: proxy))
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
    
    func calculateCellHeight(_ index: Int, geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height / CGFloat(controller.rowCount)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(CalendarController()) { date in
            GeometryReader { geometry in
                Text("\(String(date.year))/\(date.month)/\(date.day)")
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    .border(.black, width: 1)
                    .font(.system(size: 8))
                    .opacity(date.isFocusYearMonth == true ? 1 : 0.6)
            }
        }
    }
}
