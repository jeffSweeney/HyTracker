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
                viewModel.loginTapped()
            }, label: {
                HTPrimaryButton(screen: .login, isActionable: viewModel.loginFormComplete)
            })
            .disabled(!viewModel.loginFormComplete)
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
