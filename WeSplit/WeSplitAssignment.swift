//
//  WeSplitAssignment.swift
//  WeSplit
//
//  Created by mac on 30/03/2024.
//

import SwiftUI

struct WeSplitAssignment: View {
    @State private var inputValue = ""
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 2
    @FocusState private var amountIsFocused: Bool
        
    let units = ["Liters", "Milliliters", "Cups", "Pints"]
    
    var convertedValue: Double {
        let input = Double(inputValue) ?? 0
        let inputInMilliliters = convertToMilliliters(value: input, from: units[selectedInputUnit])
        return convertFromMilliliters(value: inputInMilliliters, to: units[selectedOutputUnit])
    }
       
    func convertToMilliliters(value: Double, from unit: String) -> Double {
        switch unit {
            case "Liters":
                return value * 1000
            case "Milliliters":
                return value
            case "Cups":
                return value * 236.588
            case "Pints":
                return value * 473.176
            default:
                return 0
        }
    }
       
    func convertFromMilliliters(value: Double, to unit: String) -> Double {
        switch unit {
            case "Liters":
                return value / 1000
            case "Milliliters":
                return value
            case "Cups":
                return value / 236.588
            case "Pints":
                return value / 473.176
            default:
                return 0
        }
    }
        
    var body: some View{
        NavigationStack{
            Form{
                Section("Enter Input Value") {
                    TextField(
                        "Enter Value",
                        text: $inputValue
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                
                Section("Enter Input Unit") {
                    Picker("Select unit", selection: $selectedInputUnit) {
                        ForEach(0 ..< units.count, id: \.self) { index in
                            Text("\(self.units[index])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter Output Unit") {
                    Picker("Select unit", selection: $selectedOutputUnit) {
                        ForEach(0 ..< units.count, id: \.self) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Value") {
                    Text(
                        convertedValue,
                        format: .number
                    )
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar{
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


#Preview {
    WeSplitAssignment()
}
