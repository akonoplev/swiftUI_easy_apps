//
//  ContentView.swift
//  WeSplit
//
//  Created by Андрей Коноплев on 14.10.2022.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 300.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10

    private var currencyCode = Locale.current.currency?.identifier ?? "USD"

    let tipPercentages = [10, 15, 20, 0, 25]

    @FocusState
    private var isKeyboardFocused: Bool

    var totalAmountPerPerson: Double {
        let tipsSelection = Double(tipPercentage)
        let peopleCount = Double(numberOfPeople + 2)
        let tips = checkAmount + (Double(tipsSelection / 100)) * Double(checkAmount)
        let total = (checkAmount + tips) / peopleCount
        return total
    }

    var totalAmount: Double {
        let tipsSelection = Double(tipPercentage)
        let amountOfTips = checkAmount + (checkAmount * (tipsSelection / 100))
        let total = checkAmount + amountOfTips
        return total
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($isKeyboardFocused)
                    Picker("Number Of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) guys")
                        }
                    }
                }

                Section {
                    Picker("number of percetage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tips do you want to leave?")
                }

                Section {
                    Text(totalAmountPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Amount per person")
                }

                Section {
                    Text(totalAmount, format: .currency(code: currencyCode))
                } header: {
                    Text("Total amount with tips")
                }
            }
            .navigationTitle("Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Hide keyboard") {
                        isKeyboardFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
