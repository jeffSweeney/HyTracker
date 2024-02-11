//
//  Weekday.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import Foundation

enum Weekday: Int, CaseIterable, Identifiable {
    var id: Self { return self }
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    
    var label: String {
        switch self {
        case .monday: "Mon"
        case .tuesday: "Tue"
        case .wednesday: "Wed"
        case .thursday: "Thu"
        case .friday: "Fri"
        }
    }
}
