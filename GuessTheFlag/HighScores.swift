//
//  HighScore.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 06.02.25.
//
import SwiftUI

class HighScoreFlags: ObservableObject {
    @Published var score: Int = 0
    @Published var highScore: Int = 0
}

class HighScoreCapitals: ObservableObject {
    @Published var score: Int = 0
    @Published var highScore: Int = 0
}
