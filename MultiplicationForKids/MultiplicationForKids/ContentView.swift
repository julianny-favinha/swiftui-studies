//
//  ContentView.swift
//  MultiplicationForKids
//
//  Created by Julianny Favinha on 26/09/20.
//

import SwiftUI

struct Question {
    let leftValue: Int
    let rightValue: Int

    var answer: Int {
        return leftValue * rightValue
    }
}

struct ContentView: View {
    @State private var tablesCount = 1
    @State private var questionIndex = 0
    @State private var questionsCount = ["5", "10", "20"]

    @State private var questions: [Question] = []

    @State private var leftValue = 1
    @State private var rightValue = 1
    @State private var answer = ""

    @State private var currentQuestion = 0

    @State private var correctAnswersCount = 0

    @State private var didFinishGame = false

    var body: some View {
        Form {
            Section(header: Text("How many tables do you want?")) {
                Stepper(value: $tablesCount, in: 1...12, step: 1, onEditingChanged: { _ in newGame() }) {
                    Text("\(tablesCount) tables")
                }
            }

            Section(header: Text("How many questions do you want to answer?")) {
                Picker("", selection: $questionIndex) {
                    ForEach(0 ..< questionsCount.count) {
                        Text("\(self.questionsCount[$0])")
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
                Text("\(correctAnswersCount)")
            }
        }
        .onAppear(perform: newGame)
        .alert(isPresented: $didFinishGame) {
            Alert(title: Text("Well done!"), message: nil, dismissButton: .default(Text("New game")) {
                self.newGame()
            })
        }
    }

    private func newGame() {
        guard let questionsCount = Int(questionsCount[questionIndex]) else {
            return
        }

        questions = []

        for _ in 0..<questionsCount {
            let leftValue = Int.random(in: 1...tablesCount)
            let rightValue = Int.random(in: 1...10)

            questions.append(Question(leftValue: leftValue, rightValue: rightValue))
        }

        currentQuestion = 0
        correctAnswersCount = 0
        answer = ""
        leftValue = questions[currentQuestion].leftValue
        rightValue = questions[currentQuestion].rightValue
    }

    private func evaluate() {
        guard let questionsCount = Int(questionsCount[questionIndex]) else {
            return
        }

        let userAnswer = Int(answer)
        let correctAnswer = questions[currentQuestion].answer

        correctAnswersCount += userAnswer == correctAnswer ? 1 : 0

        if currentQuestion + 1 < questionsCount {
            nextQuestion()
        } else {
            didFinishGame = true
        }
    }

    private func nextQuestion() {
        currentQuestion += 1
        answer = ""

        leftValue = questions[currentQuestion].leftValue
        rightValue = questions[currentQuestion].rightValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
