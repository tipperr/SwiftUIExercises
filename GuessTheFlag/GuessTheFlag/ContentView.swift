//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ciaran Murphy on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        
        Button("Show alert"){
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert){
            Button("Delete", role: .destructive){}
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Please read this")
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
}


#Preview {
    ContentView()
}
