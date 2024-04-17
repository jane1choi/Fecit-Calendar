//
//  CalendarView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

struct CalendarView: View {
   
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                
            }, label: {
                Text("TODAY")
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
            Text("March 2023")
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
        }
        .background(Color(.mainBlue))
        Spacer()
    }
}

#Preview {
    CalendarView()
}
