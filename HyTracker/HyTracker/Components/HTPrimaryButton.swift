//
//  HTPrimaryButton.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct HTPrimaryButton: View {
    let screen: Screen
    let isActionable: Bool
    
    var body: some View {
        Text(screen.label)
            .font(.headline)
            .foregroundStyle(.black)
            .frame(width: 300, height: 40)
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
    case getStarted
    case login
    case profile
    case signup
    
    var label: String {
        switch self {
        case .getStarted: "GET STARTED"
        case .login: "LOG IN"
        case .profile: "EDIT REQUIREMENTS"
        case .signup: "SIGN UP"
        }
    }
}

#Preview {
    HTPrimaryButton(screen: .login, isActionable: true)
}
