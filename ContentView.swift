//
//  ContentView.swift
//  AngryDog
//
//  Created by 杉山栞奈 on 2024/06/28.
//

import SwiftUI

struct ContentView: View {
    @State private var revealedDogs = Array(repeating: false, count: 20)
    @State private var angryDogIndex = Int.random(in: 0..<20)
    @State private var showResult = false
    @State private var resultMessage = ""

    var body: some View {
        VStack {
            Text("Find the Angry Dog!")
                .font(.largeTitle)
                .padding()

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(0..<20, id: \.self) { index in
                    DogView(isRevealed: revealedDogs[index], isAngry: index == angryDogIndex)
                        .onTapGesture {
                            if !revealedDogs[index] {
                                revealedDogs[index] = true
                                if index == angryDogIndex {
                                    resultMessage = "You found the angry dog!"
                                } else {
                                    resultMessage = "This is a happy dog."
                                }
                                showResult = true
                            }
                        }
                }
            }
            .padding()

            Button(action: resetGame) {
                Text("Reset Game")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(resultMessage), dismissButton: .default(Text("OK")))
        }
    }

    func resetGame() {
        revealedDogs = Array(repeating: false, count: 20)
        angryDogIndex = Int.random(in: 0..<20)
        showResult = false
        resultMessage = ""
    }
}

struct DogView: View {
    var isRevealed: Bool
    var isAngry: Bool

    var body: some View {
        Image(isRevealed ? (isAngry ? "angryDog" : "normalDog") : "normalDog")
            .resizable()
            .frame(width: 60, height: 60)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
