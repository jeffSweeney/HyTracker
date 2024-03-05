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
    
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return dateFormatter.string(from: self)
    }
    
    var sixDigitDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        return dateFormatter.string(from: self)
    }
    
    var asWeekday: Weekday? {
        let weekdayIndex = Calendar.current.component(.weekday, from: self)
        
        switch weekdayIndex {
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4: 
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        default:
            return nil
        }
    }
}
