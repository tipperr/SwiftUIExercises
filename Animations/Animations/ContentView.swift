//
//  ContentView.swift
//  Animations
//
//  Created by Ciaran Murphy on 1/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    @State private var enabled = false
    
    var body: some View {
        
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
        
        //From controlling the animation stack
        /*Button("Tap me"){
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .foregroundStyle(.white)
        .animation(.default, value: enabled)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
        */
        //From creating explicit animations
        /*Button("Tap me"){
            withAnimation(.spring(duration: 1, bounce: 0.5)){
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
                                  axis: (x: 0, y: 0, z: 1)
        )*/
        
        //print(animationAmount)
        
        //return VStack{
            
            //From "customizing animations"
            /*Stepper("Scale Amount", value: $animationAmount.animation(), in: 1...10)
            
            Spacer()
            
            Button("Tap me"){
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }*/
        
        //playing with button shapes and stroke animations:
        /*Button("Tap me"){
            //animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        //.scaleEffect(animationAmount)
        //.blur(radius: (animationAmount - 1) * 3)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                        .delay(1)
                        .repeatForever(autoreverses: false),
                        value: animationAmount
        )
        /*.animation(
            .easeInOut(duration: 2)
            .delay(1)
            .repeatCount(3, autoreverses: true),
            value: animationAmount*/
        )
        
        .onAppear {
            animationAmount = 2
        }*/
    }
}

#Preview {
    ContentView()
}
