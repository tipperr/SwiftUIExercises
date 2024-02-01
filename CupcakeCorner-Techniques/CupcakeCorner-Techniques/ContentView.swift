//
//  ContentView.swift
//  CupcakeCorner-Techniques
//
//  Created by Ciaran Murphy on 1/31/24.
//

//Sending and receiving Codable Data:
/*import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
        
    }
}

#Preview {
    ContentView()
}*/


//Loading an image from a remote server:
 /*import SwiftUI
 
 struct ContentView: View {
    var body: some View {
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ image in
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            if let image = phase.image{
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        } /*placeholder: {
            ProgressView()
        }*/
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ContentView()
}*/

//Validating and disabling forms:
/*import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
   var body: some View {
       Form {
           Section {
               TextField("Username: ", text: $username)
               TextField("Email: ", text: $email)
           }
           
           Section {
               Button("Create Account"){
                   print("Creating Account...")
               }
           }
           .disabled(disableForm)
       }
   }
}

#Preview {
   ContentView()
}*/

//haptics:
import CoreHaptics
import SwiftUI
struct ContentView: View {
    
    @State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap Count: \(counter)", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
            //counter += 1
            //complexSuccess()
        //.sensoryFeedback(.increase, trigger: counter)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try? engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}


#Preview {
   ContentView()
}
