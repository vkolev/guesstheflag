//
//  CapitalsView.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 07.02.25.
//

import SwiftUI
import ConfettiView

struct CapitalsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var countries = CAPITALS.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showConfetti = false
    
    @State private var userScore = 0
    @EnvironmentObject private var currentScore: HighScoreCapitals
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.5, green: 0.10, blue: 0.50), location: 0.3),
                .init(color: Color(red: 0.2, green: 0.1, blue: 0.45), location: 0.3)
                
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Capital")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.black)
                
                VStack {
                    Text(LocalizedStringKey(countries[correctAnswer].name))
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)
                    
                    ForEach(0..<3) { number in
                        Button {
                            capitalTapped(number)
                        } label: {
                            Text(LocalizedStringKey(countries[number].capital))
                                .padding(.all, 10.0)
                                .font(.title2.weight(.bold))
                                .foregroundStyle(.black)
                                .frame(
                                    width: 300,
                                    height: 100
                                )
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .overlay(ConfettiView(isPresented: $showConfetti))
                
                Spacer()
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore.score)")
        }.navigationBarHidden(true)
    }
    
    func capitalTapped(_ number: Int) {
        if countries[number].capital == countries[correctAnswer].capital {
            scoreTitle = "Correct"
            userScore += 1
            currentScore.score += 1
            if (currentScore.score > currentScore.highScore) {
                // Show confetti every time the highScore is lower then the current score
                showConfetti = true
            }
        } else {
            scoreTitle = "Game Over!"
            // Update the HighScore only if it is Higher then last
            if (currentScore.highScore < userScore) {
                currentScore.highScore = userScore
            }
            userScore = 0
            currentScore.score = 0
        }
        showingScore = true
    }
    
    func askQuestion() {
        if userScore == 0 {
            // Game over -> return to Start Screen
            presentationMode.wrappedValue.dismiss()
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    CapitalsView()
        .environmentObject(HighScoreCapitals())
}
