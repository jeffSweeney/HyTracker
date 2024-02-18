//
//  LoginView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            VStack(spacing: 20) {
                AuthenticationTFComponent(component: .email, captureInput: $email)
                
                AuthenticationTFComponent(component: .password, captureInput: $password)
            }
            .padding()
            
            Button(action: {
                print("DEBUG: LOG IN TAPPED")
            }, label: {
                AuthenticationPrimaryButton(screen: .login)
            })
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .navigationBarBackButtonHidden()
        .modifier(WelcomeDismissModifier())
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
