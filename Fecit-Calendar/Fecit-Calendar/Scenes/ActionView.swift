//
//  ActionView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

struct ActionView: View {
    
    private let days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    @State private var month = Date()
    @StateObject var calendarModel = CalendarModel()
    @State var monthId: MonthModel.ID?
    @State var showMonthLabel: Bool = false
    @State var viewInitialized: Bool = false
   
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("TODAY")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white)
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                })
                .padding(.trailing, 30)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                })
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay {
                Text("\(month.formatted(.dateTime.month(.wide).year()))")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            .background(Color(.mainBlue))
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width / 7)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color(.mainBlue))
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(calendarModel.monthList) { monthModel in
                        VStack {
                            CalendarView(monthModel: monthModel)
                                .onAppear {
                                    if monthModel == calendarModel.monthList.last {
                                        print("last visible row")
                                        calendarModel.addMonthAfter(5)
                                    } else if monthModel == calendarModel.monthList.first {
                                        print("first visible row")
                                        calendarModel.addMonthBefore(5) // 숫자뭔지 알아내기
                                    }
                                }
                        }
                        .frame(height: UIScreen.main.bounds.height - 230)
                    }
                }
                .scrollTargetLayout()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .scrollPosition(id: $monthId)
            .onAppear{ monthId = calendarModel.idForCurrentMonth() }
            .scrollIndicators(.hidden)
            .onChange(of: monthId, initial: false) {
                if ( !viewInitialized ) {
                    viewInitialized = true
                    return
                }
                showMonthLabel = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.smooth) {
                        showMonthLabel = false
                    }
                }
            }
        }
    }
}

#Preview {
    ActionView()
}
