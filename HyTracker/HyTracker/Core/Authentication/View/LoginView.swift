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
                HTButton(context: .login,
                                isActionable: viewModel.loginFormComplete,
                                isLoading: $viewModel.isLoading)
            })
            .disabled(!viewModel.loginFormComplete || viewModel.isLoading)
            
            
            Button(action: {
                viewModel.showingForgotPasswordSheet = true
            }, label: {
                Text("Forgot Password?")
                    .font(.callout)
                    .foregroundStyle(.black)
                    .underline()
                    .padding(.vertical)
            })
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
        .sheet(isPresented: $viewModel.showingForgotPasswordSheet, content: {
            ForgotPasswordSheet()
        })
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
