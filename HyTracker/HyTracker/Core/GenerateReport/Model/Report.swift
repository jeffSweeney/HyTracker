//
//  Report.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/10/24.
//

import Foundation

struct Report {
    let officeDays: Int
    let totalDays: Int
    let errorMessage: String?
    
    init(officeDays: Int, totalDays: Int) {
        self.officeDays = officeDays
        self.totalDays = totalDays
        self.errorMessage = totalDays == 0 ? "No eligible workdays in report range. Choose a new range and/or update workdays preferences in your profile and try again." : nil
    }
    
    var percentage: String {
        guard errorMessage == nil else { return "0%" }
        
        let result = round(Double(officeDays)/Double(totalDays)*100)
        return "\(String(format: "%.0f", result))%"
    }
}
