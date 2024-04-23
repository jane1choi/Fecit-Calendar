//
//  TabBarView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/17/24.
//

import SwiftUI

enum Tab {
    case achieve
    case action
    case memo
    case library
    case society
}

struct TabBarView: View {
    
    @State private var selection = Tab.action
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.mainGray
    }
    
    var body: some View {
        TabView(selection: $selection) {
            AchieveView()
                .tabItem {
                    tabItem(image: "sparkle", title: "Achieve")
                }
                .tag(Tab.achieve)
            ActionView()
                .tabItem {
                    tabItem(image: "calendar", title: "Action")
                }
                .tag(Tab.action)
            MemoView()
                .tabItem {
                    tabItem(image: "folder", title: "Memo")
                }
                .tag(Tab.memo)
            LibraryView()
                .tabItem {
                    tabItem(image: "suitcase", title: "Library")
                }
                .tag(Tab.library)
            SocietyView()
                .tabItem {
                    tabItem(image: "square.grid.2x2", title: "Society")
                }
                .tag(Tab.society)
        }
        .tint(.mainBlue)
    }
    
    @ViewBuilder func tabItem(image: String, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
            Text(title)
                .font(.system(size: 12))
        }
    }
}

#Preview {
    TabBarView()
}
