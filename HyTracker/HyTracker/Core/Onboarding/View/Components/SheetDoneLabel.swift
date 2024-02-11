//
//  SheetDoneLabel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct SheetDoneLabel: View {
    var body: some View {
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
    }
}

#Preview {
    SheetDoneLabel()
}
