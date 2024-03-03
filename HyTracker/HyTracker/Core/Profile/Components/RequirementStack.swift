//
//  RequirementStack.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/23/24.
//

import SwiftUI

struct RequirementStack: View {
    let user: User
    let requirement: RequirementComponent
    
    var body: some View {
        VStack(spacing: 18) {
            Text(requirement.label)
                .lineLimit(2)
            
            Text(requirement.commitmentParam(from: user))
                .fontWeight(.semibold)
        }
        .multilineTextAlignment(.center)
        .font(.footnote)
        .frame(width: 100)
    }
}

#Preview {
    RequirementStack(user: User.PROFILE_MOCK_USER, requirement: .eligibleDays)
}

// MARK: - Requirement Component
enum RequirementComponent {
    case startDate
    case eligibleDays
    case totalDays
    
    var label: String {
        switch self {
        case .startDate:
            "Analytics Start Date"
        case .eligibleDays:
            "Eligible Office Days"
        case .totalDays:
            "Weekly Requirements"
        }
    }
    
    func commitmentParam(from user: User) -> String {
        var result: String? = nil
        
        switch self {
        case .startDate:
            result = user.startDate?.asMediumHyTrackerDate
        case .eligibleDays:
            result = user.eligibleDays?.asSortedHyTrackerString
        case .totalDays:
            if let total = user.weeklyRequirementTotal {
                let suffix = total > 1 ? "days" : "day"
                result = "\(total) \(suffix)"
            }
        }
        
        return result ?? "UNKNOWN"
    }
}
