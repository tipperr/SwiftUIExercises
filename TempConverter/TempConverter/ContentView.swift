//
//  ContentView.swift
//  TempConverter
//
//  Created by Ciaran Murphy on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    
    let inputUnits = ["Celsius", "Fahrenheit", "Kelvin", "Rankine"]
    let outputUnits = ["Celsius", "Fahrenheit", "Kelvin", "Rankine"]
    
    var convertToCentigrade: Double{
        if inputUnit == "Celsius" {
            return inputTemperature
        } else if inputUnit == "Fahrenheit" {
            return (inputTemperature - 32.0) * (5/9)
        } else if inputUnit == "Kelvin" {
            return inputTemperature - 273.0
        } else {
            return (inputTemperature - 491.67) * (5/9)
        }
    }
    
    var convertedUnit: Double{
        if outputUnit == "Celsius"{
            return inputTemperature
        } else if outputUnit == "Fahrenheit"{
            return convertToCentigrade * (9/5) + 32.0
        } else if outputUnit == "Kelvin"{
            return convertToCentigrade + 273.0
        } else {
            return convertToCentigrade * (9/5) + 491.67
        }
    }

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
