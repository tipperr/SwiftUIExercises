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
    
    var sideOptions = [4, 6, 8, 10, 12, 20, 100]
    
    let previousRollsKey = "PreviousRolls"
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Picker("Sides", selection: $sides){
                ForEach(sideOptions, id: \.self){
                    Text("\($0)")
                }
            }
            
            Picker("Number of dice:", selection: $diceNumber){
                ForEach(1..<6, id: \.self){
                    Text("\($0)")
                }
            }
            
            Text("Number of sides: \(sides)")
            
            Text("Number of dice: \(diceNumber)")
            
//            Text("\(value)")
//                .font(.largeTitle)
//                .padding()
            
            if !thisRoll.isEmpty {
                Text("\(thisRoll.map { String($0) }.joined(separator: "     "))")
                    .font(.largeTitle)
                    .padding()
            }
            
//            Text("\(previousRolls.map { String($0) }.joined(separator: "     "))")
//                .font(.largeTitle)
//                .padding()
            
            Button("Roll"){
                roll(sides: sides)
                print(previousRolls)
            }
            //.sensoryFeedback(.increase, trigger: roll)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
            
            List{
                ForEach(previousRolls.reversed(), id:\.self){ rolls in
                    Text("\(rolls.map {String($0) }.joined(separator: ", "))")
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
    
    func roll(sides: Int) {
            thisRoll.removeAll() // Clear the previous rolls
            
            for _ in 0..<diceNumber {
                let value = Int.random(in: 1...sides)
                thisRoll.append(value)
            }
            
            previousRolls.append(thisRoll)
            savePreviousRolls()
        }
    
    func savePreviousRolls() {
        let data = try? JSONEncoder().encode(previousRolls)
        UserDefaults.standard.set(data, forKey: previousRollsKey)
    }
    
    func loadPreviousRolls() {
        if let data = UserDefaults.standard.data(forKey: previousRollsKey),
           let rolls = try? JSONDecoder().decode([[Int]].self, from: data) {
            previousRolls = rolls
        }
    }

}

#Preview {
    ContentView()
}
