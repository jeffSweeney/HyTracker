//
//  DateSelectorSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct DateSelectorSheet: View {
    @Binding var selectedDate: Date
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("ht_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding()
                
                Text("Setting your start date helps provide a stopping point for analytics. You will not be able to record attendance prior to this date, nor will they be counted against you in later tracking reports.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal, .bottom], 24)
                
                DatePicker(selection: $selectedDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date:")
                        .font(.headline)
                }
                .padding()
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("DONE")
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
            .navigationTitle("Start Date Selection")
            .navigationBarTitleDisplayMode(.inline)
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Effectively a "cancel". Set ineligible date to indicate no selection made.
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
    DateSelectorSheet(selectedDate: .constant(Date.now))
}
