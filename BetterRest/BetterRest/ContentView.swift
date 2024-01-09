//
//  ContentView.swift
//  BetterRest
//
//  Created by Ciaran Murphy on 1/8/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        
        NavigationStack {
            Form{
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter a time: ", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Section(header: Text("Desired amount of sleep: ")){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                /*Section(header: Text("Daily coffee intake: "))/*(alignment: .leading)*/{
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }*/
                
                Section(header: Text("Daily coffee intake: "))/*(alignment: .leading)*/{
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount){
                        ForEach(1...20, id:\.self){ cupCount in
                            Text("\(cupCount)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header: Text("Your ideal bedtime is:")){
                        Text(alertMessage)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear {
                                    calculateBedTime()
                                }
                                .onChange(of: wakeUp) { _ in
                                    calculateBedTime()
                                }
                                .onChange(of: sleepAmount) { _ in
                                    calculateBedTime()
                                }
                                .onChange(of: coffeeAmount) { _ in
                                    calculateBedTime()
                                }

                    }
            
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
        }
        
        //These pieces were just for experimentation
        /*Text(Date.now, format: .dateTime.hour().minute())
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
            .labelsHidden()*/
        //Experiments done
    }
    
    func exampleDates() {
        //playing with Dates
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = now...tomorrow
        
        //playing with DateComponents
        /*var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now*/
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minutes = components.minute ?? 0
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let componets = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (componets.hour ?? 0) * 60 * 60
            let minute = (componets.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem"
            showingAlert = true
        }
    }
}

#Preview {
    ContentView()
}
