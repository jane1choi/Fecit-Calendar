//
//  ActionView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject var controller = CalendarController()
    private var schedules: [YearMonthDay: [(String, Color)]] = [
        YearMonthDay.today: [("Helloooooo", Color.orange),
                             ("byeee", Color.blue),
                             ("blahblah", Color.pink),
                             ("어쩌구저쩌구", Color.red)],
        YearMonthDay(year: 2024, month: 04, day: 12): [
            ("Helloooooo", Color.purple)
        ]
    ]
   
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
                Text("\(controller.yearMonth.monthString) \(String(controller.yearMonth.year))")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            .background(Color(.mainBlue))
            
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { i in
                    Text(DateFormatter().shortWeekdaySymbols[i].uppercased())
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width / 7)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color(.mainBlue))

            ZStack {
                CalendarView(controller) { date in
                    GeometryReader { geometry in
                        ZStack {
                            if date.isToday {
                                Circle()
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: .top)
                                    .padding(.top, 0)
                                    .foregroundColor(.blue)
                            }

                            Text("\(date.day)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(getColor(date))
                                .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                                .padding(.top, 13)
                            
                            VStack(spacing: 2) {
                                markEvent(event: schedules, date: date, width: geometry.size.width)
                            }
                                        let event = events[index]
                                        Text(event.0)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .tint(.white)
                            Text("New Action")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.white))
                                
                        }
                        .padding()
                        .background(.mainBlue)
                        .cornerRadius(40)
                    })
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    // TODO: 메서드 위치 옮기기
    private func getColor(_ date: YearMonthDay) -> Color {
        if date.isToday {
            return Color.white
        }
        
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
    
    @ViewBuilder func markEvent(event: [YearMonthDay: [(String, Color)]],
                                date: YearMonthDay, width: CGFloat) -> some View {
        if let events = schedules[date] {
            ForEach(0..<min(events.count, 3), id:\.self) { index in
                let event = events[index]
                Text(event.0)
                    .lineLimit(1)
                    .foregroundStyle(.white)
                    .font(.system(size: 8, weight: .bold))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .frame(width: width, alignment: .center)
                    .background(event.1)
                    .cornerRadius(4)
            }
            
            if events.count > 3 {
                Text("+\(events.count - 3)")
                    .lineLimit(1)
                    .foregroundStyle(.white)
                    .font(.system(size: 8, weight: .bold))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .frame(width: width, alignment: .center)
                    .background(Color.gray)
                    .cornerRadius(4)
            }
        }
    }
}

#Preview {
    ActionView()
}
