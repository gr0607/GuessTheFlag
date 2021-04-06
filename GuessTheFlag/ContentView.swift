//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by admin on 05.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var incorectAnsert = ""
    @State private var score = 0
    @State private var isWrong = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 10)
                    })
                    
                }
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
            
            .alert(isPresented: $isWrong, content: {
                Alert(title: Text("Oh... no"), message: Text("This is flag of \(incorectAnsert )"), dismissButton: .default(Text("Continue")){
                })
            })
            
//            .alert(isPresented: $showingScore, content: {
//                Alert(title: Text(scoreTitle),
//                      message: Text("Your score is \(score)"),
//                      dismissButton: .default(Text("Continue"), action: {
//                        self.askQuestion()
//                      }))
//            })
            
         
         
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
            incorectAnsert = countries[number]
            isWrong = true
        }
        self.askQuestion()
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in:  0...2 )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
