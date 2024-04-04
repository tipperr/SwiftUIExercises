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
