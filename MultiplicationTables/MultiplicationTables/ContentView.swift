//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Ciaran Murphy on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var max = 2
    @State private var newAnswer = Int()
    @State private var oldAnswers = [Int]()
    @State private var questions = 5
    @State private var questionList = [(0, 0)]
    @State private var inGame: Bool? = nil
    @FocusState private var answerIsFocused: Bool
    
    let questionOptions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Maximum Multiplication Tables"){
                    Stepper("Up to the \(max) times tables", value: $max, in: 2...12)
                }
                Section("How many questions?"){
                    Picker("Questions", selection: $questions){
                        ForEach(questionOptions, id: \.self){ option in
                            Text("\(option)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                HStack {
                    Spacer()
                    Button(inGame == nil ? "Start Game" : "New Game", action: {
                        if inGame == nil {
                            questionList = generateQuestions()
                            inGame = true
                        } else {
                            reset()
                        }
                    })
                    Spacer()
                }

                
                Section{
                    Text("Questions:")
                    
                    if inGame == true{
                        //Text("In game")
                        Text("\(questionList[1])")
                    }
                    /*List(questionList, id:.\self){
                        Text($0)
                    }*/
                    }
            
                
            List{
                Section{
                    HStack{
                        TextField("Your answer", value: $newAnswer, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($answerIsFocused)
                        Button("Enter", action: addAnswer)
                    }
                }
                
                Section{
                    ForEach(oldAnswers, id:\.self){ number in
                        Text("\(number)")
                    }
                }
                
            }
                
                }
            .navigationTitle("Multiplication Tables!")
            .toolbar{
                if answerIsFocused {
                    Button("Done"){
                        answerIsFocused = false
                    }
                }
            }
        }

    }
    func generateQuestions() -> [(Int, Int)]{
        //var questionList = [(Int, Int)]()
        //print(questionList)
        for number in Range(1...questions){
            questionList.append(
                (Int.random(in: 1...max), Int.random(in: 1...12))
            )
        }
        print(questionList)
        inGame = true
        return questionList
    }
    
    func addAnswer(){
        
        let answer = newAnswer
        
        withAnimation{
            oldAnswers.insert(answer, at: 0)
        }
        
        resetText()
    }
    
    func resetText(){
        newAnswer = Int()
    }
    
    func reset(){
        max = 2
        questions = 5
        questionList = [(0, 0)]
        inGame = nil
        newAnswer = Int()
        oldAnswers = [Int]()
        print(questionList)
    }
}

#Preview {
    ContentView()
}
