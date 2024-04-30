//
//  ActionView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

struct Event: Equatable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let color: Color
}

struct ActionView: View {
    @ObservedObject var controller = CalendarController()
    @State private var showSheet: Bool = false
    @State private var focusDate: YearMonthDay?
    @State private var schedules: [YearMonthDay: [Event]] = [
        YearMonthDay.today: [Event(title: "hellooo", color: .purple),
                             Event(title: "byeeee", color: .yellow),
                             Event(title: "tesststst", color: .blue),
                             Event(title: "메롱", color: .red)],
        YearMonthDay(year: 2024, month: 04, day: 12): [
            Event(title: "hiiiii", color: .purple)
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
                                .onTapGesture {
                                    focusDate = date
                                }
                            
                            VStack(spacing: 2) {
                                markEvent(event: schedules, date: date, width: geometry.size.width)
                            }
                            .padding(.top, 30)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        }
                        .background( (date == focusDate) ? .gray.opacity(0.3) : .white)
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        showSheet.toggle()
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
                    .sheet(isPresented: $showSheet) {
                        CreateEventView(isPresented: $showSheet, schedules: $schedules, targetDate: $focusDate)
                            .presentationDetents([.medium])
                    }
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
    
    @ViewBuilder func markEvent(event: [YearMonthDay: [Event]],
                                date: YearMonthDay, width: CGFloat) -> some View {
        if let events = event[date] {
            ForEach(0..<min(events.count, 3), id: \.self) { index in
                let event = events[index]
                Text(event.title)
                    .lineLimit(1)
                    .foregroundStyle(.white)
                    .font(.system(size: 8, weight: .bold))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .frame(width: width, alignment: .center)
                    .background(event.color)
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
