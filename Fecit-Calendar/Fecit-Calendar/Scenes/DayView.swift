//
//  DayView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/22/24.
//

import SwiftUI

struct DayView: View {
    var dayModel: DayModel

    var body: some View {
        VStack(spacing: 0) {
            if let date = dayModel.date {
                let isToday =  date.isToday()
                let isWeekend = date.isWeekend()
                let hasEvent = dayModel.hasEvent
                let foregroundColor = isToday ? Color.white : isWeekend ? Color.red : Color.black
                

                Text("\(date.day())")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.top, 4)
                Spacer()
                if hasEvent { // 이벤트 있을 때 표시
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 7)
        .frame(maxHeight: .infinity)
        .background(Rectangle().stroke())
    }
}


#Preview {
    VStack {
        DayView(dayModel: DayModel(Date()))
    }

}

