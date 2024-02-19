//
//  ContentView.swift
//  Instafilter_Techniques
//
//  Created by Ciaran Murphy on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    @State private var blurAmount = 0.0 /*{
        didSet{
            print("New value is \(blurAmount)")
        }
    }
                                         */
    
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount){ oldValue, newValue in
                    print("New value is \(newValue)")
                }
            
            Button("Random Blur"){
                blurAmount = Double.random(in: 0...20)
                showingConfirmation.toggle()
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .confirmationDialog("Change Background", isPresented: $showingConfirmation){
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
        }
    }
}

#Preview {
    ContentView()
}
