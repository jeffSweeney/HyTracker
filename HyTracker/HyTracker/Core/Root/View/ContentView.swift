//
//  ContentView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.showingLaunchScreen {
            LaunchScreen(viewModel: viewModel)
        } else {
            if viewModel.userSession != nil {
                if let user = viewModel.currentUser {
                    if user.hasOnboarded {
                        MainTabView(user: user)
                    } else {
                        OnboardingView()
                    }
                }
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
