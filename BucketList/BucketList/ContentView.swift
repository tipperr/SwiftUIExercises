//
//  ContentView.swift
//  BucketList
//
//  Created by Ciaran Murphy on 2/25/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    //Moved to ViewModel:
    //@State private var locations = [Location]()
    //@State private var selectedPlace: Location?
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader{ proxy in
                Map(initialPosition: startPosition){
                    ForEach(viewModel.locations){ location in
                        /*Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))*/
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
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){
                        viewModel.addLocation(at: coordinate)
                        //print("Tapped at \(coordinate)")
                        //Added to ViewModel
                        /*let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                         
                         viewModel.locations.append(newLocation)*/
                    }
                }
                .sheet(item: $viewModel.selectedPlace){ place in
                    //Text(place.name)
                    EditView(location: place){ /*newLocation in*/
                        viewModel.update(location: $0)
                        //Added to ViewModel
                        /*if let index = viewModel.locations.firstIndex(of: place) {
                         viewModel.locations[index] = newLocation
                         }*/
                        
                    }
                }
            }
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
