//
//  CalendarController.swift
//  Fecit-Calendar
//
//  Created by EUNJU on 4/22/24.
//

import SwiftUI
import Combine

final class CalendarController: ObservableObject {
    @Published var yearMonth: YearMonth
    @Published var position: Int = 100 / 2
    @Published var internalYearMonth: YearMonth
    
    let columnCount = 7
    let rowCount = 6
    let max: Int = 100
    let center: Int = 50
    let scrollDetector: CurrentValueSubject<CGFloat, Never>
    var cancellables = Set<AnyCancellable>()
    
    init(_ yearMonth: YearMonth = .current) {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        
        self.scrollDetector = detector
        self.internalYearMonth = yearMonth
        self.yearMonth = yearMonth
        
        detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                if let self = self {
                    let move = self.position - self.center
                    self.internalYearMonth = self.internalYearMonth.addMonth(value: move)
                    self.yearMonth = self.internalYearMonth
                    self.position = self.center
                    self.objectWillChange.send()
                }
            }
            .store(in: &cancellables)
    }
    
    func setYearMonth(year: Int, month: Int) {
        self.setYearMonth(YearMonth(year: year, month: month))
    }
    
    func setYearMonth(_ yearMonth: YearMonth) {
        self.yearMonth = yearMonth
        self.internalYearMonth = yearMonth
        self.position = self.center
        self.objectWillChange.send()
    }
    
    func scrollTo(year: Int, month: Int, isAnimate: Bool = true) {
        self.scrollTo(YearMonth(year: year, month: month), isAnimate: isAnimate)
    }
    
    func scrollTo(_ yearMonth: YearMonth, isAnimate: Bool = true) {
        if isAnimate {
            var diff = self.position - yearMonth.diffMonth(value: self.yearMonth)
            if diff < 0 {
                self.internalYearMonth = yearMonth.addMonth(value: self.center)
                diff = 0
                // 4 * 12 + 2 50
            } else if self.max <= diff {
                self.internalYearMonth = yearMonth.addMonth(value: -self.center + 1)
                diff = self.max - 1
            }
            self.objectWillChange.send()
            withAnimation { [weak self] in
                if let self = self {
                    self.position = diff
                    self.objectWillChange.send()
                }
            }
        } else {
            self.internalYearMonth = yearMonth
            self.yearMonth = yearMonth
            self.objectWillChange.send()
        }
    }
}

