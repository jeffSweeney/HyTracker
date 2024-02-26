//
//  ReportView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/25/24.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @Binding var showingReport: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HTLogoView(size: .small)
                
                VStack(spacing: 8) {
                    Text("Report")
                        .underline()
                    
                    Text("\(viewModel.reportStartDate.asHyTrackerDate) - \(viewModel.reportEndDate.asHyTrackerDate)")
                }
                .font(.headline)
                .padding(.bottom)
                
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        Text("Target percentage: \(viewModel.targetPercentage)")
                            .font(.headline)
                        
                        HStack(spacing: 2) {
                            Text("Your target percentage is determined by your weekly commitment (") +
                            Text("\(viewModel.weeklyRequirementTotal) days").bold() +
                            Text(") divided by the number of eligible days (") +
                            Text(viewModel.eligibleDaysSorted).bold() +
                            Text(") in a typical work week of non-exempt days.")
                        }
                        .font(.subheadline)
                    }
                    
                    // TODO: All dummy data right now
                    VStack(spacing: 16) {
                        Text("Actual percentage: \(viewModel.actualPercentage)")
                            .font(.headline)
                        
                        HStack(spacing: 2) {
                            Text("Of a possible ") +
                            Text("12 ").bold() +
                            Text("non-exempt, eligible workdays, you logged ") +
                            Text("9 days ").bold() +
                            Text("in office.")
                         }
                        .font(.subheadline)
                    }
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                
                Button(action: {
                    showingReport = false
                }, label: {
                    HTPrimaryButton(screen: .done, isActionable: true)
                })
                .padding(.vertical)
            }
            .navigationTitle("REPORT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showingReport = false
                    }, label: {
                        Text("Dismiss")
                            .font(.subheadline)
                    })
                }
            }
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
        }
    }
}

#Preview {
    NavigationStack {
        ReportView(viewModel: MainTabViewModel(user: User.REPORT_MOCK_USER), showingReport: .constant(true))
    }
}
