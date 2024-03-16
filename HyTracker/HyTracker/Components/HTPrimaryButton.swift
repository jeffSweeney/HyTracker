//
//  HTPrimaryButton.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct HTPrimaryButton: View {
    let style: PrimaryStyle
    let screen: Screen
    let isActionable: Bool
    @Binding var isLoading: Bool
    
    init(screen: Screen, isActionable: Bool, style: PrimaryStyle = .full, isLoading: Binding<Bool>? = nil) {
        self.style = style
        self.screen = screen
        self.isActionable = isActionable
        self._isLoading = isLoading ?? .constant(false)
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.25)
            } else {
                Text(screen.label)
            }
        }
        .font(.headline)
        .foregroundStyle(.black)
        .frame(width: style.width, height: 40)
        .overlay {
            Capsule()
                .stroke(lineWidth: 2)
                .foregroundStyle(.black)
        }
        .padding()
        .opacity(isActionable ? 1 : 0.15)
    }
}

enum Screen {
    case done
    case exempt
    case generateReport
    case getStarted
    case inOffice
    case login
    case profile
    case signup
    case trackDays
    
    var label: String {
        switch self {
        case .done: "DONE"
        case .exempt: "Exempt" // Split style - ALL CAPS not preferred
        case .generateReport: "GENERATE REPORT"
        case .getStarted: "GET STARTED"
        case .inOffice: "In-Office" // Split style - ALL CAPS not preferred
        case .login: "LOG IN"
        case .profile: "EDIT REQUIREMENTS"
        case .signup: "SIGN UP"
        case .trackDays: "TRACK UPDATES" // TODO: Probably remove this one?
        }
    }
}

enum PrimaryStyle {
    case full
    case split
    
    var width: CGFloat {
        switch self {
        case .full: return 300
        case .split: return 150
        }
    }
}

#Preview {
    HTPrimaryButton(screen: .login, isActionable: true)
}
