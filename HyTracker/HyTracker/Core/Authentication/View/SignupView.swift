//
//  SignupView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            VStack(spacing: 20) {
                AuthenticationTFComponent(component: .fullname, captureInput: $viewModel.fullname)
                
                AuthenticationTFComponent(component: .email, captureInput: $viewModel.email)
                
                AuthenticationTFComponent(component: .password, captureInput: $viewModel.password)
            }
            .padding()
            
            Button(action: {
                Task { try await viewModel.signupTapped() }
            }, label: {
                HTPrimaryButton(context: .signup,
                                isActionable: viewModel.signupFormComplete,
                                isLoading: $viewModel.isLoading)
            })
            .disabled(!viewModel.signupFormComplete || viewModel.isLoading)
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
