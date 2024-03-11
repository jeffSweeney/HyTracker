//
//  TrackUpdateType.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/10/24.
//

import Foundation

enum TrackUpdateType {
    case exempt
    case inOffice
    
    var navTitle: String {
        switch self {
        case .exempt:
            "Track Exempt Days"
        case .inOffice:
            "Track Office Days"
        }
    }
    
    var headline: String {
        switch self {
        case .exempt:
            "Exempt from Analytics"
        case .inOffice:
            "Days in Office"
        }
    }
    
    var alertContext: String {
        switch self {
        case .exempt: "exempt"
        case .inOffice: "in-office"
        }
    }
}
