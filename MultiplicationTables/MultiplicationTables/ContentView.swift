//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Ciaran Murphy on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var max = 2
    @State private var questions = 5
    
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
                
                HStack{
                    Spacer()
                    Button("Start Game", action: generateQuestions)
                    Spacer()
                }
                
                Section("Questions"){
                    List{
                        
                    }
                }
                
                }
            .navigationTitle("Multiplication Tables!")
            .toolbar{
                Button("New Game"){
                    
                }
            }
        }

    }
    func generateQuestions(){
        var questionList = [(Int, Int)]()
        print(questionList)
        for number in Range(1...questions){
            questionList.append(
                (Int.random(in: 1...max), Int.random(in: 1...12))
            )
        }
        print(questionList)
        return
    }
}

#Preview {
    ContentView()
}
