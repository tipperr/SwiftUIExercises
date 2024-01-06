//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ciaran Murphy on 1/5/24.
//

import SwiftUI

struct capsuleText: View{
    
    var text: String
    
    var body: some View{
        Text(text)
            .font(.largeTitle)
            .padding()
            //.foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
    
}

struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View{
        modifier(Title())
    }
}

struct Watermark: ViewModifier{
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){ row in
                HStack {
                    ForEach(0..<columns, id: \.self){ column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    //let motto1 = Text("Draco dormiens")
    //let motto2 = Text("nunquam titillandus")
    
    //@State private var useRedText = false
    
    var body: some View {
        GridStack(rows: 4, columns: 4) {row, col in
            //HStack{
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            //}
        }
        
        
        Color.red
            .frame(width: 300, height: 200)
            .watermarked(with: "Oh, Hello")
        
        Text("Hello World")
            .titleStyle()
        
        VStack(spacing: 10){
            capsuleText(text: "First")
                .foregroundStyle(.white)
            capsuleText(text: "Second")
                .foregroundStyle(.yellow)
        }
        
        /*VStack{
            motto1.foregroundStyle(.red)
            motto2.foregroundStyle(.blue)
        }*/
        
        /*VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)*/
        
        /*Button("Hello, World!"){
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)*/
            /*.padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)*/
        
        /*Button("Hello World"){
            
        }

        .frame(width: 200, height: 200)
        .background(.red)*/
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.red)
    }
}

#Preview {
    ContentView()
}
