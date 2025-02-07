//
//  GuessTheFlagApp.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 05.02.25.
//

import SwiftUI

@main
struct GuessTheFlagApp: App {
    var scoreFlags = HighScoreFlags()
    var scoreCapitals = HighScoreCapitals()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(scoreFlags)
                .environmentObject(scoreCapitals)
        }
    }
}
