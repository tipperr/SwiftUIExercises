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
    @State private var oldFirstNumber = [Int]()
    @State private var oldSecondNumber = [Int]()
    @State private var inGame: Bool? = nil
    @FocusState private var answerIsFocused: Bool
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var gameOver = false
    
    
    @State private var firstPart = 0
    @State private var secondPart = 0
    
    let questionOptions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.pink
                
                Form{
                    if inGame == false || inGame == nil {
                        Section("Maximum Multiplication Tables"){
                            Stepper("Up to the \(max) times tables", value: $max, in: 2...12)
                        }
                        
                        Section("How many questions?"){
                            HStack{
                                Spacer()
                                Image("hippo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Spacer()
                                Spacer()
                                Image("cow")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Spacer()
                                Spacer()
                                Image("dog")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Spacer()
                            }
                            Picker("Questions", selection: $questions){
                                ForEach(questionOptions, id: \.self){ option in
                                    Text("\(option)")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    
                    HStack {
                        Spacer()
                        VStack{
                            Image("bear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Button(inGame == nil ? "Start Game" : "New Game", action: {
                                if inGame == nil || inGame == false {
                                    questionList = generateQuestions()
                                    inGame = true
                                    currentQuestionIndex = 0
                                } else {
                                    reset()
                                }
                            })
                        }
                        Spacer()
                    }
                    
                    
                    Section{
                        if inGame == true {
                            
                            HStack{
                                VStack{
                                    
                                   /* HStack{
                                        Spacer()
                                        Text("Questions:")
                                            .font(.title2)
                                        Spacer()
                                    }*/
                                    
                                    Spacer()
                                    
                                    if inGame == true{
                                        if let currentQuestion = questionList[safe: currentQuestionIndex], inGame == true {
                                            //firstPart = currentQuestion.0
                                            //secondPart = currentQuestion.1
                                            HStack{
                                                Image("penguin")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                let questionText = ("What is \(currentQuestion.0) x \(currentQuestion.1)?")
                                                Text(questionText)
                                                    .font(.title)
                                                Image("panda")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                            }
                                            
                                            List{
                                                Section{
                                                    HStack{
                                                        Spacer()
                                                        Text("\(currentQuestion.0) x \(currentQuestion.1)   = ")
                                                        TextField("Your answer", value: $newAnswer, format: .number)
                                                            .foregroundStyle(.blue)
                                                            .padding(5)
                                                            //.background(.pink)
                                                            .keyboardType(.decimalPad)
                                                            .focused($answerIsFocused)
                                                        Spacer()
                                                        
                                                        Button("Enter", action: addAnswer)
                                                    }
                                                }
                                            }
                                            
                                            
                                            Section{
                                                
                                                ForEach(oldAnswers.indices, id:\.self){ index in
                                                    HStack {
                                                        Text("\(oldFirstNumber[index]) x \(oldSecondNumber[index]) =")
                                                            .foregroundColor((oldFirstNumber[index] * oldSecondNumber[index] == oldAnswers[index]) ? .green : .red)
                                                            .font(.title3)
                                                        Text((oldFirstNumber[index] * oldSecondNumber[index] == oldAnswers[index]) ? "\(oldAnswers[index])" : "\(oldAnswers[index])")
                                                            .font(.title3)
                                                            .foregroundColor((oldFirstNumber[index] * oldSecondNumber[index] == oldAnswers[index]) ? .green : .red)
                                                            .strikethrough((oldFirstNumber[index] * oldSecondNumber[index] != oldAnswers[index]))
                                                        Text((oldFirstNumber[index] * oldSecondNumber[index] == oldAnswers[index]) ? "" : "\(oldFirstNumber[index] * oldSecondNumber[index])")
                                                            .font(.title3)
                                                            .foregroundColor((oldFirstNumber[index] * oldSecondNumber[index] == oldAnswers[index]) ? .green : .red)
                                                        
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
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
                                    
                                    
                                }
                                
                                
                                /*List(questionList, id:.\self){
                                 Text($0)
                                 }*/
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                }
                
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Multiplication Tables!")
                .background(Color.pink)
                .toolbar{
                    if answerIsFocused {
                        Button("Done"){
                            answerIsFocused = false
                        }
                    }
                }
            }
            Section{
                if inGame == true {
                    HStack{
                        Image("pig")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Score = \(score)")
                            .foregroundStyle(.green)
                            .font(.title)
                        Image("chick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
            }
             
            
            
        }
        .alert("Game Over!", isPresented: $gameOver){
            Button("New Game", action: reset)
            /*Button("Delete", role: .destructive){}
            Button("Cancel", role: .cancel){}*/
        } message: {
            Text("You scored \(score) out of \(questions)!")
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
        
        if let currentQuestion = questionList[safe: currentQuestionIndex], inGame == true {
            let answer = newAnswer
            print("Adding answer", answer)
            print("Current question parts", currentQuestion.0, currentQuestion.1)
            withAnimation {
                oldAnswers.insert(answer, at: 0)
                oldFirstNumber.insert(currentQuestion.0, at: 0)
                oldSecondNumber.insert(currentQuestion.1, at: 0)
            }
            
            print(oldQuestions)
            print(oldFirstNumber, oldSecondNumber)
            if currentQuestion.0 * currentQuestion.1 == answer{
                score += 1
                print(score)
            }
            
            resetText()
            
            currentQuestionIndex += 1
            if currentQuestionIndex == questions {
                // If all questions are answered, end the game
                inGame = false
                gameOver = true
                //reset()
                print(score)
            }
            
            
        }
    }
        
        func resetText(){
            newAnswer = Int()
        }
        
        func reset(){
            max = 2
            questions = 5
            questionList = [(Int, Int)]()
            inGame = false
            newAnswer = Int()
            oldAnswers = [Int]()
            score = 0
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
