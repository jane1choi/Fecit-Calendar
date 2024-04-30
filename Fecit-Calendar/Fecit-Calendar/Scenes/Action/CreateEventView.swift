//
//  CreateEventView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/29/24.
//

import SwiftUI

struct CreateEventView: View {
    @Binding var isPresented: Bool
    @Binding var schedules: [YearMonthDay: [Event]]
    @Binding var targetDate: YearMonthDay?
    @State var eventTitle: String = ""
    @State var eventContent: String = ""
    @State var selectedColorName: String = "기본 색상"
    @State var selectedColor: Color = .blue
    private let colors: [String] = ["빨강", "오렌지", "노랑", "보라", "기본 색상"]
    private let colorsDic: [String: Color] = ["빨강": .red, "오렌지": .orange, "노랑": .yellow, "보라": .purple, "기본 색상": .blue]
    private let today = YearMonthDay.today
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("일정 제목", text: $eventTitle)
                .autocorrectionDisabled()
                .font(.system(size: 34))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .frame(height: 50)
            
            Text("\(String(targetDate?.year ?? today.year))년 \(targetDate?.month ?? today.month)월 \(targetDate?.day ?? today.day)일")
            
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(selectedColor)
                    .frame(width: 20, height: 20)
                Picker(selection: $selectedColorName, label: Text("기본 색상")) {
                    ForEach(colors, id: \.self) { color in
                        Text(color)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.black)
                .onChange(of: selectedColorName) { _, newValue in
                    selectedColor = colorsDic[newValue] ?? .blue
                }
            }
            
            TextField("설명 추가", text: $eventContent)
                .autocorrectionDisabled()
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .frame(height: 50)
            Spacer()
            
            Button(action: {
                isPresented = false
            }, label: {
                Text("일정 추가하기")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
            })
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.mainBlue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background(.white)
    }
}

