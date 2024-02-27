//
//  ContentView.swift
//  BucketList
//
//  Created by Ciaran Murphy on 2/25/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    var body: some View {
        MapReader{ proxy in
            Map(initialPosition: startPosition){
                ForEach(locations){ location in
                    /*Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))*/
                    Annotation(location.name, coordinate: location.coordinate){
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture{
                                selectedPlace = location
                            }
                    }
                }
            }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){
                        //print("Tapped at \(coordinate)")
                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        
                        locations.append(newLocation)
                    }
                }
                .sheet(item: $selectedPlace){ place in
                    //Text(place.name)
                    EditView(location: place){ newLocation in
                        if let index = locations.firstIndex(of: place) {
                            locations[index] = newLocation
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
