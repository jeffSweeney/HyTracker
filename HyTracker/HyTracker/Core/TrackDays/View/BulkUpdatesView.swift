//
//  BulkUpdatesView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/3/24.
//

import SwiftUI

struct BulkUpdatesView: View {
    let context: BulkUpdateType
    private let range: [Date]
    
    @ObservedObject var viewModel: MainTabViewModel
    @State private var datesChecked: Set<SimpleDate> { didSet { madeChange() } }
    
    @Environment(\.dismiss) var dismiss
    
    init(context: BulkUpdateType, viewModel: MainTabViewModel) {
        self.context = context
        _viewModel = ObservedObject(wrappedValue: viewModel)
        range = context == .inOffice ? viewModel.inOfficeRange : viewModel.exemptRange
        _datesChecked = State(initialValue: context == .inOffice ? viewModel.inOfficeSimpleDates : viewModel.exemptSimpleDates)
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
                        if range.isEmpty {
                            Text("No dates to display")
                                .font(.headline)
                        } else {
                            ForEach(range, id: \.self) { date in
                                VStack(spacing: 0) {
                                    HStack {
                                        HStack {
                                            Text(date.dayOfTheWeek)
                                                .frame(width: 64)
                                            
                                            Text(date.sixDigitDate)
                                        }
                                        .font(.subheadline)
                                        
                                        Spacer()
                                        
                                        let systemName = datesChecked.contains(date.asSimpleDate) ? "checkmark.square" : "square"
                                        Image(systemName: systemName)
                                            .padding(.horizontal)
                                            .background(Color.clear)
                                            .clipShape(Rectangle())
                                            .onTapGesture {
                                                if datesChecked.contains(date.asSimpleDate) {
                                                    datesChecked.remove(date.asSimpleDate)
                                                } else {
                                                    datesChecked.insert(date.asSimpleDate)
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
                print("DEBUG: Tapped Track Days")
                Task {
                    try await context == .inOffice ? 
                        viewModel.uploadOfficeDays(days: datesChecked) : viewModel.uploadExemptDays(days: datesChecked)
                }
                
                dismiss()
            } label: {
                HTPrimaryButton(screen: .trackDays, isActionable: viewModel.madeBulkTrackUpdates)
            }
            .disabled(!viewModel.madeBulkTrackUpdates)

            Spacer()
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .navigationTitle(context.navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension BulkUpdatesView {
    private func madeChange() {
        let oldResult = context == .inOffice ? viewModel.inOfficeSimpleDates : viewModel.exemptSimpleDates
        viewModel.madeBulkTrackUpdates = oldResult != datesChecked
    }
}

#Preview {
    NavigationStack {
        BulkUpdatesView(context: .exempt, viewModel: MainTabViewModel(user: .TRACK_MOCK_USER))
    }
}

enum BulkUpdateType {
    case exempt
    case inOffice
    
    var navTitle: String {
        switch self {
        case .exempt:
            "Track Exempt Days"
        case .inOffice:
            "Track Office Days"
        }
    }
    
    var headline: String {
        switch self {
        case .exempt:
            "Exempt from Analytics"
        case .inOffice:
            "Days in Office"
        }
    }
}
