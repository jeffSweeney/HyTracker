//
//  OnboardingView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var startDate: Date? = nil
    @State private var eligibleWorkdays: Set<Weekday> = []
    @State private var requiredDays: Int? = nil
    
    // Binding date allows us to present our datepicker sheet an let our initial startDate be nil
    // TODO: Is there a better way to handle this?
    @State private var bindingDate: Date = .now
    
    @State private var showingDateSheet = false
    @State private var showingWorkdaySheet = false
    @State private var showingRequirementSheet = false
    
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
                Button(action: { showingDateSheet = true }, label: {
                    InputComponentView(component: .startDate(startDate))
                        .foregroundStyle(.black)
                })
                .sheet(isPresented: $showingDateSheet, onDismiss: { processDateSelectorSheet() }) {
                    DateSelectorSheet(selectedDate: $bindingDate)
                }
                
                Button(action: { showingWorkdaySheet = true }, label: {
                    InputComponentView(component: .eligibleWorkdays(eligibleWorkdays))
                        .foregroundStyle(.black)
                })
                .sheet(isPresented: $showingWorkdaySheet, onDismiss: {  }) {
                    EligibleWorkdaySheet(eligibleWorkdays: $eligibleWorkdays)
                }
                
                Button(action: { showingRequirementSheet = true }) {
                    InputComponentView(component: .requiredDays(requiredDays))
                        .foregroundStyle(.black)
                }
                .sheet(isPresented: $showingRequirementSheet, onDismiss: {  }) {
                    WeeklyRequirementsSheet()
                }
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

// MARK: Helper Functions
extension OnboardingView {
    private func processDateSelectorSheet() {
        if bindingDate > Date.now { // Indicates Cancel was tapped - don't persist result
            bindingDate = startDate ?? .now // Set back to last selection if we have one
        } else { // valid selection made
            self.startDate = bindingDate
        }
    }
}

#Preview {
    OnboardingView()
}
