//
//  BulkUpdatesView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/3/24.
//

import SwiftUI

struct BulkUpdatesView: View {
    let context: TrackUpdateType
    private let datesRange: [SimpleDate]
    
    @ObservedObject var viewModel: TrackDaysViewModel
    @State private var datesChecked: Set<SimpleDate> { didSet { madeChange() } }
    
    @Environment(\.dismiss) var dismiss
    
    init(context: TrackUpdateType, viewModel: TrackDaysViewModel) {
        self.context = context
        _viewModel = ObservedObject(wrappedValue: viewModel)
        datesRange = context == .inOffice ? viewModel.inOfficeDatesRange : viewModel.exemptDatesRange
        _datesChecked = State(initialValue: context == .inOffice ? viewModel.inOfficeDatesChecked : viewModel.exemptDatesChecked)
    }
    
    var body: some View {
        ScrollView { // Smaller iPhones cram the button if VStack
            HTLogoView(size: .xSmall)
            
            VStack(spacing: 8) {
                Text(context.headline)
                    .font(.headline)
                    .underline()
                
                Group {
                    Text("Only showing days within your \"Eligible Workdays\" range:")
                    
                    Text(viewModel.eligibleDaysSorted)
                        .bold()
                }
                .font(.footnote)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        if datesRange.isEmpty {
                            Text("No dates to display")
                                .font(.headline)
                        } else {
                            ForEach(datesRange) { simpleDate in
                                VStack(spacing: 0) {
                                    HStack {
                                        HStack {
                                            Text(simpleDate.asDate.dayOfTheWeek)
                                                .frame(width: 64)
                                            
                                            Text(simpleDate.asDate.sixDigitDate)
                                        }
                                        .font(.subheadline)
                                        
                                        Spacer()
                                        
                                        let systemName = datesChecked.contains(simpleDate) ? "checkmark.square" : "square"
                                        Image(systemName: systemName)
                                            .padding(.horizontal)
                                            .background(Color.clear)
                                            .clipShape(Rectangle())
                                            .onTapGesture {
                                                if datesChecked.contains(simpleDate) {
                                                    datesChecked.remove(simpleDate)
                                                } else {
                                                    datesChecked.insert(simpleDate)
                                                }
                                            }
                                    }
                                    .padding(.horizontal, 4)
                                    .contentShape(Rectangle())
                                    .padding()
                                    .background(Color.clear)
                                    
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(lineWidth: 1)
            }
            .padding()
            .padding(.horizontal)
            .frame(maxHeight: 350)
            
            Button {
                Task {
                    try await context == .inOffice ? 
                        viewModel.uploadOfficeDays(days: datesChecked) : viewModel.uploadExemptDays(days: datesChecked)
                }
                
                dismiss()
            } label: {
                HTPrimaryButton(context: .trackDays, isActionable: viewModel.madeBulkTrackUpdates)
            }
            .disabled(!viewModel.madeBulkTrackUpdates)

            Spacer()
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .navigationTitle(context.navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            madeChange()
        }
    }
}

extension BulkUpdatesView {
    private func madeChange() {
        let oldResult = context == .inOffice ? viewModel.inOfficeDatesChecked : viewModel.exemptDatesChecked
        viewModel.madeBulkTrackUpdates = oldResult != datesChecked
    }
}

#Preview {
    NavigationStack {
        BulkUpdatesView(context: .exempt, viewModel: TrackDaysViewModel(user: .TRACK_MOCK_USER))
    }
}
