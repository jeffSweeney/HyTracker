//
//  LaunchScreen.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/20/24.
//

import SwiftUI

struct LaunchScreen: View {
    @ObservedObject var viewModel: ContentViewModel
    
    @State var size = 1.1
    @State var opacity = 0.3
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
        }
        .scaleEffect(size)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut(duration: 3.9)) {
                self.size = 1.6
                self.opacity = 1.5
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                viewModel.showingLaunchScreen = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}
