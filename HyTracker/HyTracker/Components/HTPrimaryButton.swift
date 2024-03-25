//
//  HTPrimaryButton.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct HTPrimaryButton: View {
    let context: ButtonContext
    let isActionable: Bool
    let size: ButtonSize
    @Binding var isLoading: Bool
    
    init(context: ButtonContext, isActionable: Bool, size: ButtonSize = .full, isLoading: Binding<Bool>? = nil) {
        self.context = context
        self.isActionable = isActionable
        self.size = size
        self._isLoading = isLoading ?? .constant(false)
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.25)
            } else {
                Text(context.label)
            }
        }
        .font(.headline)
        .foregroundStyle(.black)
        .frame(width: size.width, height: 40)
        .overlay {
            Capsule()
                .stroke(lineWidth: 2)
                .foregroundStyle(.black)
        }
        .padding()
        .opacity(isActionable ? 1 : 0.15)
    }
}

enum ButtonContext {
    case done
    case exempt
    case generateReport
    case getStarted
    case inOffice
    case login
    case profile
    case resetPassword
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
        case .resetPassword: "RESET PASSWORD"
        case .signup: "SIGN UP"
        case .trackDays: "TRACK UPDATES"
        }
    }
}

enum ButtonSize {
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
    HTPrimaryButton(context: .login, isActionable: true)
}
