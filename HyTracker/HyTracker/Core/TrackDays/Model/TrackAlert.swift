//
//  TrackAlert.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/11/24.
//

import Foundation

enum TrackAlert {
    case notEligible
    case alreadyExists(TrackUpdateType)
    case success(TrackUpdateType)
    
    var title: String {
        switch self {
        case .notEligible, .alreadyExists: "Update Aborted"
        case .success: "Success!"
        }
    }
    
    var message: String {
        switch self {
        case .notEligible:
            "Today is not an eligible workday for analytics. Please update your profile requirements if they have changed."
        case .alreadyExists(let updateType):
            "You've already registered today as '\(updateType.alertContext)'. If you wish to remove it, please do so in the Bulk Updates section."
        case .success(let updateType):
            "You have successfully tracked today as \(updateType.alertContext)!"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .notEligible, .alreadyExists: "Got it!"
        case .success: "Done"
        }
    }
}
