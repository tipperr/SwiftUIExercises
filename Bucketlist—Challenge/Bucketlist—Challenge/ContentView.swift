//
//  ContentView.swift
//  Bucketlist—Challenge
//
//  Created by Ciaran Murphy on 2/28/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    @State private var viewStandard = true
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack{
                MapReader{ proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations){ location in
                            
                            Annotation(location.name, coordinate: location.coordinate){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture{
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewStandard == true ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                            
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace){ place in
                        EditView(location: place){
                            viewModel.update(location: $0)
                            
                        }
                    }
                }
                .toolbar{
                    ToolbarItem{
                        Button("Switch Map Mode"){
                            viewStandard.toggle()
                        }
                    }
                }
            }
            
            
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Failed", isPresented: $viewModel.authenticationFailed){
                    Button("OK"){}
                } message: {
                    Text(viewModel.authenticationError)
                }
            alert("Authentication Failed", isPresented: $viewModel.noBiometrics){
                Button("OK"){}
            } message: {
                Text(viewModel.authenticationError)
            }
        
            
        }
        
    }
    
    
    
}

#Preview {
    ContentView()
}
