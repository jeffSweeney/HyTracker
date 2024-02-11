//
//  WelcomeView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("ht_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                
                VStack(spacing: 12) {
                    Text("HyTracker")
                        .font(.largeTitle)
                        .fontDesign(.serif)
                    
                    Text("stay on track")
                        .font(.title3)
                }
                
                Spacer()
                
                HStack(spacing: 32) {
                    NavigationLink {
                        LoginView()
                    } label: {
                        WelcomeButton(label: "LOG IN")
                    }
                    
                    NavigationLink {
                        SignupView()
                    } label: {
                        WelcomeButton(label: "SIGN UP")
                    }
                }
                .foregroundStyle(.black)
                .padding(.vertical)
            }
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
        }
    }
}

#Preview {
    WelcomeView()
}

struct WelcomeButton: View {
    let label: String
    
    var body: some View {
        Text(label)
            .frame(width: 150, height: 40)
            .overlay {
                Capsule().stroke(lineWidth: 1.5)
            }
    }
}
