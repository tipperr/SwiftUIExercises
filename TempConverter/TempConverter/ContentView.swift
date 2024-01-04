//
//  ContentView.swift
//  TempConverter
//
//  Created by Ciaran Murphy on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var inputUnit = "C"
    @State private var outputUnit = "F"
    @FocusState private var amountIsFocused: Bool
    
    let inputUnits = ["C", "F", "K", "R"]
    let outputUnits = ["C", "F", "K", "R"]
    
    var convertToCentigrade: Double{
        if inputUnit == "C" {
            return inputTemperature
        } else if inputUnit == "F" {
            return ((inputTemperature - 32.0) * (5/9))
        } else if inputUnit == "K" {
            return (inputTemperature - 273.0)
        } else if inputUnit == "R" {
            return ((inputTemperature - 491.67) * (5/9))
        } else {
            return 0
        }
    }
    
    var convertedUnit: Double{
        if outputUnit == "C"{
            return convertToCentigrade
        } else if outputUnit == "F"{
            return convertToCentigrade * (9/5) + 32.0
        } else if outputUnit == "K"{
            return convertToCentigrade + 273.0
        } else if outputUnit == "R" {
            return convertToCentigrade * (9/5) + 491.67
        } else {
            return 0
        }
    }

    
    var body: some View {
        
        NavigationStack{
            Form{
                Section("Input Degrees"){
                    TextField("Input Temperature", value: $inputTemperature, format:.number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("Input Units"){
                    Picker("Input Units", selection: $inputUnit){
                        ForEach(inputUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                /*Section("Converted to Centigrade"){
                    Text(convertToCentigrade, format:.number)
                }*/
                
                Section("Output Units"){
                    Picker("Output Units", selection: $outputUnit){
                        ForEach(outputUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Degrees"){
                    Text("\(convertedUnit.formatted(.number.precision(.fractionLength(1))))°")
                }
            }
            .navigationTitle("TempConverter")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }

}

#Preview {
    ContentView()
}
