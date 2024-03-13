//
//  ContentView.swift
//  ConferenceList
//
//  Created by Ciaran Murphy on 3/7/24.
//

import CoreLocation
import MapKit
import PhotosUI
import SwiftUI

struct Attendee: Identifiable, Codable {
    let id = UUID()
    //let image: Image
    let imageData: Data
    var attendeeName: String
    var location: CodableCoordinate?
    
    init(imageData: Data, attendeeName: String) {
        self.imageData = imageData
        self.attendeeName = attendeeName
        self.location = nil
    }
    
    init(imageData: Data, attendeeName: String, location: CLLocationCoordinate2D?) { // Update initializer
        self.imageData = imageData
        self.attendeeName = attendeeName
        self.location = location.map(CodableCoordinate.init)
    }
}

class Attendees: ObservableObject {
    @Published var attendees = [Attendee]() {
        didSet {
            saveAttendees() // Save attendees whenever the list changes
        }
    }
    
    init() {
        loadAttendees() // Load attendees when the app starts
    }
    
    private func saveAttendees() {
        do {
            let data = try JSONEncoder().encode(attendees)
            UserDefaults.standard.set(data, forKey: "attendees")
        } catch {
            print("Error saving attendees: \(error)")
        }
    }
    
    private func loadAttendees() {
        if let data = UserDefaults.standard.data(forKey: "attendees") {
            do {
                attendees = try JSONDecoder().decode([Attendee].self, from: data)
            } catch {
                print("Error loading attendees: \(error)")
            }
        }
    }
}
    
struct CodableCoordinate: Codable, Equatable {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(coordinate: CLLocationCoordinate2D) {
            latitude = coordinate.latitude
            longitude = coordinate.longitude
        }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}

    struct ContentView: View {
        //@State private var conferenceList = []
        @StateObject private var attendees = Attendees()
        @State private var conferenceList = [Attendee]()
        @State private var pickerItem: PhotosPickerItem?
        @State private var pickerItems = [PhotosPickerItem]()
        @State private var selectedImage: Image?
        @State private var selectedImageData: Data?
        //@State private var selectedImages = [Image]()
        @State private var attendeeName = "Attendee Name"
        @State private var showingNameAlert = false
        @State private var showingAttendee = false
        let locationFetcher = LocationFetcher()
        
        var body: some View {
            NavigationView{
                VStack {
                    PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                    List{
                        //ForEach(conferenceList) { attendee in
                        ForEach(attendees.attendees) { attendee in
                            NavigationLink(destination: AttendeeView(attendee: attendee)){
                                HStack {
                                    Image(uiImage: UIImage(data: attendee.imageData) ?? UIImage(systemName: "person.circle.fill")!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Spacer()
                                    Text(attendee.attendeeName)
                                }
                            }
                        }
                    }
                    
                    VStack {
                        Button("Start Tracking Location") {
                            locationFetcher.start()
                        }
                        
                        Button("Read Location") {
                            if let location = locationFetcher.lastKnownLocation {
                                print("Your location is \(location)")
                            } else {
                                print("Your location is unknown")
                            }
                        }
                    }
                    
                    .onChange(of: pickerItem) { _ in
                        Task {
                            if let imageData = try await pickerItem?.loadTransferable(type: Data.self) {
                                selectedImageData = imageData
                                showingNameAlert.toggle()
                            }
                        }
                    }
                    .alert("Enter attendee's name", isPresented: $showingNameAlert) {
                        TextField("Attendee Name", text: $attendeeName)
                        
                        Button("OK") {
                            if let imageData = selectedImageData {
                                let attendee = Attendee(imageData: imageData, attendeeName: attendeeName, location: locationFetcher.lastKnownLocation)
                                //conferenceList.append(attendee)
                                attendees.attendees.append(attendee)
                            }
                            selectedImageData = nil
                            attendeeName = "Attendee Name"
                            showingNameAlert = false
                        }
                    }
                }
            }
        }

}


#Preview {
    ContentView()
}
