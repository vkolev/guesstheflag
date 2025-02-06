//
//  HighScore.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 06.02.25.
//
import SwiftUI

class HighScore: ObservableObject {
    @Published var score: Int = 0
    @Published var highScore: Int = 0
}
