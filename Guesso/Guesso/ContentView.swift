//
//  ContentView.swift
//  Guesso
//
//  Created by Amaan Amaan on 04/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore: Int = 0
    @State private var questionCount = 0
    @State private var showingFinalScore = false

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()

            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.white)

                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()

                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(userScore) out of 8")
        }
    }

    func askQuestion() {
        if questionCount < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            showingFinalScore = true
        }
    }

    func flagTapped(_ number: Int) {
        questionCount += 1

        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }

        if questionCount < 8 {
            showingScore = true
        } else {
            showingFinalScore = true
        }
    }

    func resetGame() {
        userScore = 0
        questionCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
