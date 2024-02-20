//
//  ContentView.swift
//  Instafilter_Techniques
//
//  Created by Ciaran Murphy on 2/19/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    //@State private var showingConfirmation = false
    //@State private var backgroundColor = Color.white
    //@State private var blurAmount = 0.0 
    /*{
        didSet{
            print("New value is \(blurAmount)")
        }
    }
                                         */
    
    
    var body: some View {
        
        /*ContentUnavailableView("No Snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet"))*/
        ContentUnavailableView {
            Label("No Snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet")
        } actions: {
            Button("Create Snippet"){
                
            }
            .buttonStyle(.borderedProminent)
        }
        
        /*VStack{
            image?
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(90))
        }
        .onAppear(perform: loadImage)*/
        
        /*VStack {
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
        }*/
    }
    func loadImage() {
        //image = Image(.IMG_0027)
        let inputImage = UIImage(resource: .IMG_0027)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        //let currentFilter = CIFilter.sepiaTone()
        //let currentFilter = CIFilter.twirlDistortion()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage

        let amount = 1.0
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        //currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
