//
//  ActionView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject var controller = CalendarController()
   
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
            
            CalendarView(controller) { date in
                GeometryReader { geometry in
                    ZStack {
                        Text("\(date.day)")
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    ActionView()
}
