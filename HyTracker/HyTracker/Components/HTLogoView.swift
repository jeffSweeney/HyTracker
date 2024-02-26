//
//  HTLogoView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct HTLogoView: View {
    let size: HTLogoSize
    
    var body: some View {
        Image("ht_logo")
            .resizable()
            .scaledToFill()
            .frame(width: size.dimension, height: size.dimension)
            .padding()
    }
}

enum HTLogoSize {
    case small
    case normal
    
    var dimension: CGFloat {
        switch self {
        case .small: 120
        case .normal: 150
        }
    }
}

#Preview {
    HTLogoView(size: .normal)
}
