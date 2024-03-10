//
//  SimpleDate.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/5/24.
//

import Foundation

// TODO: Should we use this everywhere and abandon Date?
struct SimpleDate: Identifiable, Hashable, Equatable {
    let month: Int
    let day: Int
    let year: Int
    
    private let underlyingDate: Date
    
    var id: String { "\(year)-\(String(format: "%02d", month))-\(String(format: "%02d", day))" }
    
    init(fromDate: Date) {
        self.year = Calendar.current.component(.year, from: fromDate)
        self.month = Calendar.current.component(.month, from: fromDate)
        self.day = Calendar.current.component(.day, from: fromDate)
        
        self.underlyingDate = fromDate.startOfDay
    }
    
    var asDate: Date { return underlyingDate.startOfDay }
}

enum DateError: Error {
    case invalidFormat
}
