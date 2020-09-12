//
//  ContentView.swift
//  WorldScramble
//
//  Created by Julianny Favinha on 12/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isShowingError = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
                .alert(isPresented: $isShowingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more creative")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "Type a real word")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "Type a real word")
            return
        }

        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) else {
                fatalError("Could not load words")
        }

        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()

        for letter in word {
            if let pos  = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return mispelledRange.location  == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isShowingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
