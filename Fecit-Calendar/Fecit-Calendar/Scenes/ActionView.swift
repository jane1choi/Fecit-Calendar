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
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay {
                Text("\(month.formatted(.dateTime.month(.wide).year()))")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            .background(Color(.mainBlue))
            
            HStack(alignment: .center) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    if day != "SAT" {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color(.mainBlue))
            Spacer()
        }
    }
}

#Preview {
    ActionView()
}
