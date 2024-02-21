//
//  ContentView.swift
//  Instafilter
//
//  Created by Ciaran Murphy on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                if let processedImage{
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture available", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
                
                Spacer()
                
                HStack{
                    Text("Intensity")
                    
                    Slider(value: $filterIntensity)
                }
                
                HStack{
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    func changeFilter() {
        
    }
}

#Preview {
    ContentView()
}
