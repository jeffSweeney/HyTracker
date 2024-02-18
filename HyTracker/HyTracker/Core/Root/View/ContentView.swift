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
        if viewModel.userSession != nil {
            // TODO: Check if user still needs to onboard before going to MainTabView
            MainTabView()
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
