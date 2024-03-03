//
//  Date+HyTracker.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import Foundation

extension Date {
    private func asHyTrackerDate(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()

        // Set the date style
        formatter.dateStyle = style

        // Convert the Date to a String
        return formatter.string(from: self)
    }
    
    var asShortHyTrackerDate: String { return asHyTrackerDate(style: .short) }
    var asMediumHyTrackerDate: String { return asHyTrackerDate(style: .medium) }
    var asLongHyTrackerDate: String { return asHyTrackerDate(style: .long) }
    var asFullHyTrackerDate: String { return asHyTrackerDate(style: .full) }
}
