//
//  ContentView.swift
//  MultiplicationForKids
//
//  Created by Julianny Favinha on 26/09/20.
//

import SwiftUI

struct ContentView: View {
    private let values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    @State private var leftValue = 1
    @State private var rightValue = 1
    @State private var answer = ""

    @State private var isCorrectAnswer = false
    @State private var shouldShowResult = false

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("What is")

            HStack {
                Text(" \(leftValue) ")
                    .frame(minWidth: 0, maxWidth: .infinity)

                Text(" X ")
                    .frame(minWidth: 0, maxWidth: .infinity)

                Text(" \(rightValue) ")
                    .frame(minWidth: 0, maxWidth: .infinity)

                Text(" = ")
                    .frame(minWidth: 0, maxWidth: .infinity)

                TextField("", text: $answer)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)

                Button(action: {
                    evaluate()
                }) {
                    Text("OK")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }

            if shouldShowResult {
                Text("\(isCorrectAnswer ? "CORRECT!" : "WRONG!")")
            }
        }
        .padding()
        .onAppear(perform: newGame)
    }

    private func newGame() {
        let leftIndex = Int.random(in: 0..<values.count)
        let rightIndex = Int.random(in: 0..<values.count)

        answer = ""
        leftValue = values[leftIndex]
        rightValue = values[rightIndex]

        shouldShowResult = false
    }

    private func evaluate() {
        let left = Int(leftValue)
        let right = Int(rightValue)
        let userAnswer = Int(answer)
        let correctAnswer = left * right

        isCorrectAnswer = userAnswer == correctAnswer
        shouldShowResult = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            newGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
