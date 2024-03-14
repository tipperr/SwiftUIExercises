//
//  AttendeeView.swift
//  ConferenceList
//
//  Created by Ciaran Murphy on 3/8/24.
//

import CoreLocation
import MapKit
import PhotosUI
import SwiftUI

struct AttendeeView: View {
    let attendee: Attendee
    
    @State private var mapCameraPosition: MapCameraPosition

        init(attendee: Attendee) {
            self.attendee = attendee
            //let coordinate = attendee.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
            let coordinate = attendee.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)

            let codableCoordinate = CodableCoordinate(coordinate: coordinate)
                    
            _mapCameraPosition = State(initialValue: .region(MKCoordinateRegion(center: codableCoordinate.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))

        }
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(uiImage: UIImage(data: attendee.imageData) ?? UIImage(systemName: "person.circle.fill")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                //Text("\(attendee.location)")
                Map(position: $mapCameraPosition){
                    
                    Annotation(attendee.attendeeName, coordinate: attendee.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                    }

                }
            }
            .navigationTitle(attendee.attendeeName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        let imageData = Data() // Placeholder image data
        let attendee = Attendee(imageData: imageData, attendeeName: "John Doe", location: CLLocationCoordinate2D(latitude: 37.3347302, longitude: -122.0089189))
        return AttendeeView(attendee: attendee)
    }
}

/*#Preview {
    AttendeeView()
}*/
