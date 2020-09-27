//
//  ContentView.swift
//  MultiplicationForKids
//
//  Created by Julianny Favinha on 26/09/20.
//

import SwiftUI

struct ContentView: View {
    @State private var tablesCount = 1
    @State private var questionIndex = 0
    @State private var questions = ["5", "10", "20"]

    @State private var leftValues: [Int] = []
    @State private var rightValues: [Int] = []

    @State private var leftValue = 1
    @State private var rightValue = 1
    @State private var answer = ""

    @State private var currentQuestion = 0

    @State private var correctAnswers = 0

    @State private var isShowingFinish = false

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Form {
                Section(header: Text("How many tables do you want?")) {
                    Stepper(value: $tablesCount, in: 1...12, step: 1, onEditingChanged: { _ in newGame() }) {
                        Text("\(tablesCount) tables")
                    }
                }

                Section(header: Text("How many questions do you want to answer?")) {
                    Picker("", selection: $questionIndex) {
                        ForEach(0 ..< questions.count) {
                            Text("\(self.questions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
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
                                Text("Test")
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }

                Section(header: Text("Correct answers")) {
                    Text("\(correctAnswers)")
                }
            }
        }
        .onAppear(perform: newGame)
        .alert(isPresented: $isShowingFinish) {
            Alert(title: Text("Well done!"), message: nil, dismissButton: .default(Text("Continue")) {
                self.newGame()
            })
        }
    }

    private func newGame() {
        guard let questionsCount = Int(questions[questionIndex]) else {
            return
        }

        var tables: [Int] = []
        for index in 1...tablesCount {
            tables.append(index)
        }

        var values: [Int] = []
        for _ in 0..<questionsCount {
            let randomIndex = Int.random(in: 0..<tablesCount)
            values.append(tables[randomIndex])
        }
        leftValues = values

        tables = []
        for index in 1...10 {
            tables.append(index)
        }

        values = []
        for _ in 0..<questionsCount {
            let randomIndex = Int.random(in: 0..<10)
            values.append(tables[randomIndex])
        }
        rightValues = values

        currentQuestion = 0
        correctAnswers = 0
        answer = ""
        leftValue = leftValues[currentQuestion]
        rightValue = rightValues[currentQuestion]
    }

    private func evaluate() {
        guard let questionsCount = Int(questions[questionIndex]) else {
            return
        }

        let left = Int(leftValue)
        let right = Int(rightValue)
        let userAnswer = Int(answer)
        let correctAnswer = left * right

        correctAnswers += userAnswer == correctAnswer ? 1 : 0

        if currentQuestion + 1 < questionsCount {
            nextQuestion()
        } else {
            isShowingFinish = true
        }
    }

    private func nextQuestion() {
        currentQuestion += 1
        answer = ""

        leftValue = leftValues[currentQuestion]
        rightValue = rightValues[currentQuestion]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
