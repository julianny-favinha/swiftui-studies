//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Julianny Favinha on 06/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]

    @State private var moveIndex = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()

    @State private var isShowingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("The computer choose \(moves[moveIndex])")

            Text("To \(shouldWin ? "win" : "lose"), you should choose:")

            HStack(spacing: 20) {
                ForEach(0..<3) { index in
                    Button(action: {
                        self.didTapButton(index)
                    }) {
                        Image("\(self.moves[index])")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .accentColor(Color.green)
                    }
                    .frame(width: 70, height: 70, alignment: .center)
                }
            }

            Spacer()

            Text("Score: \(score)")

            Spacer()
        }
        .alert(isPresented: $isShowingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func didTapButton(_ userIndex: Int) {
        let moves = ["Scissors", "Rock", "Paper", "Scissors", "Rock"]
        let computerIndex = shouldWin ? moveIndex + 2 : moveIndex

        if moves[userIndex + 1] == moves[computerIndex] {
            scoreTitle = "Correct ✅"
                scoreMessage = ""
                score += 10
        } else {
            scoreTitle = "Wrong ❌"
            scoreMessage = "You should choose \(moves[computerIndex])"
            score -= 5
        }

        isShowingScore = true
    }

    func askQuestion() {
        moveIndex = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
