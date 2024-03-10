//
//  StartDateSelectorSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct StartDateSelectorSheet: View {
    @Binding var selectedDate: Date
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HTLogoView(size: .normal)
                
                Text("Setting your start date helps provide a stopping point for analytics. You will not be able to record attendance prior to this date, nor will they be counted against you in later tracking reports.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal, .bottom], 24)
                
                DatePicker(selection: $selectedDate, in: ...Date.today, displayedComponents: .date) {
                    Text("Select a date:")
                        .font(.headline)
                }
                .padding()
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    SheetDoneLabel()
                })
            }
            .navigationTitle("Start Date Selection")
            .navigationBarTitleDisplayMode(.inline)
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Cancel: Set ineligible date to indicate no selection made.
                        selectedDate = Date.distantFuture
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontDesign(.serif)
                    })
                }
            }
        }
    }
}

#Preview {
    StartDateSelectorSheet(selectedDate: .constant(Date.today))
}
