//
//  BulkUpdatesView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/3/24.
//

import SwiftUI

struct BulkUpdatesView: View {
    let context: BulkUpdateType
    
    // TODO: Replace with view model data
    @State private var range: [Date] = Self.dummyRange()
    @State private var datesChecked: Set<Date> = []
    
    var body: some View {
        ScrollView { // Smaller iPhones cram the button if VStack
            HTLogoView(size: .xSmall)
            
            VStack(spacing: 8) {
                Text(context.headline)
                    .font(.headline)
                    .underline()
                
                Group {
                    Text("Only showing days within your \"Eligible Workdays\" range:")
                    
                    // TODO: Make eligible days dynamic
                    Text("Mon, Wed, Fri")
                        .bold()
                }
                .font(.footnote)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
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
                                    
                                    let systemName = datesChecked.contains(date) ? "checkmark.square" : "square"
                                    Image(systemName: systemName)
                                        .padding(.horizontal)
                                        .background(Color.clear)
                                        .clipShape(Rectangle())
                                        .onTapGesture {
                                            if datesChecked.contains(date) {
                                                datesChecked.remove(date)
                                            } else {
                                                datesChecked.insert(date)
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
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(lineWidth: 1)
            }
            .padding()
            .padding(.horizontal)
            .frame(height: 350)
            
            Button {
                print("DEBUG: Tapped Track Days")
            } label: {
                HTPrimaryButton(screen: .trackDays, isActionable: true) // TODO: Dynamic actionable based on changes
            }

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
    private static func dummyRange() -> [Date] {
        let today = Date.now
        let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: today)!
        var currentDate = twoMonthsAgo
        
        let calendar = Calendar.current
        let components = DateComponents(day: 1)
        var result: Set<Date> = []
        
        while currentDate <= today {
            result.insert(currentDate)
            
            if let nextDate = calendar.date(byAdding: components, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
        
        return result.sorted { $0 > $1 }
    }
}

#Preview {
    NavigationStack {
        BulkUpdatesView(context: .inOffice)
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
