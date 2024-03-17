//
//  LoginView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            VStack(spacing: 20) {
                AuthenticationTFComponent(component: .email, captureInput: $viewModel.email)
                
                AuthenticationTFComponent(component: .password, captureInput: $viewModel.password)
            }
            .padding()
            
            Button(action: {
                Task { try await viewModel.loginTapped() }
            }, label: {
                HTPrimaryButton(screen: .login,
                                isActionable: viewModel.loginFormComplete,
                                isLoading: $viewModel.isLoading)
            })
            .disabled(!viewModel.loginFormComplete || viewModel.isLoading)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .navigationBarBackButtonHidden()
        .modifier(WelcomeDismissModifier())
        .alert("Error", isPresented: $viewModel.showingAlert) {
            Button("Got it!") {
                viewModel.clearAlert()
            }
        } message: {
            Text(viewModel.alertMessage)
                .font(.subheadline)
        }

    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
