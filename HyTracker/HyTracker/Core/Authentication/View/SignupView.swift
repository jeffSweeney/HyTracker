//
//  SignupView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct SignupView: View {
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            VStack(spacing: 20) {
                AuthenticationTFComponent(component: .fullname, captureInput: $fullname)
                
                AuthenticationTFComponent(component: .email, captureInput: $email)
                
                AuthenticationTFComponent(component: .password, captureInput: $password)
            }
            .padding()
            
            Button(action: {
                print("DEBUG: SIGN UP TAPPED")
            }, label: {
                AuthenticationPrimaryButton(screen: .signup)
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
    SignupView()
}
