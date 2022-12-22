//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Андрей Коноплев on 30.11.2022.
//

import SwiftUI

struct FlagView: View {
    var nameOfCountry: String
    var didTap: () -> Void

    init(name: String, didTap: @escaping () -> Void) {
        self.nameOfCountry = name
        self.didTap = didTap
    }

    var body: some View {
        return Button {
            didTap()
        } label: {
            Image(nameOfCountry)
                .renderingMode(.original)
                .flagModifier()
        }
    }
}

struct FlagImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

extension Image {
    func flagModifier() -> some View {
        return modifier(FlagImageModifier())
    }
}

struct ContentView: View {

    @State
    private var showingScore = false

    @State
    private var scoreTitle = ""

    @State
    private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State
    private var correctAnswer = Int.random(in: 0...2)

    @State
    private var score = 0

    @State private
    var tappedFlagNumber: Int?

    @State private
    var isGameStart: Bool = false

    @State
    private var animationAmount: Double = 1


    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Угадай что за флаг?")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Какой твой ответ?")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in

                        FlagView(name: countries[number]) {
                            isGameStart = true
                            tappedFlagNumber = number
                            withAnimation {
                                    animationAmount += 180
                            }
                            flagTapped(number)
                        }
                        .opacity(tappedFlagNumber == number ? 1 : isGameStart ? 0.25 : 1)
                        .rotation3DEffect(.degrees(tappedFlagNumber == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()
                Text(score < 0 ? "Проиграл(" : "Очки: \(score)")
                    .foregroundColor(.white)
                    .font(.title2.weight(.bold))
                Spacer()
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Продолжить", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }

    private func flagTapped(_ number: Int) {

        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showingScore = true
        }
    }

    private func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        isGameStart = false
        tappedFlagNumber = -1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
