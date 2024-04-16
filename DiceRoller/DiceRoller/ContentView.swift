//
//  ContentView.swift
//  DiceRoller
//
//  Created by Ciaran Murphy on 4/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 0
    
    @State private var sides = 6
    
    @State private var diceNumber = 1
    
    @State private var thisRoll = [Int]()
    
    @State private var previousRolls = [[Int]]()
    
    @State private var haptics = false
    
    @State private var startTimer = false
    
    @State private var isRolling = false
    @State private var flickerCount = 0
    
    @State private var randomStart = 0
    @State private var randomStart2 = 0
    @State private var randomStart3 = 0
    @State private var randomStart4 = 0
    @State private var randomStart5 = 0
    
    @State var timeRemaining = 0.0
    
    @State var thisTime = [0]
    @State private var totalTime = [Int]()
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var sideOptions = [4, 6, 8, 10, 12, 20, 100]
    
    let previousRollsKey = "PreviousRolls"
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Section{
                Text("Number of Sides:")
                    .font(.title)
                Picker("Sides", selection: $sides){
                    ForEach(sideOptions, id: \.self){
                        Text("\($0)")
                    }
                }
            }
            .padding()
            
            Section{
                Text("Number of Dice:")
                    .font(.title)
                Picker("Number of dice:", selection: $diceNumber){
                    ForEach(1..<6, id: \.self){
                        Text("\($0)")
                    }
                }
            }
            .padding()
            
            //Text("Number of sides: \(sides)")
            
            //Text("Number of dice: \(diceNumber)")
            
            if thisTime.count >= 6 && !thisRoll.isEmpty {
                Text("\(thisRoll.map { String($0) }.joined(separator: "     "))")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .padding()
            } else {
                HStack{
                    ForEach(totalTime.prefix(diceNumber), id: \.self) { number in
                        Text("\(number)")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                            .padding()
                    }
                }
            }
            
//            else {
//                HStack{
//                    //ForEach(1...diceNumber, id: \.self) { _ in
//                        //Text("\(randomStart)")
//                        Text("\(totalTime.map { String($0) }.joined(separator: "     "))")
//                            .font(.largeTitle)
//                            .foregroundStyle(.secondary)
//                            .padding()
//                    }
//                //}
//            }
            
            
//            Text("\(randomStart), \(thisTime)")
//                .font(.largeTitle)
//                .onReceive(timer) { _ in
//                    if timeRemaining > 0.0 {
//                        timeRemaining -= 0.5
//                        randomStart = Int.random(in: 1...sides)
//                        thisTime.append(randomStart)
//                        print(timeRemaining)
//                    }
//                }
            
            
//            Text("\(value)")
//                .font(.largeTitle)
//                .padding()
            
            /*if !thisRoll.isEmpty {
                Text("\(thisRoll.map { String($0) }.joined(separator: "     "))")
                    .font(.largeTitle)
                    .padding()
            }*/
            
//            Text("\(previousRolls.map { String($0) }.joined(separator: "     "))")
//                .font(.largeTitle)
//                .padding()
            
            Button("Roll"){
                roll(sides: sides)
                //startRolling()
                //print(previousRolls)
                thisTime = []
                haptics = true
                startTimer = true
                print("\(startTimer)")
            }
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
            .sensoryFeedback(.success, trigger: haptics)
            .onReceive(timer) { _ in
                if timeRemaining > 0.0 {
                    totalTime.removeAll()
                    timeRemaining -= 0.5
                    randomStart = Int.random(in: 1...sides)
                    randomStart2 = Int.random(in: 1...sides)
                    randomStart3 = Int.random(in: 1...sides)
                    randomStart4 = Int.random(in: 1...sides)
                    randomStart5 = Int.random(in: 1...sides)
                    thisTime.append(randomStart)
                    totalTime.append(randomStart)
                    totalTime.append(randomStart2)
                    totalTime.append(randomStart3)
                    totalTime.append(randomStart4)
                    totalTime.append(randomStart5)
                    print(totalTime)
                    //print(timeRemaining)
                }
            }
            
            
                List{
                    Section("Previous Rolls"){
                        ForEach(previousRolls.reversed().dropFirst(), id:\.self){ rolls in
                        Text("\(rolls.map {String($0) }.joined(separator: ", "))")
                    }
                }
            }
        }
        
        .onAppear {
                    loadPreviousRolls()
                }
    }
    
//    func roll(sides: Int) {
//        value = Int.random(in: 1...sides)
//        previousRolls.append(value)
//    }
    
//    func roll(sides: Int) {
//        thisRoll.removeAll() // Clear the previous rolls
//        
//        for _ in 0..<diceNumber {
//            let value = Int.random(in: 1...sides)
//            thisRoll.append(value)
//            previousRolls.append(thisRoll)
//        }
//    }
    
//    func startRolling() {
//        thisRoll.removeAll()
//            guard !isRolling else { return }
//            isRolling = true
//            flickerCount = 0
//            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                flickerCount += 1
//                value = Int.random(in: 1...sides)
//                if flickerCount >= 20 { // Adjust the flicker count as needed
//                    timer?.invalidate()
//                    isRolling = false
//                    thisRoll.append(value)
//                    previousRolls.append(thisRoll)
//                    savePreviousRolls()
//                    haptics = false
//                }
//            }
//        }
    
    func roll(sides: Int) {
        thisRoll.removeAll() // Clear the previous rolls
        
        for _ in 0..<diceNumber {
            let value = Int.random(in: 1...sides)
            thisRoll.append(value)
        }
        
        previousRolls.append(thisRoll)
        savePreviousRolls()
        startTimer = false
        resetTimer()
        //haptics = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            haptics = false // Reset haptics to false after a short delay
            startTimer = false
        }
    }
    
    func resetTimer(){
        print("\(startTimer)")
        timeRemaining = 3.0
        //randomStart = 0
        startTimer = false
    }
    
    func savePreviousRolls() {
        let data = try? JSONEncoder().encode(previousRolls)
        UserDefaults.standard.set(data, forKey: previousRollsKey)
    }
    
    func loadPreviousRolls() {
        if let data = UserDefaults.standard.data(forKey: previousRollsKey),
           let rolls = try? JSONDecoder().decode([[Int]].self, from: data) {
            previousRolls = rolls
            if let lastRoll = previousRolls.last {
                thisRoll = lastRoll
            }
        }
    }

}

#Preview {
    ContentView()
}
