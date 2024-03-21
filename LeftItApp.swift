//
//  LeftItApp.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 20/03/24.
//

import SwiftUI

@main
struct LeftItApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                Onboard()
                    .onDisappear {
                        isOnboarding = false
                    }
            } else {
                ContentView()
            }
        }
    }
}
