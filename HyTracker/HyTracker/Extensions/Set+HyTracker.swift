//
//  Set+HyTracker.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/23/24.
//

import Foundation

extension Set where Element == Weekday {
    /// `asSortedHyTrackerString`
    /// Takes a set of Weekdays and sorts them in their short name for.
    /// i.e.
    /// `self: [.friday, .monday, .wednesday]`
    /// `output: "Mon, Wed, Fri"`
    var asSortedHyTrackerString: String {
        return self.sorted{$0.rawValue < $1.rawValue}.map{$0.label}.joined(separator: ", ")
    }
}
