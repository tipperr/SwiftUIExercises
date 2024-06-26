//
//  ContentView.swift
//  FlashZilla—Challenge
//
//  Created by Ciaran Murphy on 3/29/24.
//



import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = [Card]() //Array<Card>(repeating: .example, count: 10)
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var timeRemaining = 100
    @State private var showingEditScreen = false
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        //CardView(card: .example)
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    //ForEach(0..<cards.count, id:\.self) { index in
                    ForEach(cards) { card in
                        let index = cards.firstIndex(of: card)!
                        CardView(card: card/*s[index]*/) { reinsert in
                            withAnimation{
                                print("Showing \(index)")
                                removeCard(at: index, reinsert: reinsert)
                            }
                        }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                //if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                //}
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button{
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack{
                    Spacer()
                    
                    HStack{
                        Button{
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect.")
                        
                        Button{
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: false)
                            }
                        } label: {
                            Spacer()
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onAppear(perform: loadData)
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == true {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, reinsert: Bool){
        
        guard index >= 0 else { return }
        
        if reinsert {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
            print("Moved Card at \(index)")
        } else {
            cards.remove(at: index)
            print("Removed Card at \(index)")
        }
        
        //cards.remove(at: index)
        
        //cards.append(removedCard)

        
        if cards.isEmpty {
            isActive = false
        }
        
        
    }
    
    func resetCards() {
        //cards = Array<Card>(repeating: .example, count: 10)
        print("Reset")
        timeRemaining = 100
        isActive = true
        loadData()
        //print("Reset")
    }
    
    /*func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
                print("Loaded Data \(Date.now), \(cards.count) cards")
            }
        }
    }*/
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("cards.json")
        do {
            let data = try Data(contentsOf: filename)
            cards = try JSONDecoder().decode([Card].self, from: data)
            print("Loaded Data")
        } catch {
            print("Unable to load data.")
        }
    }

    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("cards.json")
            let data = try JSONEncoder().encode(cards)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Saved data")
        } catch {
            print("Unable to save data.")
        }
    }

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("acquired path")
        return paths[0]
    }

}

#Preview {
    ContentView()
}
