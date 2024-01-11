//
//  ContentView.swift
//  WordScramble
//
//  Created by Ciaran Murphy on 1/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    @State private var wordCount = 1
    //let people = ["Finn", "Leia", "Luke", "Rey"]
    
    
    var body: some View {
        NavigationStack{
            List {
                Section{
                    TextField("Enter Your Word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(usedWords, id:\.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK"){}
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("New Game", action: newGame)
            }
        }
        //Button("New Game", action: newGame)
        Text("Score: \(score)")
            .font(.title.bold())
    }
        //Playing with lists:
        /*List(people, id:\.self){
            
                    Text($0)
            
        }
        .listStyle(.grouped)*/
    
        func addNewWord(){
            
            let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard answer.count > 0 else { return }
            
            guard isOriginal(word: answer) else {
                wordError(title: "Word used already.", message: "Be more original.")
                return
            }
            
            guard isPossible(word: answer) else {
                wordError(title: "Word not possible.", message: "You can't spell that word from \(rootWord).")
                return
                
            }
            
            guard isReal(word: answer) else {
                wordError(title: "Word not recognized.", message: "You can't just make them up, you know.")
                return
            }
            
            guard isLongEnough(word: answer) else {
                wordError(title: "Word too short.", message: "Get a better vocabulary.")
                return
            }
            
            guard isNotSame(word: answer) else {
                wordError(title: "Word the same as the root word.", message: "That's really egregious.")
                return
            }
            
            wordCount += 1
            
            score += answer.count * wordCount
            
            withAnimation{
                usedWords.insert(answer, at: 0)
            }
            newWord = ""
        }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool{
        word.count > 3
    }
    
    func isNotSame(word: String) -> Bool{
        word != rootWord
    }
        
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func newGame(){
        startGame()
        usedWords = [String]()
        score = 0
    }
    
    
    //Playing with string chcecking:
    /*func testStrings(){
        
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location = NSNotFound*/
        
        /*let input = "a b c"
        let letters = input.components(separatedBy: " ")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)*/
    }
    
    //playing with bundles:
    /*func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "someFile", withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL){
                
            }
        }
    }*/

#Preview {
    ContentView()
}
