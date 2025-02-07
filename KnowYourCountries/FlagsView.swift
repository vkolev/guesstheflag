//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 05.02.25.
//
import SwiftUI
import ConfettiView


struct FlagsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var countries = COUNTRIES.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showConfetti = false
    
    @State private var userScore = 0
    @EnvironmentObject private var currentScore: HighScoreFlags
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(LocalizedStringKey(countries[correctAnswer]))
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .padding(.all, 10.0)
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: 200,
                                    height: 100
                                )
                                .clipped()
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .overlay(ConfettiView(isPresented: $showConfetti))
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore.score)")
        }.navigationBarHidden(true)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
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
    FlagsView()
        .environmentObject(HighScoreFlags())
}
