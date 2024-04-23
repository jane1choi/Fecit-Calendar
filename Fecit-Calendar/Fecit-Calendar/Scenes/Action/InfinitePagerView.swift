//
//  InfinitePagerView.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/23/24.
//

import SwiftUI

struct InfinitePagerView<Content: View>: View {
    private let content: (YearMonth, Int) -> Content
    @ObservedObject private var controller: CalendarController
    
    init(_ controller: CalendarController, @ViewBuilder content: @escaping (YearMonth, Int) -> Content) {
        self.controller = controller
        self.content = content
    }
    
    var body: some View {
        drawTabView { geometry in
            ForEach(0..<100, id: \.self) { i in
                let yearMonth = controller.internalYearMonth.addMonth(value: i - (100 / 2))
                self.content(yearMonth, i).frame(width: geometry.size.width, height: geometry.size.height)
                    .background(GeometryReader {
                        Color.clear.preference(key: ScrollOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ScrollOffsetKey.self) { controller.scrollDetector.send($0) }
            }
        }
    }
    
    private func drawTabView<V: View>(@ViewBuilder content: @escaping (GeometryProxy) -> V) -> some View {
        return GeometryReader { proxy in
            TabView(selection: $controller.position) {
                content(proxy)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .rotationEffect(.degrees(-90))
                    .rotation3DEffect(Angle(degrees: 0), axis: (x: 1, y: 0, z: 0))
                    .contentShape(Rectangle())
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotation3DEffect(Angle(degrees: 0), axis: (x: 1, y: 0, z: 0))
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .coordinateSpace(name: "scroll")
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
