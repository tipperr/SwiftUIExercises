//
//  ContentView.swift
//  FlashZilla—Techniques
//
//  Created by Ciaran Murphy on 3/22/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation{
                    isDragging = true
                }
                
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1.0)
            .offset(offset)
            .gesture(combined)
        
        /*VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onTapGesture {
                    print("Text Tapped!")
                }
                //.scaleEffect(finalAmount + currentAmount)
//                .rotationEffect(currentAmount + finalAmount)
//                .gesture(
//                    //MagnifyGesture()
//                    RotateGesture()
//                        .onChanged { value in
//                            //currentAmount = value.magnification - 1
//                            currentAmount = value.rotation
//                        }
//                        .onEnded { value in
//                            finalAmount += currentAmount
//                            currentAmount = .zero
//                            //currentAmount = 0.0
//                        }
//                )
                /*.onTapGesture(count: 2){
                    print("Double Tapped")
                }
                .onLongPressGesture(minimumDuration: 3){
                    print("Long pressed")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)")
                }*/
        }
        .padding()
        //.highPriorityGesture(
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack Tapped!")
                }
        )*/
    }
}

#Preview {
    ContentView()
}
