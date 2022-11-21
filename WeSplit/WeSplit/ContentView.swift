//
//  ContentView.swift
//  WeSplit
//
//  Created by Matheus Winand on 10/26/20.
//  Copyright © 2020 Matheus Winand. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = ( orderAmount / 100 ) * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
                Form {
                    Section {
                        TextField("Amount due", text: $checkAmount)
                            //.keyboardType(.decimalPad) did not work
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section(header: Text("How much do you want to leave?")) {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0 ..< tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }
                            .pickerStyle(SegmentedPickerStyle())
                    }
                    Section {
                        Text("$\(totalPerson, specifier: "%.2f")")
                    }
                }
                    .navigationBarTitle("WeSplit")
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
