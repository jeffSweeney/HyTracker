//
//  ReportView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/25/24.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject var viewModel: GenerateReportViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HTLogoView(size: .xSmall)
                
                VStack(spacing: 8) {
                    Text("Report")
                        .underline()
                    
                    Text("\(viewModel.reportStartDate.asMediumHyTrackerDate) - \(viewModel.reportEndDate.asMediumHyTrackerDate)")
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
                    
                    VStack(spacing: 16) {
                        Text("Report percentage: \(viewModel.report?.percentage ?? "CALCULATING")")
                            .font(.headline)
                        
                        if let report = viewModel.report {
                            Group {
                                if let errorMessage = report.errorMessage {
                                    Text(errorMessage)
                                } else {
                                    let officeDaySP = report.officeDays == 1 ? "day" : "days"
                                    let totalDaySP = report.totalDays == 1 ? "day" : "days"
                                    HStack(spacing: 2) {
                                        Text("You made it to the office ") +
                                        Text("\(report.officeDays) \(officeDaySP) ").bold() +
                                        Text("of a possible ") +
                                        Text("\(report.totalDays) eligible \(totalDaySP) ").bold() +
                                        Text("during the report period.")
                                    }
                                }
                            }
                            .font(.subheadline)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.25)
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                
                Button(action: {
                    dismiss()
                }, label: {
                    HTPrimaryButton(screen: .done, isActionable: true)
                })
                .padding(.vertical)
            }
            .onAppear {
                viewModel.runReport()
            }
            .onDisappear {
                viewModel.report = nil
            }
            .navigationTitle("REPORT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
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
        ReportView(viewModel: GenerateReportViewModel(user: User.REPORT_MOCK_USER))
    }
}
