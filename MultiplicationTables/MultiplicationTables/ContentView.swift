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
    @State private var questionList = [(Int, Int)]()
    @State private var oldQuestions = [(Int, Int)]()
    @State private var inGame: Bool? = nil
    @FocusState private var answerIsFocused: Bool
    @State private var currentQuestionIndex = 0

    
    @State private var firstPart = 0
    @State private var secondPart = 0
    
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
                            currentQuestionIndex = 0
                        } else {
                            reset()
                        }
                    })
                    Spacer()
                }

                
                Section{
                    HStack{
                        VStack{
                            HStack{
                                Spacer()
                                Text("Questions:")
                                    .font(.title2)
                                Spacer()
                            }
                            if inGame == true{
                                Spacer()
                                //Text("In game")
                                //Text("\(questionList[1])")
                                /*let (firstElement, secondElement) = questionList[1]
                                Text("What is \(firstElement) x \(secondElement)?")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)*/
                                /*ForEach(questionList.map { "\($0.0)-\($0.1)" }, id: \.self) { question in
                                    let components = question.split(separator: "-")
                                    if let firstElement = Int(components[0]), let secondElement = Int(components[1]) {
                                        Text("What is \(firstElement) x \(secondElement)?")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    }
                                }*/
                                
                                if let currentQuestion = questionList[safe: currentQuestionIndex], inGame == true {
                                    firstPart = currentQuestion.0
                                    secondPart = currentQuestion.1
                                                                let questionText = ("What is \(currentQuestion.0)  x \(currentQuestion.1)?")
                                    Text(questionText)
                                                                    .font(.title)

                                                            }
                            }
                            /*List(questionList, id:.\self){
                             Text($0)
                             }*/
                        }
                        
                    }
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
        questionList.removeAll() // Clear the existing questions
        currentQuestionIndex = 0 // Reset the index
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
        print("Adding answer", answer)
        print("Current question parts", firstPart, secondPart)
       // print(firstPart, secondPart)
        //let question = (firstPart, secondPart)
        //print(question)
        
        withAnimation{
            oldAnswers.insert(answer, at: 0)
            //oldQuestions.insert(question!, at: 0)
            //oldQuestions.insert(question, at: 0)
        }
        
        print(oldQuestions)
        
        resetText()
        
        currentQuestionIndex += 1
        if currentQuestionIndex == questionList.count {
            // If all questions are answered, end the game
            inGame = false
            reset()
        }
        
        
    }
    
    func resetText(){
        newAnswer = Int()
    }
    
    func reset(){
        max = 2
        questions = 5
        questionList = [(Int, Int)]()
        inGame = nil
        newAnswer = Int()
        oldAnswers = [Int]()
        print(questionList)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    ContentView()
}
