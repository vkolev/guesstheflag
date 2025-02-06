//
//  GuessTheFlagApp.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 05.02.25.
//

import SwiftUI

@main
struct GuessTheFlagApp: App {
    var score = HighScore()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(score)
        }
    }
}
