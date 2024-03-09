//
//  GenerateReportView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct GenerateReportView: View {
    @StateObject var viewModel: GenerateReportViewModel
    @State private var showingReport = false
    
    // Managing button eligibility state due to SwiftUI DatePicker bug
    // Bug: If you tap out of DatePicker (dismiss it) and hit the primary button, which presents a sheet, primary will no longer work due to "already presenting sheet (picker)" error.
    @State private var primaryDisabled = false
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: GenerateReportViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
                .padding(.vertical)
            
            VStack(spacing: 16) {
                Text("Generating a report will examine all non-exempt eligible workdays in your provided range, and calculate the percentage of those days you were in-office.")
            }
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            
            VStack(spacing: 24) {
                DatePicker(selection: $viewModel.reportStartDate, in: viewModel.reportStartRange, displayedComponents: .date) {
                    Text("Start Range:")
                        .font(.headline)
                }
                .onTapGesture { primaryDisabled = true }
                
                DatePicker(selection: $viewModel.reportEndDate, in: viewModel.reportEndRange, displayedComponents: .date) {
                    Text("End Range:")
                        .font(.headline)
                }
                .onTapGesture { primaryDisabled = true }
            }
            .padding()
            .padding(.horizontal, 24)
            
            
            Button(action: {
                showingReport = true
            }, label: {
                HTPrimaryButton(screen: .generateReport, isActionable: true)
            })
            .disabled(primaryDisabled)
            .padding(.vertical, 40)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .sheet(isPresented: $showingReport) {
            ReportView(viewModel: viewModel)
        }
        .onTapGesture {
            primaryDisabled = false
        }
    }
}

#Preview {
    GenerateReportView(user: User.REPORT_MOCK_USER)
}
