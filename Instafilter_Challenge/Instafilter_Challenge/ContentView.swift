//
//  ContentView.swift
//  Instafilter_Challenge
//
//  Created by Ciaran Murphy on 2/22/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 1.0
    @State private var filterScale = 5.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    
    @AppStorage("filter count") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem){
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture available", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                //.buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                
                
                if let processedImage{
                    
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey){
                        HStack{
                            Text("Intensity: \(filterIntensity)")
                            
                            Slider(value: $filterIntensity)
                                .onChange(of: [filterIntensity, filterRadius, filterScale], applyProcessing)
                        }
                        .padding()
                    }
                    
                    
                    if currentFilter.inputKeys.contains(kCIInputRadiusKey){
                        HStack{
                            Text("Radius: \(filterRadius)")
                            
                            Slider(value: $filterRadius)
                                .onChange(of: [filterIntensity, filterRadius, filterScale], applyProcessing)
                        }
                        .padding()
                    }
                     
                    if currentFilter.inputKeys.contains(kCIInputScaleKey){
                        HStack{
                            Text("Scale: \(filterScale)")
                            
                            Slider(value: $filterScale)
                                .onChange(of: [filterIntensity, filterRadius, filterScale], applyProcessing)
                        }
                        .padding()
                    }
                }
            }
        }
        
        HStack{
            if let processedImage{
                Button("Change Filter", action: changeFilter)
                
                Spacer()
                
                ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
            }
        }
        
        .padding([.horizontal, .bottom])
        .navigationTitle("Instafilter")
        .confirmationDialog("Select a filter", isPresented: $showingFilters){
            Button("Crystalize") {
                setFilter(CIFilter.crystallize())
            }
            Button("Edges") {
                setFilter(CIFilter.edges())
            }
            Button("Gaussian Blur") {
                setFilter(CIFilter.gaussianBlur())
            }
            Button("Pixelate") {
                setFilter(CIFilter.pixellate())
            }
            Button("Sepia Tone") {
                setFilter(CIFilter.sepiaTone())
            }
            Button("Unsharp Mask") {
                setFilter(CIFilter.unsharpMask())
            }
            Button("Vignette") {
                setFilter(CIFilter.vignette())
            }
            Button("Bloom"){
                setFilter(CIFilter.bloom())
            }
            Button("Gloom"){
                setFilter(CIFilter.gloom())
            }
            Button("Thermal"){
                setFilter(CIFilter.thermal())
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try? await selectedItem?.loadTransferable(type: Data.self)
            else { return }
            
            guard let inputImage = UIImage(data: imageData)
            else { return}
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterScale * 200, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20{
            requestReview()
        }
    }
}


#Preview {
    ContentView()
}
