//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Ciaran Murphy on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    
    let possibleMoves = ["🪨", "📄", "✂️"]
    let winningMoves = ["📄", "✂️", "🪨"]
    let losingMoves = ["✂️", "🪨", "📄"]
    
    @State private var score = 0
    @State private var currentAnswers = 0
    @State private var gameOver = false
    @State private var isWinning = Bool.random()
    @State private var appChoice = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var userMove = ""

    //@State private var userChoice: Int
    @State private var newChoice = ""
    
    var body: some View {
        VStack{
            
            Spacer()
                                
            Text("App has chosen \(possibleMoves[appChoice])")
                .foregroundStyle(.primary)
                .font(.title)
            
            
            Spacer()
            
            if isWinning == true{
                Text("Please Lose")                .foregroundStyle(.primary)
                    .font(.title.bold().italic())
            } else {
                Text("Please Win")                .foregroundStyle(.primary)
                    .font(.title.bold().italic())
            }
            
            Spacer()
            Spacer()
            HStack {
                ForEach(possibleMoves, id: \.self) { move in
                    Button(action: {
                        //isWinning.toggle()
                        currentAnswers += 1
                        gameOverCheck()
                        checkAnswer(move)
                        //newAppChoice()
                    }) {
                        Text(move)
                            .font(.system(size: 100))
                    }
                }
                }
            
            Spacer()
            Spacer()
            
            Text("Score: \(score)")
                .foregroundStyle(.primary)
                .font(.title.bold())
            Text("Guesses: \(currentAnswers)")
                .foregroundStyle(.primary)
                .font(.title.bold())
            
            Spacer()
            

        }
        .alert("Game Over", isPresented: $gameOver){
            Button("Restart", action: reset)
        } message: {
            Text("You scored \(score) out of 10")
        }
        
        .alert("Your score is \(score), your choice was \(userMove), and app's choice was \(possibleMoves[appChoice])", isPresented: $showingScore){
            Button("Continue", action: newAppChoice)
        }
        
    }
    
        
    
    func choiceTapped(_ move: Int){
        if move == appChoice{
            score += 1
        } else {
            score = score
        }
    }
    
    func newAppChoice(){
        appChoice = Int.random(in: 0...2)
        isWinning.toggle()
    }
    
    func checkAnswer(_ move: String){
        showingScore = true
        userMove = move
        if move == losingMoves[appChoice] && isWinning == true {
            score += 1
        } else if move == winningMoves[appChoice] && isWinning == false {
            score += 1
        }else {
            score = score
        }
    }
    
    func gameOverCheck(){
        if currentAnswers == 10{
            gameOver = true
        } else {
            gameOver = false
        }
    }
    
    func reset(){
        score = 0
        currentAnswers = 0
    }
}

#Preview {
    ContentView()
}
