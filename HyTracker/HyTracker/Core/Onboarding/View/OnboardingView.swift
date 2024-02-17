//
//  OnboardingView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    // Binding date allows us to present our datepicker sheet an let our initial startDate be nil
    // TODO: Is there a better way to handle this?
    @State private var bindingDate: Date = .now
    @State private var bindingCount: Int = 0
    
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
                    // First question is always actionable
                    InputComponentView(component: .startDate(viewModel.startDate), isActionable: true)
                        .foregroundStyle(.black)
                })
                .sheet(isPresented: $showingDateSheet, onDismiss: { processDateSelectorSheet() }) {
                    StartDateSelectorSheet(selectedDate: $bindingDate)
                }
                
                Button(action: { showingWorkdaySheet = true }, label: {
                    // Only actionable if we've answered the first question
                    InputComponentView(component: .eligibleWorkdays(viewModel.eligibleWorkdays), isActionable: viewModel.startDate != nil)
                        .foregroundStyle(.black)
                })
                .disabled(viewModel.startDate == nil)
                .sheet(isPresented: $showingWorkdaySheet, onDismiss: { processEligibleWorkdaySheet() }) {
                    EligibleWorkdaySheet(eligibleWorkdays: $viewModel.eligibleWorkdays)
                }
                
                Button(action: { showingRequirementSheet = true }) {
                    // Only actionable if we've provided eligible days
                    InputComponentView(component: .requiredDays(viewModel.requiredDays), isActionable: !viewModel.eligibleWorkdays.isEmpty)
                        .foregroundStyle(.black)
                }
                .disabled(viewModel.eligibleWorkdays.isEmpty)
                .sheet(isPresented: $showingRequirementSheet, onDismiss: { processRequirementSheet() } ) {
                    WeeklyRequirementsSheet(requiredDaysCount: $bindingCount, maxNumber: viewModel.eligibleWorkdays.count)
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
            bindingDate = viewModel.startDate ?? .now // Set back to last selection if we have one
        } else { // valid selection made
            viewModel.startDate = bindingDate
        }
    }
    
    private func processEligibleWorkdaySheet() {
        // Unset the required days if the new eligibleWorkdays is less than the previous selection
        if bindingCount > viewModel.eligibleWorkdays.count {
            bindingCount = 0
            viewModel.requiredDays = nil
        }
    }
    
    private func processRequirementSheet() {
        if bindingCount > 0 {
            viewModel.requiredDays = bindingCount
        }
    }
}

#Preview {
    OnboardingView()
}
