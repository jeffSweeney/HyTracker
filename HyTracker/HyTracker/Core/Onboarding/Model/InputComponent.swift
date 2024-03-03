//
//  InputComponent.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import Foundation

enum InputComponent {
    case startDate(Date?)
    case eligibleWorkdays(Set<Weekday>)
    case requiredDaysCount(Int?)
    
    var hasInput: Bool {
        switch self {
        case .startDate(let date):
            return date != nil
        case .eligibleWorkdays(let workdays):
            return !workdays.isEmpty
        case .requiredDaysCount(let numberOfDays):
            return numberOfDays != nil
        }
    }
    
    var textLabel: String {
        switch self {
        case .startDate(let date):
            return date?.asMediumHyTrackerDate ?? "Select Starting Range"
        case .eligibleWorkdays(let workdays):
            if workdays.isEmpty {
                return "Select Eligible Workdays"
            } else {
                return workdays.asSortedHyTrackerString
            }
        case .requiredDaysCount(let numberOfDays):
            if let numberOfDays = numberOfDays {
                return "\(numberOfDays)"
            } else {
                return "Select Weekly Requirement"
            }
        }
    }
}
