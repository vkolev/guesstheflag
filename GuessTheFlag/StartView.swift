//
//  StartView.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 06.02.25.
//

import SwiftUI

struct StartView : View {
    
    @State var isPresenting = false
    
    @EnvironmentObject var scoreFlags: HighScoreFlags
    @EnvironmentObject var scoreCapitals: HighScoreCapitals
    
    var body : some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    HStack {
                        Image("guess-the-flag")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 20)
                    }
                    
                    Text("Flags high score: \(scoreFlags.highScore)")
                        .bold()
                        .padding(.all, 10)
                    Text("Capitals high Score: \(scoreCapitals.highScore)")
                        .bold()
                        .padding(.all, 10)
                    Spacer()
                    VStack {
                        
                        
                        NavigationLink(
                            destination: FlagsView()
                        ) {
                            Label("Start Flags Game", systemImage: "flag.fill")
                        }.foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45)).padding(.all, 30)
                            .frame(width: 300, height: 50)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                        
                        NavigationLink(destination: CapitalsView()) {
                            Label("Start Capitals Game", systemImage: "location.fill")
                        }.foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45)).padding(.all, 30)
                            .frame(width: 300, height: 50)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                    }
                    
                    Spacer()
                    }.ignoresSafeArea()
                }
                
                
            }
    }
}


#Preview {
    StartView().environmentObject(HighScoreFlags())
        .environmentObject(HighScoreCapitals())
}
