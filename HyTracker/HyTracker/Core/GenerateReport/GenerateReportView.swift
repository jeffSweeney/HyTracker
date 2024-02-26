//
//  GenerateReportView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct GenerateReportView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
                .padding(.vertical)
            
            VStack(spacing: 16) {
                Text("Generating a report will examine all non-exempt eligible workdays in your provided range, and calculate the percentage of those days you were in-office.")
                
                // TODO: The code below might be better in the report sheet?
//                HStack(spacing: 2) {
//                    Text("Your target percentage is determined by your weekly commitment (") +
//                    Text("\(viewModel.weeklyRequirementTotal) days").bold() +
//                    Text(") divided by the number of eligible days (") +
//                    Text(viewModel.eligibleDaysSorted).bold() +
//                    Text(") in a typical work week of non-exempt days.")
//                }
//                
//                HStack(spacing: 2) {
//                    Text("Target percentage: ") +
//                    Text(viewModel.targetPercentage).bold()
//                }
            }
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            
            VStack(spacing: 24) {
                DatePicker(selection: $viewModel.reportStartDate, in: viewModel.reportStartRange, displayedComponents: .date) {
                    Text("Start Range:")
                        .font(.headline)
                }
                
                DatePicker(selection: $viewModel.reportEndDate, in: viewModel.reportEndRange, displayedComponents: .date) {
                    Text("End Range:")
                        .font(.headline)
                }
            }
            .padding()
            .padding(.horizontal, 24)
            
            
            Button(action: {
                print("DEBUG: Tapped Generate Report")
            }, label: {
                HTPrimaryButton(screen: .generateReport, isActionable: true)
            })
            .padding(.top, 40)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    GenerateReportView(viewModel: MainTabViewModel(user: User.REPORT_MOCK_USER))
}
