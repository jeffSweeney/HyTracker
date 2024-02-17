//
//  OnboardingView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
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
                    InputComponentView(component: .startDate(viewModel.startDate), 
                                       isActionable: true)
                        .foregroundStyle(.black)
                })
                .sheet(isPresented: $showingDateSheet, onDismiss: { viewModel.processDateSelectorSheet() }) {
                    StartDateSelectorSheet(selectedDate: $viewModel.bindingDate)
                }
                
                Button(action: { showingWorkdaySheet = true }, label: {
                    // Only actionable if we've answered the first question
                    InputComponentView(component: .eligibleWorkdays(viewModel.eligibleWorkdays),
                                       isActionable: viewModel.answeredStartDate)
                        .foregroundStyle(.black)
                })
                .disabled(!viewModel.answeredStartDate)
                .sheet(isPresented: $showingWorkdaySheet, onDismiss: { viewModel.processEligibleWorkdaySheet() }) {
                    EligibleWorkdaySheet(eligibleWorkdays: $viewModel.eligibleWorkdays)
                }
                
                Button(action: { showingRequirementSheet = true }) {
                    // Only actionable if we've provided eligible days
                    InputComponentView(component: .requiredDays(viewModel.requiredDays), 
                                       isActionable: viewModel.answeredEligibleWorkdays)
                        .foregroundStyle(.black)
                }
                .disabled(!viewModel.answeredEligibleWorkdays)
                .sheet(isPresented: $showingRequirementSheet, onDismiss: { viewModel.processRequirementSheet() } ) {
                    WeeklyRequirementsSheet(requiredDaysCount: $viewModel.bindingCount, maxNumber: viewModel.eligibleWorkdays.count)
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
            .disabled(!viewModel.answeredAllOnboarding)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    OnboardingView()
}
