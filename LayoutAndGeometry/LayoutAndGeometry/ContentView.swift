//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Ciaran Murphy on 4/2/24.
//

/*import SwiftUI

struct ContentView: View {
    var body: some View {
        /*Text("Hello, world!")
            .frame(width: 300, height: 300, alignment: .topLeading)*/
        /*HStack (alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            
            Text("long")
            
            Text("and")
                .font(.title)
            
            Text("prosper")
                .font(.largeTitle)
        }*/
        
        VStack(alignment: .leading){
//            Text("Hello, world!")
//                .alignmentGuide(.leading){ d in
//                    d[.trailing]
//                }
//            Text("This is a longer line of text")
            
            ForEach(0..<10){ position in
                Text("Number \(position)")
                    .alignmentGuide(.leading){ _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}*/


/*import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID{
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName){
            VStack{
                Text("@murphyciarann")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                
                Image(.background)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            VStack{
                Text("Full Name")
                Text("Ciarán Murphy")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}*/

/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .offset(x: 100, y: 100)
                .background(.red)

        }
    }
}

#Preview {
    ContentView()
}*/


/*import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ proxy in
            Image(.background)
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.8)

        }
    }
}

#Preview {
    ContentView()
}*/


/*import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack{
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack{
            Text("Left")
            
            GeometryReader{ proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global Center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom Center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local Center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            
            Text("Right")
        }
        
        
    }
}

struct ContentView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    ContentView()
}*/


/*
import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader{ fullView in
            ScrollView{
                ForEach(0..<50){ index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}*/

/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                ForEach(1..<20) { number in
                    GeometryReader { proxy in
                        Text("Number \(number)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(
                                .degrees(-proxy.frame(in: .global).minX / 8),
                                 axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)

                }
            }
        }
    }
}

#Preview {
    ContentView()
}*/


/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                ForEach(1..<20) { number in
                        Text("Number \(number)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .frame(width: 200, height: 200)
                            .visualEffect { content, proxy in
                                    content.rotation3DEffect(
                                        .degrees(-proxy.frame(in: .global).minX / 8),
                                         axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                    )
                            }

                    }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
}

#Preview {
    ContentView()
}*/


/*
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
*/

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity(for: proxy.frame(in: .global).minY))

                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func opacity(for yOffset: CGFloat) -> Double {
            let maxOpacityOffset: CGFloat = 200
            let opacityOffset = min(abs(yOffset), maxOpacityOffset)
            return  Double(opacityOffset / maxOpacityOffset)
        }
}


#Preview {
    ContentView()
}
