//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Faizaan Khan on 11/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    
    @State private var isGameOver = false
    @State var gameCounter = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20){
                
                Spacer()
                Spacer()
                
                VStack{
                    Text("Select the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                        
                    }
                }
                
                Spacer()
                
                VStack{
                    Text("Your Score : \(score)")
                        .foregroundColor(.white)
                        .font(.subheadline.bold())
                }
            }
        }
        .alert(scoreTitle, isPresented: $isShowScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("""
                \(alertMessage)
                Your score is \(score)
                """)
        }
        .alert("Game Over!", isPresented: $isGameOver){
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Awesome! That's the correct answer"
        }
        else{
            scoreTitle = "Wrong"
            score -= 1
            alertMessage = "Wrong! Thats the flag of \(countries[number])"
        }
        
        isShowScore = true
        gameCounter += 1
        if (gameCounter >= 8){
            isGameOver = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        isGameOver = false
        gameCounter = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
