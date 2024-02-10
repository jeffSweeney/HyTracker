//
//  HyTrackerApp.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

@main
struct HyTrackerApp: App {
    init() {
        // Exclusively light mode for now
        UIWindow.appearance().overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
