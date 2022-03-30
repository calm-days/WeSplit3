//
//  ContentView.swift
//  WeSplit3
//
//  Created by Роман Люкевич on 11/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPecentages = [0, 5, 10, 15, 20]
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection/100)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPecentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("How much do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Average per person")
                }
                
                Section {
                    Text(totalPerPerson * Double(numberOfPeople+2), format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount with tips")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
