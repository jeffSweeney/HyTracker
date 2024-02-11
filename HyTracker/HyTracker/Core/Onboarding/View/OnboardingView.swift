//
//  OnboardingView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var startDate: Date? = Date()
    @State private var eligibleWorkdays: [Weekday] = [.tuesday, .wednesday, .thursday]
    @State private var requiredDays: Int? = 2
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("ht_logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .padding()
            
            Text("Before we get started, let's gather a little information about your tracking and requirements.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom], 24)
            
            VStack(alignment: .leading, spacing: 24) {
                InputComponentView(component: .startDate(startDate))
                
                InputComponentView(component: .eligibleWorkdays(eligibleWorkdays))
                
                InputComponentView(component: .requiredDays(requiredDays))
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                print("DEBUG: GET STARTED TAPPED")
            }, label: {
                Text("GET STARTED")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 40)
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.black)
                    }
                    .padding()
            })
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    OnboardingView()
}
