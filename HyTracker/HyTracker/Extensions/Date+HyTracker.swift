//
//  Date+HyTracker.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import Foundation

extension Date {
    var asHyTrackerDate: String {
        let formatter = DateFormatter()

        // Set the date style
        formatter.dateStyle = .medium

        // Convert the Date to a String
        return formatter.string(from: self)
    }
}
