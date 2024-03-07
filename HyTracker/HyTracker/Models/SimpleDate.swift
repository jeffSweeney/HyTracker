//
//  SimpleDate.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/5/24.
//

import Foundation

// TODO: Should we use this everywhere and abandon Date?
struct SimpleDate: Codable, Hashable, Equatable {
    let month: Int
    let day: Int
    let year: Int
    
    init(month: Int, day: Int, year: Int) {
        self.month = month
        self.day = day
        self.year = year
    }
    
    init(fromDate: Date) {
        self.year = Calendar.current.component(.year, from: fromDate)
        self.month = Calendar.current.component(.month, from: fromDate)
        self.day = Calendar.current.component(.day, from: fromDate)
    }
    
    func asDate() throws -> Date {
        let calendar = Calendar.current
        let components = DateComponents(year: self.year, month: self.month, day: self.day)
        
        if let date = calendar.date(from: components) {
            return date
        } else {
            throw DateError.invalidFormat
        }
    }
}

enum DateError: Error {
    case invalidFormat
}
