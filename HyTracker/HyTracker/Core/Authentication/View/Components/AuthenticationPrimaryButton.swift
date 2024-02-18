//
//  AuthenticationPrimaryButton.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct AuthenticationPrimaryButton: View {
    let screen: Screen
    
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
    }
}

enum Screen {
    case login
    case signup
    
    var label: String {
        switch self {
        case .login: "LOG IN"
        case .signup: "SIGN UP"
        }
    }
}

#Preview {
    AuthenticationPrimaryButton(screen: .login)
}
