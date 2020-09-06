//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Julianny Favinha on 05/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var isShowingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                VStack(spacing: 15) {
                    Text("Tap the flag of...")
                        .font(.callout)

                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .bold()
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }
                }

                Text("Your score is \(score)")
                    .font(.callout)

                Spacer()
            }
        }
        .alert(isPresented: $isShowingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct ✅"
            scoreMessage = ""
            score += 10
        } else {
            scoreTitle = "Wrong ❌"
            scoreMessage = "That's the flag of \(countries[number])"
            score -= 5
        }

        isShowingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
