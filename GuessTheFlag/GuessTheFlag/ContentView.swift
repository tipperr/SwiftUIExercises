//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ciaran Murphy on 1/4/24.
//

import SwiftUI

struct FlagImage: View{
    
    var imageName: String
    
    var body: some View{
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
    
}

struct ContentView: View {
    //@State private var showingAlert = false
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var currentAnswers = 0
    @State private var gameOver = false
    @State private var animationAmount = 0.0
    @State private var reverseAnimation = 0.0
    @State private var tapped = false
    
    let maxAnswers = 8
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            self.flagTapped(number)
                            self.tapped.toggle()
                            //isTapped[number] = true
                            //print(isTapped)
                            withAnimation(
                                .spring(duration: 1,
                                        bounce: 0.5)){
                                            animationAmount += (number == self.correctAnswer ? 360 : -360)
                                        }
                        }
                    label: {
                            /*Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)*/
                            FlagImage(imageName: countries[number])
                                .rotation3DEffect(
                                                        .degrees(animationAmount),
                                                        axis: (x: 0.0, y: (number == self.correctAnswer && self.tapped) ? 1 : -1, z: 0.0)
                                                    )
                                .opacity((number != self.correctAnswer && self.tapped) ? 0.25 : 1)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Guesses: \(currentAnswers)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }

        /*Button("Show alert"){
            showingAlert = true
        }*/
        
        
        .alert("Game Over!", isPresented: $gameOver){
            Button("Restart Game", action: reset)
            /*Button("Delete", role: .destructive){}
            Button("Cancel", role: .cancel){}*/
        } message: {
            Text("You scored \(score) out of 8!")
        }
        
        /*VStack {
         Button("Button 1"){}
         .buttonStyle(.bordered)
         
         Button("Button 2", role: .destructive){}
         .buttonStyle(.bordered)
         
         Button("Button 3"){}
         .buttonStyle(.borderedProminent)
         
         Button("Button 4", role: .destructive){}
         .buttonStyle(.borderedProminent)
         .tint(.indigo)
         
         }
         
         /*Button("Delete Selection", role: .destructive, action: executeDelete)*/
         }
         func executeDelete() {
         print("Now Deleting...")
         }*/
        
        /*Text("Your Content")
         .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
         .foregroundStyle(.white)
         .background(.red.gradient)*/
        
        /*AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)*/
        
        /*RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)*/
        
        /*LinearGradient(stops: [
         .init(color: .white, location: 0.45),
         .init(color: .black, location: 0.55)
         ], startPoint: .top, endPoint: .bottom)*/
        
        /*ZStack{
         VStack(spacing: 0){
         Color.red
         Color.blue
         }
         Text("Your content")
         .foregroundStyle(.secondary)
         .padding(50)
         .background(.ultraThinMaterial)
         }*/
        //.ignoresSafeArea()
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer && currentAnswers < 7 {
            scoreTitle = "Correct!"
            score += 1
            currentAnswers += 1
            showingScore = true
            gameOver = false
        } else if number == correctAnswer && currentAnswers == 7 {
            scoreTitle = "Correct!"
            score += 1
            currentAnswers += 1
            showingScore = false
            gameOver = true
        }
        else if number != correctAnswer && currentAnswers == 7 {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            currentAnswers += 1
            showingScore = false
            gameOver = true
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            currentAnswers += 1
            showingScore = true
            gameOver = false
        }
        //showingScore = true
        }
    
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tapped = false
    }
    
    func reset(){
        score = 0
        currentAnswers = 0
        tapped = false
        askQuestion()
    }
}


#Preview {
    ContentView()
}
